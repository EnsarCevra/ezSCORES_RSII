using ezSCORES.Model;
using ezSCORES.Model.Requests;
using ezSCORES.Model.Requests.CompetitionTeamsRequests;
using ezSCORES.Model.Requests.TeamsRequests;
using ezSCORES.Model.SearchObjects;
using ezSCORES.Services;
using ezSCORES.Services.Database;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace ezSCORES.API.Controllers
{
    [Route("api/[controller]")]
	[ApiController]
	public class CompetitionTeamsController : BaseCRUDController<CompetitionsTeams, CompetitionTeamsSearchObject, CompetitionTeamInsertRequest, CompetitionTeamUpdateRequest>
	{
		public CompetitionTeamsController(ICompetitionTeamsService service) : base (service)
		{
		}
	}
}
