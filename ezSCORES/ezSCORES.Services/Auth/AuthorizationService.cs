using ezSCORES.Model;
using ezSCORES.Services.Database;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Text.RegularExpressions;
using System.Threading.Tasks;

namespace ezSCORES.Services.Auth
{
	public class AuthorizationService : IAuthorizationService
	{
		private readonly ITeamsService _teamsService;
		private readonly ICompetitionsService _competitionsService;
		private readonly IApplicationService _applicationService;
		private readonly ICompetitionsRefereesService _competitionsRefereesService;
		private readonly ICompetitionsSponsorsService _competitionsSponsorsService;
		private readonly ICompetitionTeamsService _competitionTeamsService;
		private readonly ICompetitionsRefereesMatchService _competitionRefereeMatchService;
		private readonly ICompetitionsTeamsPlayersService _competitionTeamPlayerService;
		private readonly IFavoriteCompetitionsService _favoriteCompetitionService;
		private readonly IFixturesService _fixtureService;
		private readonly IGoalsService _goalService;
		private readonly IGroupsService _groupService;
		private readonly IMatchesService _matchService;
		private readonly IReviewsService _reviewService;
		private readonly IRewardsService _rewardService;


		public AuthorizationService(ITeamsService teamsService, ICompetitionsService competitionsService,
			IApplicationService applicationService, ICompetitionsRefereesService competitionsRefereesService,
			ICompetitionsRefereesMatchService competitionsRefereeMatchService,
			ICompetitionsSponsorsService competitionsSponsorsService, ICompetitionTeamsService competitionTeamsService,
			ICompetitionsTeamsPlayersService competitionsTeamsPlayersService,
			IFavoriteCompetitionsService favoriteCompetitionService,
			IFixturesService fixtureService,
			IGoalsService goalService,
			IGroupsService groupService,
			IMatchesService matchService,
			IReviewsService reviewService,
			IRewardsService rewardService)
		{
			_teamsService = teamsService;
			_competitionsService = competitionsService;
			_applicationService = applicationService;
			_competitionsRefereesService = competitionsRefereesService;
			_competitionRefereeMatchService = competitionsRefereeMatchService;
			_competitionsSponsorsService = competitionsSponsorsService;
			_competitionTeamsService = competitionTeamsService;
			_competitionTeamPlayerService = competitionsTeamsPlayersService;
			_favoriteCompetitionService = favoriteCompetitionService;
			_fixtureService = fixtureService;
			_goalService = goalService;
			_groupService = groupService;
			_matchService = matchService;
			_reviewService = reviewService;
			_rewardService = rewardService;
		}

		public async Task<bool> CanUserAccessTeamAsync(int userId, int teamId)
		{
			var team = await _teamsService.GetByIdAsync(teamId);
			return team != null && team.UserId == userId;
		}

		public async Task<bool> CanUserAccessCompetitionAsync(int userId, int competitionId)
		{
			var competition = await _competitionsService.GetByIdAsync(competitionId);
			return competition != null && competition.UserId == userId;
		}

		public async Task<bool> CanUserAccessApplicationAsync(int userId, int applicationId)
		{
			var application = await _applicationService.GetByIdAsync(applicationId);
			var competition = await _competitionsService.GetByIdAsync(application.CompetitionId);
			return competition?.UserId == userId || application.Team.UserId == userId;
		}

		public async Task<bool> CanUserAccessCompetitionRefereeAsync(int userId, int competitionRefereeId)
		{
			var competitionReferee = await _competitionsRefereesService.GetByIdAsync(competitionRefereeId);
			var competition = await _competitionsService.GetByIdAsync(competitionReferee.CompetitionId);
			return competition?.UserId == userId;
		}

		public async Task<bool> CanUserAccessCompetitionSponsorAsync(int userId, int competitionSponsorId)
		{
			var competitionSponsor = await _competitionsSponsorsService.GetByIdAsync(competitionSponsorId);
			var competition = await _competitionsService.GetByIdAsync(competitionSponsor.CompetitionId);
			return competition?.UserId == userId;
		}

