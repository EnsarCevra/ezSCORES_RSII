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
	public class RolesController : BaseCRUDController<Roles, BaseSearchObject, RoleUpsertRequest, RoleUpsertRequest>
	{
		public RolesController(IRolesService service) : base (service)
		{
		}
	}
}
