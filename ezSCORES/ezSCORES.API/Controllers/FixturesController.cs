using ezSCORES.Model;
using ezSCORES.Model.DTOs;
using ezSCORES.Model.Requests;
using ezSCORES.Model.Requests.FixtureRequests;
using ezSCORES.Model.Requests.GroupRequests;
using ezSCORES.Model.Requests.TeamsRequests;
using ezSCORES.Model.SearchObjects;
using ezSCORES.Services;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace ezSCORES.API.Controllers
{
    [Route("api/[controller]")]
	[ApiController]
	public class FixturesController : BaseCRUDController<Fixtures, BaseCompetitionSearchObject, FixtureInsertRequest, FixtureUpdateRequest>
	{
		public FixturesController (IFixturesService service) : base (service)
		{
		}

		[HttpPatch("{id}/activate-fixture")]
		public void ActivateFixture(int id)
		{
			(_service as IFixturesService).ActivateFixture(id);
		}

		[HttpPatch("{id}/finish-fixture")]
		public void FinishFixture(int id)
		{
			(_service as IFixturesService).FinishFixture(id);
		}
		[HttpGet("/get-fixtures-by-competition")]
		public List<FixtureDTO> GetFixturesByCompetition([FromQuery] GetFixturesByCompetitionRequest request)
		{
			return (_service as IFixturesService).GetFixturesByCompetition(request);
		}
	}
}
