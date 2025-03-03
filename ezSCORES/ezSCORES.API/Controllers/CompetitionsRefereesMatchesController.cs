using ezSCORES.Model;
using ezSCORES.Model.Requests;
using ezSCORES.Model.Requests.CompetitionsRefereesRequests;
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
	public class CompetitionsRefereesMatchesController : BaseCRUDController<CompetitionsRefereesMatches, BaseCompetitionSearchObject, CompetitionRefereeMatchUpsertRequest, CompetitionRefereeMatchUpsertRequest>
	{
		public CompetitionsRefereesMatchesController(ICompetitionsRefereesMatchService service) : base (service)
		{
		}
	}
}
