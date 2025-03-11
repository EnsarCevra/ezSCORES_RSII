using ezSCORES.Model;
using ezSCORES.Model.Requests.TeamsRequests;
using ezSCORES.Model.SearchObjects;
using ezSCORES.Services.Auth;
using ezSCORES.Services.Database;
using Mapster;
using MapsterMapper;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Internal;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Linq.Dynamic.Core;
using System.Security.Claims;
using System.Text;
using System.Threading.Tasks;

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
			base.AddFilter(search, query);
			if(search.SelectionId != null)
			{
				query = query.Where(x => x.SelectionId == search.SelectionId);
			}
			if(search.OnlyUsersTeams)
			{
				query = query.Where(x => x.UserId == _activeUserService.GetActiveUserId()).Include(x=>x.Selection);
				if (search.IncludeTeamsThatAlreadyAppliedForCompetition != null)
				{
					if (search.IncludeTeamsThatAlreadyAppliedForCompetition == false)
					{
						// dont know how to implement this yet
					}
				}
			}
			return query;
		}

		public override void BeforeInsert(TeamsInsertRequest request, Team entity)
		{
			//no validation required for now
		}
		protected override IQueryable<Team> ApplyIncludes(IQueryable<Team> query)
		{
			return query.Include(x => x.Selection);
			
		}
	}
}
