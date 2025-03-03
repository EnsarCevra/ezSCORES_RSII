using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ezSCORES.Services.Auth
{
	public interface IActiveUserService
	{
		int? GetActiveUserId();
		string GetActiveUserUsername();
		int? GetActiveUserRole();
	}
}
