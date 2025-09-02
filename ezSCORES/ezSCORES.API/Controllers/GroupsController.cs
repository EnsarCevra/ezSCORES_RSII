using ezSCORES.Model;
using ezSCORES.Model.DTOs;
using ezSCORES.Model.Requests;
using ezSCORES.Model.Requests.GroupRequests;
using ezSCORES.Model.Requests.TeamsRequests;
using ezSCORES.Model.SearchObjects;
using ezSCORES.Services;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace ezSCORES.API.Controllers
{
    [Route("api/[controller]")]
	[ApiController]
	public class GroupsController : BaseCRUDController<Groups, GroupSearchObject, GroupInsertRequest, GroupUpdateRequest>
	{
		public GroupsController(IGroupsService service) : base (service)
		{
		}
		[AllowAnonymous]
		[HttpGet("{competitionId}/get-group-standings")]
		public List<GroupStandingsDTO> GetGroupStandings(int competitionId)
		{
			return (_service as IGroupsService).GetGroupStandings(competitionId);
		}
	}
}
