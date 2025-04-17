using ezSCORES.Model;
using ezSCORES.Model.Requests.ApplicationRequests;
using ezSCORES.Model.Requests.TeamsRequests;
using ezSCORES.Model.SearchObjects;
using ezSCORES.Services.Auth;
using ezSCORES.Services.Database;
using Mapster;
using MapsterMapper;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Internal;
using Microsoft.VisualBasic;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Linq.Dynamic.Core;
using System.Security.Claims;
using System.Text;
using System.Threading.Tasks;
using static Microsoft.EntityFrameworkCore.DbLoggerCategory;

namespace ezSCORES.Services
{
    public class TeamsService : BaseCRUDService<Teams, TeamsSearchObject, Team, TeamsInsertRequest, TeamsUpdateRequest>, ITeamsService
	{
		private readonly IActiveUserService _activeUserService;
		public TeamsService(EzScoresdbRsiiContext context, IMapper mapper, IActiveUserService activeUserService) : base(context, mapper)
		{
			_activeUserService = activeUserService;
		}

		public override IQueryable<Team> AddFilter(TeamsSearchObject search, IQueryable<Team> query)
		{
			query = query.Include(x => x.Selection);
			if(search.SelectionId != null)
			{
				query = query.Where(x => x.SelectionId == search.SelectionId);
			}
			if(search.OnlyUsersTeams && _activeUserService.GetActiveUserRole() == Model.Constants.Roles.Manager)//used when applying to a new competition when we don't want to show teams with whom user already applied for compeition
			{
				var currrentUserId = _activeUserService.GetActiveUserId();
				query = query.Where(x => x.UserId == currrentUserId).Include(x=>x.Selection);
				if (search.IncludeTeamsThatAlreadyAppliedForCompetition != null)
				{
					if (search.IncludeTeamsThatAlreadyAppliedForCompetition == false && search.CompetitionId != null)
					{
						query = query
							.Where(t => !Context.Applications
								.Any(a => a.TeamId == t.Id && a.CompetitionId == search.CompetitionId && (a.IsAccepted == null || a.IsAccepted == true)));
					}
				}
			}
			return base.AddFilter(search, query);
		}

		public override void BeforeInsert(TeamsInsertRequest request, Team entity)
		{
			entity.UserId = _activeUserService.GetActiveUserId() ?? throw new InvalidOperationException("Authenticated user ID cannot be null.");
		}
		protected override Team? ApplyIncludes(int id, DbSet<Team> set)
		{
			return set.Where(x=>x.Id == id).Include(x => x.Selection).FirstOrDefault();
		}
	}
}
