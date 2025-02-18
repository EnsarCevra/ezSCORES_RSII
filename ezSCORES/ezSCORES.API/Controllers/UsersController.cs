using ezSCORES.Model;
using ezSCORES.Model.Requests.UserRequests;
using ezSCORES.Model.SearchObjects;
using ezSCORES.Services;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace ezSCORES.API.Controllers
{
    [Route("api/[controller]")]
	[ApiController]
	public class UsersController : BaseCRUDController<Users, UserSearchObject, UsersInsertRequests, UsersUpdateRequest>
	{
		public UsersController(IUsersService service) : base(service) { }

		[AllowAnonymous]
		public override Users Insert(UsersInsertRequests request)
		{
			return base.Insert(request);
		}

		[AllowAnonymous]
		[HttpPost("login")]
		public Users Login(string username, string password)
		{
			return (_service as IUsersService).Login(username, password);
		}
	}
}
