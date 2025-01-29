using ezSCORES.Model;
using ezSCORES.Services;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace ezSCORES.API.Controllers
{
	[Route("api/[controller]")]
	[ApiController]
	public class TeamsController : ControllerBase
	{
		protected ITeamsService _service;
		public TeamsController(ITeamsService service) 
		{
			_service = service;
		}
		[HttpGet]
		public List<Teams>GetList()
		{
			return _service.GetList();
		}
	}
}
