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
	public class CompetitionsController : ControllerBase
	{
		protected ICompetitionsService _service;
		public CompetitionsController(ICompetitionsService service) 
		{
			_service = service;
		}
		[HttpGet]
		//public List<Users>GetList([FromQuery]UserSearchObject searchObject)
		//{
		//	return _service.GetList(searchObject);
		//}

		[HttpPost]
		public Competitions Insert(CompetitionsInsertRequest request)
		{
			return _service.Insert(request);
		}

		//[HttpPut("{id}")]
		//public Users Update(int id, UsersUpdateRequest request)
		//{
		//	return _service.Update(id, request);
		//}
	}
}
