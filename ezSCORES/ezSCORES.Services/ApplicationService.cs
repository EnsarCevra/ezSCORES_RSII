using ezSCORES.Model;
using ezSCORES.Model.Requests;
using ezSCORES.Model.Requests.ApplicationRequests;
using ezSCORES.Model.Requests.CompetitionRequests;
using ezSCORES.Model.Requests.TeamsRequests;
using ezSCORES.Model.SearchObjects;
using ezSCORES.Services.Database;
using Mapster;
using MapsterMapper;
using Microsoft.EntityFrameworkCore;
using Microsoft.IdentityModel.Tokens;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ezSCORES.Services
{
    public class ApplicationService : BaseCRUDService<Applications, ApplicationSearchObject, Application,ApplicationInsertRequest, ApplicationUpdateRequest>, IApplicationService
	{
		public ApplicationService(EzScoresdbRsiiContext context, IMapper mapper) : base(context, mapper)
		{
		}

		public override IQueryable<Application> AddFilter(ApplicationSearchObject search, IQueryable<Application> query)
		{
			//filter by status?
			if(search.CompetitionId != null)
			{
				query = query.Where(x => x.CompetitionId == search.CompetitionId).Include(x => x.Team).ThenInclude(x => x.User);
			}
			return query;
		}
		protected override IQueryable<Application> ApplyIncludes(IQueryable<Application> query)
		{
			return query.Include(x => x.Team)
							.ThenInclude(x => x.User)
							.Include(x => x.Team)
							.ThenInclude(x => x.CompetitionsTeams)
							.ThenInclude(x => x.CompetitionsTeamsPlayers)
							.ThenInclude(x=>x.Player);
		}

		public override void BeforeInsert(ApplicationInsertRequest request, Application entity)
		{
			base.BeforeInsert(request, entity);
			//validation required
			if (Context.CompetitionsTeams.Where(x => (x.TeamId == request.TeamId) && !x.IsDeleted).Any())
			{
				throw new UserException("Ovaj tim je već prijavljen na takmičenje!");
			}
			var existingPlayersOnCompetition = Context.CompetitionsTeamsPlayers
				.Where(x => request.PlayerIds.Contains(x.PlayerId) && x.CompetitionsTeams.CompetitionId == request.CompetitionId)
				.Select(x => x.PlayerId)
				.ToList();
			if (!existingPlayersOnCompetition.IsNullOrEmpty())
			{
				throw new UserException($"Sljedeći igrači su već registrirani na takmičenju: {string.Join(",", existingPlayersOnCompetition)}");
			}
			CompetitionsTeam competitionTeamEntity = Mapper.Map<CompetitionsTeam>(request);
			if (competitionTeamEntity is ICreated created)
			{
				created.CreatedAt = DateTime.Now;
			}
			Context.Add(competitionTeamEntity);
			Context.SaveChanges();
			foreach (var playerId in request.PlayerIds)
			{
				var competitionTeamPlayer = new CompetitionsTeamsPlayer
				{
					CompetitionsTeamsId = competitionTeamEntity.Id,
					PlayerId = playerId,
					CreatedAt = DateTime.Now
				};
				Context.Add(competitionTeamPlayer);
			}
			Context.SaveChanges();
		}
		public override void AfterInsert(ApplicationInsertRequest request, Application entity)
		{

		}
	}
}
