using ezSCORES.Model;
using ezSCORES.Model.Requests;
using ezSCORES.Model.Requests.ApplicationRequests;
using ezSCORES.Model.Requests.CompetitionTeamsRequests;
using ezSCORES.Model.Requests.TeamsRequests;
using ezSCORES.Model.SearchObjects;
using ezSCORES.Services;
using ezSCORES.Services.Database;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace ezSCORES.API.Controllers
{
    [Route("api/[controller]")]
	[ApiController]
	public class CompetitionTeamsController : BaseCRUDController<CompetitionsTeams, CompetitionTeamsSearchObject, CompetitionTeamInsertRequest, CompetitionTeamUpdateRequest>
	{
		public CompetitionTeamsController(ICompetitionTeamsService service) : base (service)
		{
		}
		[HttpPatch("assign-group")]
		[Authorize(Roles = Model.Constants.Roles.Admin + "," + Model.Constants.Roles.Organizer)]
		public void AddTeamsToGroup(AddTeamsToGroupRequest request)
		{
			(_service as ICompetitionTeamsService).AddTeamsToGroup(request);
		}
	}
}
