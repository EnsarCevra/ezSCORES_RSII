using ezSCORES.Model;
using ezSCORES.Model.DTOs;
using ezSCORES.Model.Requests;
using ezSCORES.Model.Requests.MatchRequests;
using ezSCORES.Model.Requests.TeamsRequests;
using ezSCORES.Model.SearchObjects;
using ezSCORES.Services;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace ezSCORES.API.Controllers
{
    [Route("api/[controller]")]
	[ApiController]
	public class MatchesController : BaseCRUDController<Matches, MatchSearchObject, MatchInsertRequest, MatchUpdateRequest>
	{
		public MatchesController(IMatchesService service) : base (service)
		{
		}
		[HttpGet("get-match-details/{id}")]
		public MatchDTO GetMatchDetails(int id)
		{
			return (_service as IMatchesService).GetMatchDetails(id);
		}
		[HttpPatch("{id}/start-match")]
		public void StartMatch(int id)
		{
			(_service as IMatchesService).StartMatch(id);
		}

		[HttpPatch("{id}/finish-match")]
		public void FinishFixture(int id, FinishMatchRequest request)
		{
			(_service as IMatchesService).FinishMatch(id, request);
		}
	}
}
