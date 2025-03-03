using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ezSCORES.Services.Auth
{
	public interface IAuthorizationService
	{
		Task<bool> CanUserAccessApplicationAsync(int userId, int applicationId);
		Task<bool> CanUserAccessCompetitionAsync(int userId, int competitionId);
		Task<bool> CanUserAccessCompetitionRefereeAsync(int userId, int competitionRefereeId);
		Task<bool> CanUserAccessCompetitionRefereeMatchAsync(int userId, int competitionId);
		Task<bool> CanUserAccessCompetitionSponsorAsync(int userId, int competitionSponsorId);
		Task<bool> CanUserAccessCompetitionTeamAsync(int userId, int competitionTeamId);
		Task<bool> CanUserAccessCompetitionTeamPlayerAsync(int userId, int competitionTeamPlayerId);
		Task<bool> CanUserAccessFavoriteCompetitionAsync(int userId, int favoriteCompetitionId);
		Task<bool> CanUserAccessFixtureAsync(int userId, int fixtureId);
		Task<bool> CanUserAccessGoalAsync(int userId, int goalId);
		Task<bool> CanUserAccessGroupAsync(int userId, int groupId);
		Task<bool> CanUserAccessMatchAsync(int userId, int matchId);
		Task<bool> CanUserAccessReviewAsync(int userId, int reviewId);
		Task<bool> CanUserAccessRewardAsync(int userId, int rewardId);
		Task<bool> CanUserAccessTeamAsync(int userId, int teamId);
	}
}
