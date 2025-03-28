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
		private readonly IApplicationService _applicationService;
		public CompetitionTeamsService(EzScoresdbRsiiContext context, IMapper mapper, IApplicationService applicationService) : base(context, mapper)
		{
			_applicationService = applicationService;
		}

		public override IQueryable<CompetitionsTeam> AddFilter(CompetitionTeamsSearchObject search, IQueryable<CompetitionsTeam> query)
		{
			if(search.CompetitionId != null)
			{
				query = query.Where(x => x.CompetitionId == search.CompetitionId).Include(x=>x.Team);
			}
			if (search.isEliminated != null)
			{
				query = query.Where(x => x.IsEliminated == search.isEliminated);
			}
			if (search.GroupId != null)
			{
				query = query.Where(x => x.GroupId == search.GroupId);
			}
			if (search.isPlayersIncluded != null)
			{
				query = query.Include(x => x.CompetitionsTeamsPlayers).ThenInclude(x => x.Player);
			}
			return base.AddFilter(search, query);
		}

		public void AddTeamsToGroup(AddTeamsToGroupRequest request)
		{
			var alreadyAssignedTeams = Context.CompetitionsTeams.Where(x => request.CompetitionTeamIds.Contains(x.Id) && x.GroupId == null).ToList();
			if(alreadyAssignedTeams.Any())
			{
				throw new UserException($"Timovi već dodijeljeni u grupu: {alreadyAssignedTeams}");
			}
			var teams = Context.CompetitionsTeams.Where(x => request.CompetitionTeamIds.Contains(x.Id)
														&& x.GroupId != request.GroupId);// take only teams that are not already in this group
			// if I send non existant competitionTeamId it will ignore it
			if(teams.Any() && teams.All(x=>x.CompetitionId == request.CompetitionId))
			{
				foreach (var team in teams)
				{
					team.GroupId = request.GroupId;
				}
				Context.SaveChanges();
			}
			else
			{
				throw new UserException("Dodavanje nije moguće - jedan ili više odabranih timova ne pripada takmičenju");
			}
			
		}

		public override void BeforeInsert(CompetitionTeamInsertRequest request, CompetitionsTeam entity)
		{
			base.BeforeInsert(request, entity);
			//don't know if this endpoint will ever be triggered since teams are added through apllications and not manually
			_applicationService.ValidateTeam(request.TeamId, request.CompetitionId);
		}
	}
}
