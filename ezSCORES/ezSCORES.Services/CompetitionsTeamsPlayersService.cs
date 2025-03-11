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

namespace ezSCORES.Services
{
    public class CompetitionsTeamsPlayersService : BaseCRUDService<CompetitionsTeamsPlayers, CompetitionTeamsPlayersSearchObject, CompetitionsTeamsPlayer,CompetitionTeamsPlayerUpsertRequest, CompetitionTeamsPlayerUpsertRequest>, ICompetitionsTeamsPlayersService
	{
		public CompetitionsTeamsPlayersService(EzScoresdbRsiiContext context, IMapper mapper) : base(context, mapper)
		{
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
			return query;
		}

		protected override IQueryable<CompetitionsTeamsPlayer> ApplyIncludes(IQueryable<CompetitionsTeamsPlayer> query)
		{
			return query.Include(x => x.Player);
		}

		public override void BeforeInsert(CompetitionTeamsPlayerUpsertRequest request, CompetitionsTeamsPlayer entity)
		{
			base.BeforeInsert(request, entity);
			//this is being trigerred when Player is inserted on a team that is already on competition
		}
	}
}
