using ezSCORES.Model;
using ezSCORES.Model.Requests;
using ezSCORES.Model.SearchObjects;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ezSCORES.Services
{
	public interface IUsersService : IService<Users, UserSearchObject>
	{
		//PagedResult<Users> GetList(UserSearchObject searchObject);
		Users Insert(UsersInsertRequests request);
		Users Update(int id, UsersUpdateRequest request);
	}
}
