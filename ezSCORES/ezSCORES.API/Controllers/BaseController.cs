﻿using ezSCORES.Model.Requests;
using ezSCORES.Model;
using ezSCORES.Model.SearchObjects;
using ezSCORES.Services;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Authorization;

namespace ezSCORES.API.Controllers
{
	[Route("api/[controller]")]
	[ApiController]
	[Authorize]
	public class BaseController<TModel, TSearch> : ControllerBase where TSearch : BaseSearchObject
	{
		protected IService<TModel, TSearch> _service;
		public BaseController(IService<TModel, TSearch> service)
		{
			_service = service;
		}
		[HttpGet]
		public virtual PagedResult<TModel> GetList([FromQuery] TSearch searchObject)
		{
			return _service.GetPaged(searchObject);
		}

		[HttpGet("{id}")]
		public virtual TModel GetById(int id)
		{
			return _service.GetById(id);
		}
	}
}
