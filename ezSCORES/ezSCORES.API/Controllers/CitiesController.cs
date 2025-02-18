using ezSCORES.Model;
using ezSCORES.Model.Requests;
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
	public class CitiesController : BaseCRUDController<Cities, BaseSearchObject, CityUpsertRequest, CityUpsertRequest>
	{
		public CitiesController(ICitiesService service) : base (service)
		{
		}

		[AllowAnonymous]
		public override PagedResult<Cities> GetList([FromQuery] BaseSearchObject searchObject)
		{
			return base.GetList(searchObject);
		}
	}
}
