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
using System.Security;
using System.Text;
using System.Threading.Tasks;
using static Microsoft.EntityFrameworkCore.DbLoggerCategory;

namespace ezSCORES.Services
{
    public class CompetitionsTeamsPlayersService : BaseCRUDService<CompetitionsTeamsPlayers, CompetitionTeamsPlayersSearchObject, CompetitionsTeamsPlayer,CompetitionTeamsPlayerUpsertRequest, CompetitionTeamsPlayerUpsertRequest>, ICompetitionsTeamsPlayersService
	{
		private readonly IApplicationService _applicationService;
		public CompetitionsTeamsPlayersService(EzScoresdbRsiiContext context, IMapper mapper, IApplicationService applicationService) : base(context, mapper)
		{
			_applicationService = applicationService;
		}

		public override IQueryable<CompetitionsTeamsPlayer> AddFilter(CompetitionTeamsPlayersSearchObject search, IQueryable<CompetitionsTeamsPlayer> query)
		{
			if(search.CompetitionId != null)
			{
				query = query.Where(x => x.CompetitionsTeams.CompetitionId == search.CompetitionId).Include(x => x.Player);
			}
			if(search.CompetitionTeamId != null) 
			{
				query = query.Where(x => x.CompetitionsTeamsId == search.CompetitionTeamId).Include(x=>x.Player);
			}
			return base.AddFilter(search, query);
		}
		protected override CompetitionsTeamsPlayer? ApplyIncludes(int id, DbSet<CompetitionsTeamsPlayer> set)
		{
			return set.Where(x=>x.Id == id).Include(x => x.Player).FirstOrDefault();
		}
		public override void BeforeInsert(CompetitionTeamsPlayerUpsertRequest request, CompetitionsTeamsPlayer entity)
		{
			base.BeforeInsert(request, entity);
			List<int> player = [request.PlayerId];
			var competitionId = Context.CompetitionsTeams.Find(request.CompetitionsTeamsId)?.CompetitionId;
			if(competitionId == null)
			{
				throw new UserException("Odabrani tim ne postoji!");//compeitionId must be inserted so if its null that means CompetitionTeams doesn't exist
			}
			_applicationService.ValidatePlayers(player, competitionId.Value);
		}
	}
}
