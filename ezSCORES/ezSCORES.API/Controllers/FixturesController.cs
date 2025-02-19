using ezSCORES.Model;
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
	public class FixturesController : BaseCRUDController<Fixtures, BaseSearchObject, FixtureInsertRequest, FixtureUpdateRequest>
	{
		public FixturesController (IFixturesService service) : base (service)
		{
		}
	}
}
