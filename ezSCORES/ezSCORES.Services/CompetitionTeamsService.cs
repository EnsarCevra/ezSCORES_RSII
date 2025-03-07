﻿using ezSCORES.Model;
using ezSCORES.Model.Requests;
using ezSCORES.Model.Requests.CompetitionTeamsRequests;
using ezSCORES.Model.Requests.TeamsRequests;
using ezSCORES.Model.SearchObjects;
using ezSCORES.Services.Database;
using Mapster;
using MapsterMapper;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.InteropServices;
using System.Text;
using System.Threading.Tasks;

namespace ezSCORES.Services
{
    public class CompetitionTeamsService : BaseCRUDService<CompetitionsTeams, CompetitionTeamsSearchObject, CompetitionsTeam,CompetitionTeamInsertRequest, CompetitionTeamUpdateRequest>, ICompetitionTeamsService
	{
		public CompetitionTeamsService(EzScoresdbRsiiContext context, IMapper mapper) : base(context, mapper)
		{
		}

		public override IQueryable<CompetitionsTeam> AddFilter(CompetitionTeamsSearchObject search, IQueryable<CompetitionsTeam> query)
		{
			if(search.CompetitionId != null)
			{
				query = query.Where(x => x.CompetitionId == search.CompetitionId).Include(x=>x.Team);
			}
			if(search.isPlayersIncluded != null)
			{
				query = query.Include(x => x.CompetitionsTeamsPlayers).ThenInclude(x => x.Player);
			}
			return query;
		}
	}
}
