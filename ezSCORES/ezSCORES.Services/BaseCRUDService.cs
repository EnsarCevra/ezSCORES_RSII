using Azure.Core;
using ezSCORES.Model;
using ezSCORES.Model.SearchObjects;
using ezSCORES.Services.Database;
using MapsterMapper;
using Microsoft.AspNetCore.Http;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using static Microsoft.EntityFrameworkCore.DbLoggerCategory;

namespace ezSCORES.Services
{
	public abstract class BaseCRUDService<TModel, TSsearch, TDbEntity, TInsert, TUpdate> : BaseService<TModel, TSsearch, TDbEntity> where TModel : class where TSsearch : BaseSearchObject where TDbEntity : class
	{
		public BaseCRUDService(EzScoresdbRsiiContext context, IMapper mapper) : base(context, mapper)
		{
			
		}

		public virtual TModel Insert(TInsert request)
		{
			TDbEntity entity = Mapper.Map<TDbEntity>(request);
			BeforeInsert(request, entity);
			if(entity is ICreated created)
			{
				created.CreatedAt = DateTime.Now;
			}
			Context.Add(entity);
			Context.SaveChanges();
			AfterInsert(request, entity);
			return Mapper.Map<TModel>(entity);
		}
		public virtual void BeforeInsert(TInsert request, TDbEntity entity)
		{
			var property = typeof(TDbEntity).GetProperty("Name");
			if (property != null && (entity is IHasName nameEntity))
			{
				if(Context.Set<TDbEntity>().Any(x => EF.Property<string>(x, "Name") == nameEntity.Name))
				{
					throw new UserException("Entitet sa ovim imenom već postoji!");
				}
			}
		}
		public virtual void AfterInsert(TInsert request, TDbEntity entity)	{   }

		public virtual TModel Update(int id, TUpdate request)
		{
			var set = Context.Set<TDbEntity>();

			var entity = set.Find(id);

			BeforeUpdate(request, entity);

			Mapper.Map(request, entity);

			if(entity is IModified modified)
			{
				modified.ModifiedAt = DateTime.Now;
			}

			Context.SaveChanges();
			AfterUpdate(request, entity);

			return Mapper.Map<TModel>(entity);
		}
		public virtual void Delete(int id)
		{
			var set = Context.Set<TDbEntity>();

			//var entity = set.Find(id);

			var entity = BeforeDelete(id, set);

			if(entity == null)
			{
				throw new Exception("Selected entity doesn't exist");
			}

			//if(entity is ISoftDelete softDeleteEntity)
			//{
			//	softDeleteEntity.IsDeleted = true;
			//	softDeleteEntity.RemovedAt = DateTime.Now;
			//	Context.Update(entity);
			//}
			//else
			//{
			//	Context.Remove(entity);
			//}

			CascadeSoftDelete(entity);

			Context.SaveChanges();
		}
		public virtual void BeforeUpdate(TUpdate request, TDbEntity entity)
		{
			var property = typeof(TDbEntity).GetProperty("Name");
			if (property != null && (entity is IHasName nameEntity))
			{
				if (Context.Set<TDbEntity>().Any(x => EF.Property<string>(x, "Name") == nameEntity.Name))
				{
					throw new UserException("Entitet sa ovim imenom već postoji!");
				}
			}
		}
		public virtual void AfterUpdate(TUpdate request, TDbEntity entity) { }
		public virtual TDbEntity? BeforeDelete(int id, DbSet<TDbEntity> set) 
		{
			//if overriden it means there are related records in other tables and they have to be included so cascade delete can work
			return set.Find(id);
		}

		private void CascadeSoftDelete(object entity)
		{
			if (entity is not ISoftDelete deletableEntity)
				return; // Skip non-soft deletable entities

			deletableEntity.IsDeleted = true;
			deletableEntity.RemovedAt = DateTime.Now;

			var entityType = Context.Model.FindEntityType(entity.GetType());

			foreach (var navigation in entityType.GetNavigations())
			{
				if (navigation.IsCollection)
				{
					var relatedEntities = Context.Entry(entity)
						.Collection(navigation.Name)
						.CurrentValue as IEnumerable<object>;

					if (relatedEntities != null)
					{
						foreach (var relatedEntity in relatedEntities)
						{
							CascadeSoftDelete(relatedEntity);
						}
					}
				}
			}
		}
	}
}
