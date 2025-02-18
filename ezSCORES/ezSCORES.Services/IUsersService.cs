using ezSCORES.Model;
using ezSCORES.Model.Requests.UserRequests;
using ezSCORES.Model.SearchObjects;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ezSCORES.Services
{
    public interface IUsersService : ICRUDService<Users, UserSearchObject, UsersInsertRequests, UsersUpdateRequest>
	{
		Users Login(string username, string password);
	}
}
