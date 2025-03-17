using ezSCORES.Model;
using ezSCORES.Model.Requests;
using ezSCORES.Model.Requests.ApplicationRequests;
using ezSCORES.Model.Requests.CompetitionRequests;
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
	public class ApplicationsController : BaseCRUDController<Applications, ApplicationSearchObject, ApplicationInsertRequest, ApplicationUpdateRequest>
	{
		public ApplicationsController(IApplicationService service) : base (service)
		{
		}

		[HttpPatch("{id}/toggle-status")]
		[Authorize(Roles = Model.Constants.Roles.Admin + "," + Model.Constants.Roles.Organizer)]
		public Applications ToogleStatus(int id, ToogleStatusRequest request)
		{
			return (_service as IApplicationService).ToogleStatus(id, request);
		}
		[HttpPost("/validate-team")]
		public void ValidateTeam(ValidateTeamRequest request)
		{
			(_service as IApplicationService).ValidateTeam(request.TeamId, request.CompetitionId);
		}
		[HttpPost("/validate-players")]
		public void ValidatePlayers(ValidatePlayersRequest request)
		{
			(_service as IApplicationService).ValidatePlayers(request.PlayerIds, request.CompetitionId);
		}
	}
}
