using Azure.Core;
using ezSCORES.Model;
using ezSCORES.Model.SearchObjects;
using ezSCORES.Services.Database;
using MapsterMapper;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ezSCORES.Services
{
	public abstract class BaseCRUDService<TModel, TSsearch, TDbEntity, TInsert, TUpdate> : BaseService<TModel, TSsearch, TDbEntity> where TModel : class where TSsearch : BaseSearchObject where TDbEntity : class
	{
		public BaseCRUDService(EzScoresdbRsiiContext context, IMapper mapper) : base(context, mapper)
		{
			
		}

		public TModel Insert(TInsert request)
		{
			TDbEntity entity = Mapper.Map<TDbEntity>(request);
			BeforeInsert(request, entity);
			if(entity is ICreated created)
			{
				created.CreatedAt = DateTime.Now;
			}
			Context.Add(entity);
			Context.SaveChanges();

			return Mapper.Map<TModel>(entity);
		}
		public virtual void BeforeInsert(TInsert request, TDbEntity entity)	{	}
		public virtual void AfterInsert(TInsert request, TDbEntity entity)	{   }

		public TModel Update(int id, TUpdate request)
		{
			var set = Context.Set<TDbEntity>();

			var entity = set.Find(id);

			Mapper.Map(request, entity);

			if(entity is IModified modified)
			{
				modified.ModifiedAt = DateTime.Now;
			}

			Context.SaveChanges();

			return Mapper.Map<TModel>(entity);
		}
		public virtual void Delete(int id)
		{
			var set = Context.Set<TDbEntity>();

			var entity = set.Find(id);

			if(entity == null)
			{
				throw new Exception("Selected entity doesn't exist");
			}

			if(entity is ISoftDelete softDeleteEntity)
			{
				softDeleteEntity.IsDeleted = true;
				softDeleteEntity.RemovedAt = DateTime.Now;
				Context.Update(entity);
			}
			else
			{
				Context.Remove(entity);
			}
			Context.SaveChanges();
		}
		public virtual void BeforeUpdate(TUpdate request, TDbEntity entity)	{	}
		public virtual void AfterUpdate(TUpdate request, TDbEntity entity) { }
	}
}
