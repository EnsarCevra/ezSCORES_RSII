using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Security.Claims;
using Microsoft.AspNetCore.Http;
using ezSCORES.Services.Database;
using System.Dynamic;

namespace ezSCORES.Services.Auth
{
	public class ActiveUserService : IActiveUserService
	{
		private readonly IHttpContextAccessor _httpContextAccessor;
		private readonly EzScoresdbRsiiContext _context;
        public ActiveUserService(IHttpContextAccessor httpContextAccessor, EzScoresdbRsiiContext context)
        {
            _httpContextAccessor = httpContextAccessor;
			_context = context;
        }
        public int? GetActiveUserId()
		{
			var activeUser = _httpContextAccessor.HttpContext.User.FindFirst(ClaimTypes.NameIdentifier)?.Value;
			if(activeUser == null)
			{
				return null;
			}
			var activeUserId = _context.Users.Where(x => x.UserName == activeUser).Select(x=>x.Id).FirstOrDefault();
			return activeUserId;
		}

		public string? GetActiveUserRole()
		{
			var activeUser = _httpContextAccessor.HttpContext.User.FindFirst(ClaimTypes.NameIdentifier)?.Value;
			if (activeUser == null)
			{
				return null;
			}
			var activeUserRole = _context.Users.Where(x => x.UserName == activeUser).Select(x => x.Role.Name).FirstOrDefault();
			return activeUserRole;
		}

		public string GetActiveUserUsername()
		{
			var activeUser = _httpContextAccessor.HttpContext.User.FindFirst(ClaimTypes.NameIdentifier)?.Value;
			return activeUser;
		}
	}
}
