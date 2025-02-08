using ezSCORES.Model;
using ezSCORES.Model.SearchObjects;
using ezSCORES.Services;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace ezSCORES.API.Controllers
{
	[Route("api/[controller]")]
	[ApiController]
	public class TeamsController : BaseController<Teams, TeamsSearchObject>
	{
		public TeamsController(ITeamsService service) : base (service)
		{
		}
	}
}
