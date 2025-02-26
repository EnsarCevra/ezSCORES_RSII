using ezSCORES.Model;
using ezSCORES.Model.Requests;
using ezSCORES.Model.Requests.GroupRequests;
using ezSCORES.Model.Requests.TeamsRequests;
using ezSCORES.Model.SearchObjects;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ezSCORES.Services
{
    public interface IGroupsService : ICRUDService<Groups, GroupSearchObject, GroupInsertRequest, GroupUpdateRequest>
	{
	}
}
