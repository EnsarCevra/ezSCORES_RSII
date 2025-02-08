using ezSCORES.Model.SearchObjects;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Linq.Dynamic.Core;
using System.Text;
using System.Threading.Tasks;

namespace ezSCORES.Services
{
	public interface IService<TModel, TSearch> where TSearch : BaseSearchObject
	{
		public Model.PagedResult<TModel> GetPaged(TSearch search);	
		public TModel GetById(int id);
	}
}