		public async Task<bool> CanUserAccessCompetitionTeamAsync(int userId, int competitionTeamId)
		{
			var competitionTeam = await _competitionTeamsService.GetByIdAsync(competitionTeamId);
			var team = await _teamsService.GetByIdAsync(competitionTeam.TeamId);
			var competition = await _competitionsService.GetByIdAsync(competitionTeam.CompetitionId);
			//should Team owner also have access?
			return competition?.UserId == userId || team.UserId == userId;
		}

		public async Task<bool> CanUserAccessCompetitionRefereeMatchAsync(int userId, int competitionRefereeMatchId)
		{
			var competitionRefereeMatch = await _competitionRefereeMatchService.GetByIdAsync(competitionRefereeMatchId);
			var competitionReferee = await _competitionsRefereesService.GetByIdAsync(competitionRefereeMatch.CompetitionsRefereesId);
			var competition = await _competitionsService.GetByIdAsync(competitionReferee.CompetitionId);
			return competition?.UserId == userId;
		}

		public async Task<bool> CanUserAccessCompetitionTeamPlayerAsync(int userId, int competitionTeamPlayerId)
		{
			var competitionTeamPlayer = await _competitionTeamPlayerService.GetByIdAsync(competitionTeamPlayerId);
			var competitionTeam = await _competitionTeamsService.GetByIdAsync(competitionTeamPlayer.CompetitionsTeamsId);
			var team = await _teamsService.GetByIdAsync(competitionTeam.TeamId);
			var competition = await _competitionsService.GetByIdAsync(competitionTeam.CompetitionId);
			return competition?.UserId == userId || team.UserId != userId;
		}

		public async Task<bool> CanUserAccessFavoriteCompetitionAsync(int userId, int favoriteCompetitionId)
		{
			var favoriteCompetition = await _favoriteCompetitionService.GetByIdAsync(favoriteCompetitionId);
			return favoriteCompetition?.UserId == userId;
		}

		public async Task<bool> CanUserAccessFixtureAsync(int userId, int fixtureId)
		{
			var fixture = await _fixtureService.GetByIdAsync(fixtureId);
			var competition = await _competitionsService.GetByIdAsync(fixture.CompetitionId);
			return competition?.UserId == userId;
		}

		public async Task<bool> CanUserAccessGoalAsync(int userId, int goalId)
		{
			var goal = await _goalService.GetByIdAsync(goalId);
			var match = await _matchService.GetByIdAsync(goal.MatchId);
			var fixture = await _fixtureService.GetByIdAsync(match.FixtureId);
			var competition = await _competitionsService.GetByIdAsync(fixture.CompetitionId);
			return competition?.UserId == userId;
		}

		public async Task<bool> CanUserAccessGroupAsync(int userId, int groupId)
		{
			var group = await _groupService.GetByIdAsync(groupId);
			var competition = await _competitionsService.GetByIdAsync(group.CompetitionId);
			return competition?.UserId == userId;
		}

		public async Task<bool> CanUserAccessMatchAsync(int userId, int matchId)
		{
			var match = await _matchService.GetByIdAsync(matchId);
			var fixture = await _fixtureService.GetByIdAsync(match.FixtureId);
			var competition = await _competitionsService.GetByIdAsync(fixture.CompetitionId);
			return competition?.UserId == userId;
		}

		public async Task<bool> CanUserAccessReviewAsync(int userId, int reviewId)
		{
			var review = await _reviewService.GetByIdAsync(reviewId);
			return review.UserId == userId;
		}

		public async Task<bool> CanUserAccessRewardAsync(int userId, int rewardId)
		{
			var reward = await _rewardService.GetByIdAsync(rewardId);
			var competition = await _competitionsService.GetByIdAsync(reward.CompetitionId);
			return competition?.UserId == userId;
		}
	}
}
