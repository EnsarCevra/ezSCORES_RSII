using ezSCORES.Model;
using ezSCORES.Model.Requests;
using ezSCORES.Model.Requests.ReviewRequests;
using ezSCORES.Model.Requests.RewardRequest;
using ezSCORES.Model.Requests.TeamsRequests;
using ezSCORES.Model.SearchObjects;
using ezSCORES.Services;
using ezSCORES.Services.Database;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace ezSCORES.API.Controllers
{
    [Route("api/[controller]")]
	[ApiController]
	public class ReviewsController : BaseCRUDController<Reviews, BaseSearchObject, ReviewInsertRequest, ReviewUpdateRequest>
	{
		public ReviewsController(IReviewsService service) : base (service)
		{
		}
	}
}
