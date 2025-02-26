using ezSCORES.Model;
using ezSCORES.Model.Requests;
using ezSCORES.Model.Requests.GroupRequests;
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
    public class GroupesService : BaseCRUDService<Groups, GroupSearchObject, Group,GroupInsertRequest, GroupUpdateRequest>, IGroupsService
	{
		public GroupesService(EzScoresdbRsiiContext context, IMapper mapper) : base(context, mapper)
		{
		}

		public override IQueryable<Group> AddFilter(GroupSearchObject search, IQueryable<Group> query)
		{
			if(search.CompetitionId != null)
			{
				query = query.Where(x => x.CompetitionId == search.CompetitionId).Include(x=>x.CompetitionsTeams).ThenInclude(x=>x.Team);
			}
			return query;
		}
	}
}
