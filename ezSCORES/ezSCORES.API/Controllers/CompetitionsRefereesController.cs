using ezSCORES.Model;
using ezSCORES.Model.Requests;
using ezSCORES.Model.Requests.CompetitionsRefereesRequests;
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
	public class CompetitionsRefereesController : BaseCRUDController<CompetitionsReferees, BaseCompetitionSearchObject, CompetitionRefereeInsertRequest, CompetitionRefereeUpdateRequest>
	{
		public CompetitionsRefereesController(ICompetitionsRefereesService service) : base (service)
		{
		}
		public override PagedResult<CompetitionsReferees> GetList([FromQuery] BaseCompetitionSearchObject searchObject)
		{
			return base.GetList(searchObject);
		}
		[Authorize(Roles = Model.Constants.Roles.Admin + "," + Model.Constants.Roles.Organizer)]
		public override CompetitionsReferees GetById(int id)
		{
			return base.GetById(id);
		}
		[Authorize(Roles = Model.Constants.Roles.Admin + "," + Model.Constants.Roles.Organizer)]
		public override CompetitionsReferees Insert(CompetitionRefereeInsertRequest request)
		{
			return base.Insert(request);
		}
		[Authorize(Roles = Model.Constants.Roles.Admin + "," + Model.Constants.Roles.Organizer)]
		public override CompetitionsReferees Update(int id, CompetitionRefereeUpdateRequest request)
		{
			return base.Update(id, request);
		}
		[Authorize(Roles = Model.Constants.Roles.Admin + "," + Model.Constants.Roles.Organizer)]
		public override void Delete(int id)
		{
			base.Delete(id);
		}
	}
}
