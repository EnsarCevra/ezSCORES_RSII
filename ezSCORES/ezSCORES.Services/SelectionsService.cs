using ezSCORES.Model;
using ezSCORES.Model.Requests;
using ezSCORES.Model.Requests.TeamsRequests;
using ezSCORES.Model.SearchObjects;
using ezSCORES.Services.Database;
using Mapster;
using MapsterMapper;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ezSCORES.Services
{
    public class SelectionsService : BaseCRUDService<Selections, BaseSearchObject, Selection,SelectionUpsertRequest, SelectionUpsertRequest>, ISelectionsService
	{
		public SelectionsService(EzScoresdbRsiiContext context, IMapper mapper) : base(context, mapper)
		{
		}

		public override IQueryable<Selection> AddFilter(BaseSearchObject search, IQueryable<Selection> query)
		{
			query = query.OrderBy(s => s.Name == "Veterani" ? 0 : s.Name == "Seniori" ? 1 : 2)
				.ThenByDescending(s => s.AgeMax.HasValue ? s.AgeMax.Value : int.MaxValue);
			return query;
		}
	}
}
