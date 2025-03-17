using ezSCORES.Model;
using ezSCORES.Services;
using ezSCORES.Services.Auth;
using Microsoft.AspNetCore.Routing.Constraints;

namespace ezSCORES.API.Authorization
{
	public class AuthorizationMiddleware
	{
		private readonly RequestDelegate _next;

        public AuthorizationMiddleware(RequestDelegate requestDelegate)
        {
            _next = requestDelegate;
        }

        public async Task InvokeAsync(HttpContext httpContext, IActiveUserService activeUserService, IAuthorizationService authorizationService)
        {
			var currentUserId = activeUserService.GetActiveUserId() ?? 0;
            var resourceId = httpContext.Request.RouteValues["id"]?.ToString();

            if (activeUserService.GetActiveUserRole()!=Model.Constants.Roles.Admin)
            {
				if(resourceId != null)
				{
					int id = int.Parse(resourceId);
					if (httpContext.Request.Path.StartsWithSegments("/api/Teams"))
					{
						if (!await authorizationService.CanUserAccessTeamAsync(currentUserId, id))
						{
							httpContext.Response.StatusCode = StatusCodes.Status403Forbidden;
							await httpContext.Response.WriteAsync("Niste autorizovani da pristupite ovoj ekipi!");
							return;
						}
					}
					if (httpContext.Request.Path.StartsWithSegments("/api/Competitions") && httpContext.Request.Method != "GET")
					{
						if (!await authorizationService.CanUserAccessCompetitionAsync(currentUserId, id))
						{
							httpContext.Response.StatusCode = StatusCodes.Status403Forbidden;
							await httpContext.Response.WriteAsync("Niste autorizovani da pristupite ovom takmičenju!");
							return;
						}
						//var competition = competitionsService.GetById(int.Parse(resourceId));
						//if (competition.UserId != currentUserId)
						//{
						//	httpContext.Response.StatusCode = StatusCodes.Status403Forbidden;
						//	await httpContext.Response.WriteAsync("Niste autorizovani da pristupite ovom takmičenju!");
						//	return;
						//}
					}
					if (httpContext.Request.Path.StartsWithSegments("/api/Applications"))
					{
						
						if (!await authorizationService.CanUserAccessApplicationAsync(currentUserId, id))
						{
							httpContext.Response.StatusCode = StatusCodes.Status403Forbidden;
							await httpContext.Response.WriteAsync("Niste autorizovani da pristupite ovoj prijavi!");
							return;
						}
						//var application = applicationService.GetById(int.Parse(resourceId));
						//if (competitionsService.GetById(application.CompetitionId).UserId != currentUserId && application.Team.UserId != currentUserId)
						//{
						//	httpContext.Response.StatusCode = StatusCodes.Status403Forbidden;
						//	await httpContext.Response.WriteAsync("Niste autorizovani da pristupite ovoj prijavi!");
						//	return;
						//}
					}
					if (httpContext.Request.Path.StartsWithSegments("/api/CompetitionsReferees"))
					{
						if (!await authorizationService.CanUserAccessCompetitionRefereeAsync(currentUserId, id))
						{
							httpContext.Response.StatusCode = StatusCodes.Status403Forbidden;
							await httpContext.Response.WriteAsync("Niste autorizovani za ovu akciju!");
							return;
						}
						//var competitionReferee = competitionsRefereesService.GetById(int.Parse(resourceId));
						//if (competitionsService.GetById(competitionReferee.CompetitionId).UserId != currentUserId)
						//{
						//	httpContext.Response.StatusCode = StatusCodes.Status403Forbidden;
						//	await httpContext.Response.WriteAsync("Niste autorizovani za ovu akciju!");
						//	return;
						//}
					}
					if (httpContext.Request.Path.StartsWithSegments("/api/CompetitionsRefereesMatches"))
					{
						if (!await authorizationService.CanUserAccessCompetitionRefereeMatchAsync(currentUserId, id))
						{
							httpContext.Response.StatusCode = StatusCodes.Status403Forbidden;
							await httpContext.Response.WriteAsync("Niste autorizovani za ovu akciju!");
							return;
						}
					}
					if (httpContext.Request.Path.StartsWithSegments("/api/CompetitionsSponsors"))
					{
						if (!await authorizationService.CanUserAccessCompetitionSponsorAsync(currentUserId, id))
						{
							httpContext.Response.StatusCode = StatusCodes.Status403Forbidden;
							await httpContext.Response.WriteAsync("Niste autorizovani za ovu akciju!");
							return;
						}
						//var competitionSponsors = competitionsSponsorsService.GetById(int.Parse(resourceId));
						//if (competitionsService.GetById(competitionSponsors.CompetitionId).UserId != currentUserId)
						//{
						//	httpContext.Response.StatusCode = StatusCodes.Status403Forbidden;
						//	await httpContext.Response.WriteAsync("Niste autorizovani za ovu akciju!");
						//	return;
						//}
					}
					if (httpContext.Request.Path.StartsWithSegments("/api/CompetitionsTeams"))
					{
						if (!await authorizationService.CanUserAccessCompetitionTeamAsync(currentUserId, id))
						{
							httpContext.Response.StatusCode = StatusCodes.Status403Forbidden;
							await httpContext.Response.WriteAsync("Niste autorizovani za ovu akciju!");
							return;
						}
					}
					if (httpContext.Request.Path.StartsWithSegments("/api/CompetitionsTeamsPlayers"))
					{
						if (!await authorizationService.CanUserAccessCompetitionTeamPlayerAsync(currentUserId, id))
						{
							httpContext.Response.StatusCode = StatusCodes.Status403Forbidden;
							await httpContext.Response.WriteAsync("Niste autorizovani za ovu akciju!");
							return;
						}
					}
					if (httpContext.Request.Path.StartsWithSegments("/api/FavoriteCompetitions"))
					{
						if (!await authorizationService.CanUserAccessFavoriteCompetitionAsync(currentUserId, id))
						{
							httpContext.Response.StatusCode = StatusCodes.Status403Forbidden;
							await httpContext.Response.WriteAsync("Niste autorizovani za ovu akciju!");
							return;
						}
					}
					if (httpContext.Request.Path.StartsWithSegments("/api/Fixtures"))
					{
						if (!await authorizationService.CanUserAccessFixtureAsync(currentUserId, id))
						{
							httpContext.Response.StatusCode = StatusCodes.Status403Forbidden;
							await httpContext.Response.WriteAsync("Niste autorizovani za ovu akciju!");
							return;
						}
					}
					if (httpContext.Request.Path.StartsWithSegments("/api/Goals"))
					{
						if (!await authorizationService.CanUserAccessGoalAsync(currentUserId, id))
						{
							httpContext.Response.StatusCode = StatusCodes.Status403Forbidden;
							await httpContext.Response.WriteAsync("Niste autorizovani za ovu akciju!");
							return;
						}
					}
					if (httpContext.Request.Path.StartsWithSegments("/api/Groups"))
					{
						if (!await authorizationService.CanUserAccessGroupAsync(currentUserId, id))
						{
							httpContext.Response.StatusCode = StatusCodes.Status403Forbidden;
							await httpContext.Response.WriteAsync("Niste autorizovani za ovu akciju!");
							return;
						}
					}
					if (httpContext.Request.Path.StartsWithSegments("/api/Matches"))
					{
						if (!await authorizationService.CanUserAccessMatchAsync(currentUserId, id))
						{
							httpContext.Response.StatusCode = StatusCodes.Status403Forbidden;
							await httpContext.Response.WriteAsync("Niste autorizovani za ovu akciju!");
							return;
						}
					}
					if (httpContext.Request.Path.StartsWithSegments("/api/Matches"))
					{
						if (!await authorizationService.CanUserAccessMatchAsync(currentUserId, id))
						{
							httpContext.Response.StatusCode = StatusCodes.Status403Forbidden;
							await httpContext.Response.WriteAsync("Niste autorizovani za ovu akciju!");
							return;
						}
					}
					if (httpContext.Request.Path.StartsWithSegments("/api/Reviews"))
					{
						if (!await authorizationService.CanUserAccessReviewAsync(currentUserId, id))
						{
							httpContext.Response.StatusCode = StatusCodes.Status403Forbidden;
							await httpContext.Response.WriteAsync("Niste autorizovani za ovu akciju!");
							return;
						}
					}
					if (httpContext.Request.Path.StartsWithSegments("/api/Rewards"))
					{
						if (!await authorizationService.CanUserAccessRewardAsync(currentUserId, id))
						{
							httpContext.Response.StatusCode = StatusCodes.Status403Forbidden;
							await httpContext.Response.WriteAsync("Niste autorizovani za ovu akciju!");
							return;
						}
					}
				}
				else
				{
					if(httpContext.Request.Path.StartsWithSegments("/api/Applications"))
					{
						if (httpContext.Request.Method == "GET")
						{
							if (activeUserService.GetActiveUserRole() == Model.Constants.Roles.Organizer)
							{
								var competitionIdStr = httpContext.Request.Query["competitionId"].FirstOrDefault();
								if (string.IsNullOrEmpty(competitionIdStr) || !await authorizationService.CanUserAccessCompetitionAsync(currentUserId, int.Parse(competitionIdStr)))
								{
									httpContext.Response.StatusCode = StatusCodes.Status403Forbidden;
									await httpContext.Response.WriteAsync("Niste autorizovani da pristupite prijavama na takmičenju!");
									return;
								}
							}
							else if (activeUserService.GetActiveUserRole() == Model.Constants.Roles.Manager)
							{
								var teamIdStr = httpContext.Request.Query["teamId"].FirstOrDefault();
								if (string.IsNullOrEmpty(teamIdStr) || !await authorizationService.CanUserAccessTeamAsync(currentUserId, int.Parse(teamIdStr)))
								{
									httpContext.Response.StatusCode = StatusCodes.Status403Forbidden;
									await httpContext.Response.WriteAsync("Niste autorizovani da pristupite prijavama!");
									return;
								}
							}
							else
							{
								httpContext.Response.StatusCode = StatusCodes.Status403Forbidden;
								await httpContext.Response.WriteAsync("Niste autorizovani da pristupite prijavama!");
								return;
							}
						}
						
					}
					
				}
				
			}
            await _next(httpContext);
        }
    }
}
