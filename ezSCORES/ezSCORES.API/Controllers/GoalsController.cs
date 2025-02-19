using ezSCORES.Model;
using ezSCORES.Model.Requests;
using ezSCORES.Model.Requests.GoalRequests;
using ezSCORES.Model.Requests.GroupRequests;
using ezSCORES.Model.Requests.TeamsRequests;
using ezSCORES.Model.SearchObjects;
using ezSCORES.Services;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace ezSCORES.API.Controllers
{
    [Route("api/[controller]")]
	[ApiController]
	public class GoalsController : BaseCRUDController<Goals, BaseSearchObject, GoalInsertRequest, GoalUpdateRequest>
	{
		public GoalsController(IGoalsService service) : base (service)
		{
		}
	}
}
