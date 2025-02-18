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
	public class SelectionsController : BaseCRUDController<Selections, BaseSearchObject, SelectionUpsertRequest, SelectionUpsertRequest>
	{
		public SelectionsController(ISelectionsService service) : base (service)
		{
		}

		[AllowAnonymous]
		public override PagedResult<Selections> GetList([FromQuery] BaseSearchObject searchObject)
		{
			return base.GetList(searchObject);
		}
	}
}
