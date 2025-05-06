using ezSCORES.Model;
using ezSCORES.Model.Requests.CompetitionRequests;
using ezSCORES.Model.SearchObjects;
using ezSCORES.Services;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace ezSCORES.API.Controllers
{
    [Route("api/[controller]")]
	[ApiController]
	public class CompetitionsController : BaseCRUDController<Competitions, CompetitionsSearchObject, CompetitionsInsertRequest, CompetitionsUpdateRequest>
	{
		public CompetitionsController(ICompetitionsService service) : base(service)
		{
		}
		[HttpPatch("/toggle-competition-status{id}")]
		public Competitions ToggleCompetitionStatus(int id, ToggleCompetitionStatusRequest request)
		{
			return (_service as ICompetitionsService).ToogleCompetitionStatus(id, request.Status);
		}
		[AllowAnonymous]
		public override PagedResult<Competitions> GetList([FromQuery] CompetitionsSearchObject searchObject)
		{
			return base.GetList(searchObject);
		}
		[HttpPatch("{id}/preparation")]
		public Competitions PreparationsState(int id)
		{
			return (_service as ICompetitionsService).PreparationState(id);
		}
		[HttpPatch("{id}/applications-open")]
		public Competitions OpenApplications(int id)
		{
			return (_service as ICompetitionsService).OpenAplications(id);
		}
		[HttpPatch("{id}/applications-closed")]
		public Competitions CloseApplications(int id)
		{
			return (_service as ICompetitionsService).CloseApplications(id);
		}
		[HttpPatch("{id}/start-competition")]
		public Competitions StartCompetition(int id)
		{
			return (_service as ICompetitionsService).StartCompetition(id);
		}
		[HttpPatch("{id}/finish-competition")]
		public Competitions FinishCompetition(int id)
		{
			return (_service as ICompetitionsService).FinishCompetition(id);
		}
	}
}
