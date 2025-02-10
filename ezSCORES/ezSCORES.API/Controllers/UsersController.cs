using ezSCORES.Model;
using ezSCORES.Model.Requests.UserRequests;
using ezSCORES.Model.SearchObjects;
using ezSCORES.Services;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace ezSCORES.API.Controllers
{
    [Route("api/[controller]")]
	[ApiController]
	public class UsersController : BaseCRUDController<Users, UserSearchObject, UsersInsertRequests, UsersUpdateRequest>
	{
		public UsersController(IUsersService service) : base(service) { }
	}
}
