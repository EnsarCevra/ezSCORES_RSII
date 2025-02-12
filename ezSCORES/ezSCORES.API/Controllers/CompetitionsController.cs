using ezSCORES.Model;
using ezSCORES.Model.Requests.CompetitionRequests;
using ezSCORES.Model.SearchObjects;
using ezSCORES.Services;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace ezSCORES.API.Controllers
{
    [Route("api/[controller]")]
	[ApiController]
	public class CompetitionsController : BaseCRUDController<Competitions, CompetitionsSearchObject, CompetitionsInsertRequest, CompetitionsUpdateRequest>
	{
		public CompetitionsController(ICompetitionsService service) : base(service)
		{
		}
	}
}
