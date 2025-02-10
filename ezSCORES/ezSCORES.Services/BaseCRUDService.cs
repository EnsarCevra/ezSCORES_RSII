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
			Context.Add(entity);
			Context.SaveChanges();

			return Mapper.Map<TModel>(entity);
		}
		public virtual void BeforeInsert(TInsert request, TDbEntity entity)
		{

		}

		public TModel Update(int id, TUpdate request)
		{
			var set = Context.Set<TDbEntity>();

			var entity = set.Find(id);

			Mapper.Map(request, entity);

			Context.SaveChanges();

			return Mapper.Map<TModel>(entity);
		}

		public virtual void BeforeUpdate(TUpdate request, TDbEntity entity)
		{

		}
	}
}
