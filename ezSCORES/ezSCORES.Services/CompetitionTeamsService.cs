using ezSCORES.Model;
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
			if (search.CompetitionId != null)
			{
				query = query.Where(x => x.CompetitionId == search.CompetitionId).Include(x=>x.Team);
			}
			if(search.TeamId != null)
			{
				query = query.Where(x => x.TeamId == search.TeamId).Include(x => x.Team);
			}
			if (search.IsEliminated != null)
			{
				query = query.Where(x => x.IsEliminated == search.IsEliminated);
			}
			if (search.GroupId != null && search.OnlyNullAndCurrentGroup == null)
			{
				query = query.Where(x => x.GroupId == search.GroupId).Include(x=>x.Team);
			}
			if(search.OnlyNullAndCurrentGroup != null && search.GroupId != null)
			{
				if(search.OnlyNullAndCurrentGroup == true)
				{
					query = query.Where(x => x.GroupId == null || x.GroupId == search.GroupId);
				}
			}
			if (search.IncludeDeletedRecords != null)
			{
				var app = Context.Applications
					.AsNoTracking()
					.FirstOrDefault(a => a.Id == search.ApplicationId);
				if (app != null)
				{
					query = query.IgnoreQueryFilters();
					query = query.Where(ct => ct.TeamId == app.TeamId &&
										 ct.CompetitionId == app.CompetitionId)
										.OrderBy(ct => Math.Abs(EF.Functions.DateDiffMillisecond(ct.CreatedAt, app.CreatedAt)))
										.Take(1);
				}
			}
			if (search.IsPlayersIncluded != null)
			{
				query = query.Include(x => x.CompetitionsTeamsPlayers).ThenInclude(x => x.Player);
			}
			return base.AddFilter(search, query);
		}

		public void AddTeamsToGroup(AddTeamsToGroupRequest request)
		{
			var currentlyInGroup = Context.CompetitionsTeams
				.Where(x => x.GroupId == request.GroupId && x.CompetitionId == request.CompetitionId)
				.ToList();

			//if there are teams in database that were previously assigned but user didn't assign them in newest post they need to be removed
			var toUnassign = currentlyInGroup
				.Where(x => !request.CompetitionTeamIds.Contains(x.Id))
				.ToList();

			foreach (var team in toUnassign)
			{
				team.GroupId = null;
			}

			var toAssign = Context.CompetitionsTeams
				.Where(x => request.CompetitionTeamIds.Contains(x.Id) && x.CompetitionId == request.CompetitionId)
				.ToList();

			if (toAssign.Any(x => x.CompetitionId != request.CompetitionId))
			{
				throw new UserException("Jedan ili više timova ne pripada ovom takmičenju.");
			}

			foreach (var team in toAssign)
			{
				team.GroupId = request.GroupId;
			}

			Context.SaveChanges();
		}

		public override void BeforeInsert(CompetitionTeamInsertRequest request, CompetitionsTeam entity)
		{
			base.BeforeInsert(request, entity);
			//don't know if this endpoint will ever be triggered since teams are added through apllications and not manually
			_applicationService.ValidateTeam(request.TeamId, request.CompetitionId);
		}
	}
}
