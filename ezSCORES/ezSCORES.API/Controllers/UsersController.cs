using ezSCORES.Model;
using ezSCORES.Model.Requests;
using ezSCORES.Services;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace ezSCORES.API.Controllers
{
	[Route("api/[controller]")]
	[ApiController]
	public class UsersController : ControllerBase
	{
		protected IUsersService _service;
		public UsersController(IUsersService service) 
		{
			_service = service;
		}
		[HttpGet]
		public List<Users>GetList()
		{
			return _service.GetList();
		}

		[HttpPost]
		public Users Insert(UsersInsertRequests request)
		{
			return _service.Insert(request);
		}

		[HttpPut("{id}")]
		public Users Update(int id, UsersUpdateRequest request)
		{
			return _service.Update(id, request);
		}
	}
}
