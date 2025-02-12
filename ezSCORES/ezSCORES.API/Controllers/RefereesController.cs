using ezSCORES.Model;
using ezSCORES.Model.Requests;
using ezSCORES.Model.Requests.TeamsRequests;
using ezSCORES.Model.SearchObjects;
using ezSCORES.Services;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace ezSCORES.API.Controllers
{
    [Route("api/[controller]")]
	[ApiController]
	public class RefereesController : BaseCRUDController<Referees, RefereesSearchObject, RefereeUpsertRequest, RefereeUpsertRequest>
	{
		public RefereesController(IRefereesService service) : base (service)
		{
		}
	}
}
