using ezSCORES.Model;
using ezSCORES.Model.DTOs;
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

		[Authorize(Roles = Model.Constants.Roles.Admin + "," + Model.Constants.Roles.Organizer)]
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
		[Authorize(Roles = Model.Constants.Roles.Admin + "," + Model.Constants.Roles.Organizer)]
		public override Competitions Insert(CompetitionsInsertRequest request)
		{
			return base.Insert(request);
		}
		[Authorize(Roles = Model.Constants.Roles.Admin + "," + Model.Constants.Roles.Organizer)]
		public override Competitions Update(int id, CompetitionsUpdateRequest request)
		{
			return base.Update(id, request);
		}
		[Authorize(Roles = Model.Constants.Roles.Admin + "," + Model.Constants.Roles.Organizer)]
		public override void Delete(int id)
		{
			base.Delete(id);
		}
		[Authorize(Roles = Model.Constants.Roles.Admin + "," + Model.Constants.Roles.Organizer)]
		[HttpPatch("{id}/preparation")]
		public Competitions PreparationsState(int id)
		{
			return (_service as ICompetitionsService).PreparationState(id);
		}
		[Authorize(Roles = Model.Constants.Roles.Admin + "," + Model.Constants.Roles.Organizer)]
		[HttpPatch("{id}/applications-open")]
		public Competitions OpenApplications(int id)
		{
			return (_service as ICompetitionsService).OpenAplications(id);
		}
		[Authorize(Roles = Model.Constants.Roles.Admin + "," + Model.Constants.Roles.Organizer)]
		[HttpPatch("{id}/applications-closed")]
		public Competitions CloseApplications(int id)
		{
			return (_service as ICompetitionsService).CloseApplications(id);
		}
		[Authorize(Roles = Model.Constants.Roles.Admin + "," + Model.Constants.Roles.Organizer)]
		[HttpPatch("{id}/start-competition")]
		public Competitions StartCompetition(int id)
		{
			return (_service as ICompetitionsService).StartCompetition(id);
		}
		[Authorize(Roles = Model.Constants.Roles.Admin + "," + Model.Constants.Roles.Organizer)]
		[HttpPatch("{id}/finish-competition")]
		public Competitions FinishCompetition(int id)
		{
			return (_service as ICompetitionsService).FinishCompetition(id);
		}
		[Authorize(Roles = Model.Constants.Roles.Admin + "," + Model.Constants.Roles.Organizer)]
		[HttpGet("get-admin-dashboard-info")]
		public AdminDashboardDTO GetAdminDashboardInfo([FromQuery] AdminDashboardSearchObject searchObject)
		{
			return (_service as ICompetitionsService).GetAdminDashboardInfo(searchObject);
		}
	}
}
