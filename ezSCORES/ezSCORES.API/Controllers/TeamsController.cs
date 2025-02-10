using ezSCORES.Model;
using ezSCORES.Model.Requests.TeamsRequests;
using ezSCORES.Model.SearchObjects;
using ezSCORES.Services;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace ezSCORES.API.Controllers
{
    [Route("api/[controller]")]
	[ApiController]
	public class TeamsController : BaseCRUDController<Teams, TeamsSearchObject, TeamsInsertRequest, TeamsUpdateRequest>
	{
		public TeamsController(ITeamsService service) : base (service)
		{
		}
	}
}
