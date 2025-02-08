using ezSCORES.Model.Requests;
using ezSCORES.Model;
using ezSCORES.Model.SearchObjects;
using ezSCORES.Services;
using Microsoft.AspNetCore.Mvc;

namespace ezSCORES.API.Controllers
{
	[Route("api/[controller]")]
	[ApiController]
	public class BaseController<TModel, TSearch> : ControllerBase where TSearch : BaseSearchObject
	{
		protected IService<TModel, TSearch> _service;
		public BaseController(IService<TModel, TSearch> service)
		{
			_service = service;
		}
		[HttpGet]
		public PagedResult<TModel> GetList([FromQuery] TSearch searchObject)
		{
			return _service.GetPaged(searchObject);
		}

		[HttpGet("{id}")]
		public TModel GetById(int id)
		{
			return _service.GetById(id);
		}
	}
}
