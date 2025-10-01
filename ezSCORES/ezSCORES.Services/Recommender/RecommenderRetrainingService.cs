using ezSCORES.Services.Database;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ezSCORES.Services.Recommender
{
	public class RecommenderRetrainingService : IRecommenderRetrainingService
	{
		private readonly EzScoresdbRsiiContext _dbContext;
		private readonly RecommenderService _recommenderService;

		public RecommenderRetrainingService(EzScoresdbRsiiContext dbContext, RecommenderService recommenderService)
		{
			_dbContext = dbContext;
			_recommenderService = recommenderService;
		}

		public async Task RetrainModelsAsync()
		{
			await Task.Run(() =>
			{
				var competitions = _dbContext.Competitions
					.Where(c => !c.IsDeleted)
					.Select(c => new CompetitionData
					{
						UserId = c.UserId,
						CompetitionType = (float)c.CompetitionType,
						MaxTeamCount = c.MaxTeamCount,
						MaxPlayersPerTeam = c.MaxPlayersPerTeam
					})
					.ToList();

				if (!competitions.Any())
					return;

				// CompetitionType
				_recommenderService.LoadOrTrainModel(
					System.IO.Path.Combine(AppContext.BaseDirectory, "RecommenderModels", "competitionTypeModel.zip"),
					competitions.Select(c => new CompetitionPreference
					{
						UserId = (uint)c.UserId,
						ItemId = (uint)c.CompetitionType,
						Label = 1f
					}).ToList(),
					_recommenderService.competitionTypeLock,
					forceTrain: true);

				// MaxTeamCount
				_recommenderService.LoadOrTrainModel(
					System.IO.Path.Combine(AppContext.BaseDirectory, "RecommenderModels", "maxTeamCountModel.zip"),
					competitions.Select(c => new CompetitionPreference
					{
						UserId = (uint)c.UserId,
						ItemId = (uint)c.MaxTeamCount,
						Label = 1f
					}).ToList(),
					_recommenderService.maxTeamCountLock,
					forceTrain: true);

				// MaxPlayers
				_recommenderService.LoadOrTrainModel(
					System.IO.Path.Combine(AppContext.BaseDirectory, "RecommenderModels", "maxPlayersModel.zip"),
					competitions.Select(c => new CompetitionPreference
					{
						UserId = (uint)c.UserId,
						ItemId = (uint)c.MaxPlayersPerTeam,
						Label = 1f
					}).ToList(),
					_recommenderService.maxPlayersLock,
					forceTrain: true);
			});
		}
	}
}
