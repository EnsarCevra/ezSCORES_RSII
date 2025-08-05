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
		[Authorize(Roles = Model.Constants.Roles.Admin)]
		public override Cities Insert(CityUpsertRequest request)
		{
			return base.Insert(request);
		}
		[Authorize(Roles = Model.Constants.Roles.Admin)]
		public override Cities Update(int id, CityUpsertRequest request)
		{
			return base.Update(id, request);
		}
		[Authorize(Roles = Model.Constants.Roles.Admin)]
		public override void Delete(int id)
		{
			base.Delete(id);
		}
		[Authorize(Roles = Model.Constants.Roles.Admin)]
		public override Cities GetById(int id)
		{
			return base.GetById(id);
		}
	}
}
