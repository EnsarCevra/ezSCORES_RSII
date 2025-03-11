using ezSCORES.Model;
using ezSCORES.Model.Requests.GoalRequests;
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
    public class GoalsService : BaseCRUDService<Goals, GoalSearchObject, Goal,GoalInsertRequest, GoalUpdateRequest>, IGoalsService
	{
		public GoalsService(EzScoresdbRsiiContext context, IMapper mapper) : base(context, mapper)
		{
		}

		public override IQueryable<Goal> AddFilter(GoalSearchObject search, IQueryable<Goal> query)
		{
			if(search.MatchId != null)
			{
				query = query.Where(x => x.MatchId == search.MatchId)
					.OrderBy(x=>x.SequenceNumber)
					.Include(x=>x.CompetitionTeamPlayer).ThenInclude(x=>x.Player);
			}
			return query;
		}
	}
}
