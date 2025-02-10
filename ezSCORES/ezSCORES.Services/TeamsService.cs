using ezSCORES.Model;
using ezSCORES.Model.Requests.TeamsRequests;
using ezSCORES.Model.SearchObjects;
using ezSCORES.Services.Database;
using Mapster;
using MapsterMapper;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ezSCORES.Services
{
    public class TeamsService : BaseCRUDService<Teams, TeamsSearchObject, Team, TeamsInsertRequest, TeamsUpdateRequest>, ITeamsService
	{
		public TeamsService(EzScoresdbRsiiContext context, IMapper mapper) : base(context, mapper)
		{
		}
		
		//public List<Teams> GetList(TeamsSearchObject searchObject)
		//{
		//	var result = new List<Model.Teams>();
		//	var query = Context.Teams.AsQueryable();
		//	if(!string.IsNullOrWhiteSpace(searchObject.Name))
		//	{
		//		query = query.Where(x => x.Name.StartsWith(searchObject.Name));
		//	}
		//	if(searchObject.SelectionId!=null)
		//	{
		//		query = query.Where(x => x.SelectionId == searchObject.SelectionId);
		//	}
		//	return result;
		//}
	}
}
