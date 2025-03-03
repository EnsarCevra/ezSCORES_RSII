using ezSCORES.Model;
using ezSCORES.Model.Requests.CompetitionRequests;
using ezSCORES.Model.SearchObjects;
using ezSCORES.Services;
using Microsoft.AspNetCore.Authorization;
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

		[AllowAnonymous]
		public override PagedResult<Competitions> GetList([FromQuery] CompetitionsSearchObject searchObject)
		{
			return base.GetList(searchObject);
		}
	}
}
