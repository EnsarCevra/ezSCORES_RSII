using ezSCORES.Model;
using ezSCORES.Model.Requests;
using ezSCORES.Model.Requests.CompetitionsRefereesRequests;
using ezSCORES.Model.Requests.TeamsRequests;
using ezSCORES.Model.SearchObjects;
using ezSCORES.Services.Database;
using Mapster;
using MapsterMapper;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ezSCORES.Services
{
    public class CompetitionsRefereesService : BaseCRUDService<CompetitionsReferees, BaseCompetitionSearchObject, CompetitionsReferee,CompetitionRefereeInsertRequest, CompetitionRefereeUpdateRequest>, ICompetitionsRefereesService
	{
		public CompetitionsRefereesService(EzScoresdbRsiiContext context, IMapper mapper) : base(context, mapper)
		{
		}

		public override IQueryable<CompetitionsReferee> AddFilter(BaseCompetitionSearchObject search, IQueryable<CompetitionsReferee> query)
		{
			if(search.CompetitionId != null)
			{
				query = query.Where(x => x.CompetitionId == search.CompetitionId).Include(x=>x.Referee);
			}
			return base.AddFilter(search, query);
		}
	}
}
