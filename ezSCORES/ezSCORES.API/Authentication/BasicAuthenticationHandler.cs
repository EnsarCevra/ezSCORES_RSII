using ezSCORES.Services;
using ezSCORES.Services.Database;
using Microsoft.AspNetCore.Authentication;
using Microsoft.Extensions.Options;
using Microsoft.Identity.Client;
using System.Net.Http.Headers;
using System.Security.Claims;
using System.Text;
using System.Text.Encodings.Web;

namespace ezSCORES.API.Authentication
{
	public class BasicAuthenticationHandler : AuthenticationHandler<AuthenticationSchemeOptions>
	{
		IUsersService _userService;
		public BasicAuthenticationHandler(IOptionsMonitor<AuthenticationSchemeOptions> options, ILoggerFactory logger, UrlEncoder encoder, ISystemClock clock, IUsersService userService) : base(options, logger, encoder, clock)
		{
			_userService = userService;
		}

		protected override async Task<AuthenticateResult> HandleAuthenticateAsync()
		{
			if (!Request.Headers.ContainsKey("Authorization"))
			{
				return AuthenticateResult.Fail("Missing header.");
			}

			var authHeader = AuthenticationHeaderValue.Parse(Request.Headers["Authorization"]);
			var credentialBytes = Convert.FromBase64String(authHeader.Parameter);
			var credentials = Encoding.UTF8.GetString(credentialBytes).Split(':');

			var username = credentials[0];
			var password = credentials[1];

			var user = _userService.Login(username, password);
			if(user == null)
			{
				return AuthenticateResult.Fail("Auth failed");
			}
			else
			{
				var claims = new List<Claim>()
				{
					new Claim(ClaimTypes.Name, user.FirstName),
					new Claim(ClaimTypes.NameIdentifier, user.UserName)
				};

				claims.Add(new Claim(ClaimTypes.Role, user.Role.Name));

				var identity = new ClaimsIdentity(claims, Scheme.Name);

				var principal = new ClaimsPrincipal(identity);

				var ticket = new AuthenticationTicket(principal, Scheme.Name);
				return AuthenticateResult.Success(ticket);
			}
		}
	}
}
