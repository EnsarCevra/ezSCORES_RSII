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
		public override void BeforeInsert(GoalInsertRequest request, Goal entity)
		{
			var match = Context.Matches.Where(x => x.Id == entity.MatchId).
				Select(x => new
				{
					Match = x,
					MatchLength = x.Fixture.MatchLength 
				}).FirstOrDefault();
			if(request.ScoredAtMinute < 0 || request.ScoredAtMinute > match!.MatchLength)
			{
				throw new UserException($"Unijeli ste sljedeci minut pogotka:{request.ScoredAtMinute}, a utakmica traje {match!.MatchLength} minuta!");
			}
			if (request.CompetitionTeamPlayerId != null)
			{
				var playerTeamId = Context.CompetitionsTeamsPlayers.Where(x => x.Id == request.CompetitionTeamPlayerId)
					.Select(x => x.CompetitionsTeamsId).FirstOrDefault();
				if((request.IsHomeGoal && match.Match.HomeTeamId!=playerTeamId) ||
					(!request.IsHomeGoal && match.Match.AwayTeamId != playerTeamId))
				{
					throw new UserException("Odabrani strijelac nije član ekipe koja je postigla pogodak!");
				}
			}
		}
	}
}
