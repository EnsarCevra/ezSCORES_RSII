using ezSCORES.Model;
using ezSCORES.Model.Requests;
using ezSCORES.Model.SearchObjects;
using ezSCORES.Services;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace ezSCORES.API.Controllers
{
	[Route("api/[controller]")]
	[ApiController]
	public class UsersController : BaseController<Users, UserSearchObject>
	{
		public UsersController(IUsersService service) : base(service) { }
	}
}
