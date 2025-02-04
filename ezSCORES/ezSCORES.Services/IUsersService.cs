using ezSCORES.Model;
using ezSCORES.Model.Requests;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ezSCORES.Services
{
	public interface IUsersService
	{
		List<Users> GetList();
		Users Insert(UsersInsertRequests request);
		Users Update(int id, UsersUpdateRequest request);
	}
}
