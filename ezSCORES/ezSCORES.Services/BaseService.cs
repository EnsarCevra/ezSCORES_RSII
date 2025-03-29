using ezSCORES.Model;
using ezSCORES.Model.SearchObjects;
using ezSCORES.Services.Database;
using MapsterMapper;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Linq.Dynamic.Core;
using System.Text;
using System.Threading.Tasks;
using static Microsoft.EntityFrameworkCore.DbLoggerCategory;

namespace ezSCORES.Services
{
	public abstract class BaseService<TModel, TSearch, TDbEntity> : IService<TModel, TSearch> where TSearch : BaseSearchObject where TDbEntity : class where TModel : class
	{
		public EzScoresdbRsiiContext Context { get; set; }
		public IMapper Mapper;
		public BaseService(EzScoresdbRsiiContext context, IMapper mapper)
		{
			Context = context;
			Mapper = mapper;
		}

		public Model.PagedResult<TModel> GetPaged(TSearch search)
		{
			var resultList = new List<TModel>();

			var query = Context.Set<TDbEntity>().AsQueryable();

			query = AddFilter(search, query);

			int count = query.Count();
			if (search?.Page.HasValue == true && search?.PageSize.HasValue == true)
			{
				query = query.Skip(search.Page.Value * search.PageSize.Value).Take(search.PageSize.Value);
			}
			var list = query.ToList();
			resultList = Mapper.Map(list, resultList);
			Model.PagedResult<TModel> result = new Model.PagedResult<TModel>()
			{
				Count = count,
				ResultList = resultList
			};
			return result;
		}
		public virtual IQueryable<TDbEntity> AddFilter(TSearch search, IQueryable<TDbEntity> query)
		{
			if (search.IsDeleted != null)
			{
				if(search.IsDeleted == true)//this is only when user requests for deleted records since Context handles soft delete
				{
					query = query.IgnoreQueryFilters().Where(x => EF.Property<bool>(x, "IsDeleted") == search.IsDeleted);
				}
			}
			if (!string.IsNullOrWhiteSpace(search.Name))
			{
				var property = typeof(TDbEntity).GetProperty("Name");
				if (property != null)
				{
					query = query.Where(x => EF.Property<string>(x, "Name").ToLower().StartsWith(search.Name.ToLower()));
				}
			}
			return query;
		}
		public TModel GetById(int id)
		{
			var set = Context.Set<TDbEntity>();
			var entity = ApplyIncludes(id, set);
			if (entity != null)
			{
				return Mapper.Map<TModel>(entity);
			}
			else
			{
				throw new UserException("Zapis nije pronađen!");
			}
		}

		protected virtual TDbEntity? ApplyIncludes(int id, DbSet<TDbEntity> set){ return set.Find(id); }

		public async Task<TModel> GetByIdAsync(int id)
		{
			var set = Context.Set<TDbEntity>();
			var entity = ApplyIncludes(id, set);
			if (entity != null)
			{
				return Mapper.Map<TModel>(entity);
			}
			else
			{
				throw new UserException("Zapis nije pronađen!");
			}
		}
	}
}
