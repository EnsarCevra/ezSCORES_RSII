using ezSCORES.Model.ENUMs;
using ezSCORES.Model.Recommender;
using ezSCORES.Services.Database;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.ML;
using Microsoft.ML.Data;
using Microsoft.ML.Trainers;
using static System.Formats.Asn1.AsnWriter;

namespace ezSCORES.Services.Recommender
{
	public class RecommenderService : IRecommenderService
	{
		private readonly MLContext _mlContext;
		private readonly IServiceScopeFactory _scopeFactory;

		public RecommenderService(IServiceScopeFactory scopeFactory)
		{
			_mlContext = new MLContext();
			_scopeFactory = scopeFactory;
		}

		public RecommendedCompetitionSetup RecommendCompetitionSetup(int userId)
		{
			using var scope = _scopeFactory.CreateScope();
			var dbContext = scope.ServiceProvider.GetRequiredService<EzScoresdbRsiiContext>();
			var competitions = dbContext.Competitions
				.Select(c => new CompetitionData
				{
					UserId = c.UserId,
					CompetitionType = (float)c.CompetitionType,
					MaxTeamCount = c.MaxTeamCount,
					MaxPlayersPerTeam = c.MaxPlayersPerTeam
				})
				.ToList();

			var response = new RecommendedCompetitionSetup();

			if (!competitions.Any())
			{
				response.CompetitionType = CompetitionType.Tournament;
				response.MaxTeamCount = 16;
				response.MaxPlayersPerTeam = 12;

				return response;
			}

			var competitionTypeModel = TrainMatrixModel(
			competitions.Select(c => new CompetitionPreference
			{
				UserId = (uint)c.UserId,
				ItemId = (uint)c.CompetitionType,
				Label = 1f
			}).ToList());

			var maxTeamCountModel = TrainMatrixModel(
				competitions.Select(c => new CompetitionPreference
				{
					UserId = (uint)c.UserId,
					ItemId = (uint)c.MaxTeamCount,
					Label = 1f
				}).ToList());

			var maxPlayersModel = TrainMatrixModel(
				competitions.Select(c => new CompetitionPreference
				{
					UserId = (uint)c.UserId,
					ItemId = (uint)c.MaxPlayersPerTeam,
					Label = 1f
				}).ToList());

			var bestType = Predict(userId, competitionTypeModel, Enum.GetValues(typeof(CompetitionType)).Cast<int>());
			var bestTeamCount = Predict(userId, maxTeamCountModel, competitions.Select(c => c.MaxTeamCount).Distinct());
			var bestPlayers = Predict(userId, maxPlayersModel, competitions.Select(c => c.MaxPlayersPerTeam).Distinct());

			response.CompetitionType = (CompetitionType)bestType;
			response.MaxTeamCount = bestTeamCount;
			response.MaxPlayersPerTeam = bestPlayers;
			return response;
		}
		private int Predict(int userId, ITransformer model, IEnumerable<int> candidates)
		{
			var predictionEngine = _mlContext.Model.CreatePredictionEngine<CompetitionPreference, CompetitionPrediction>(model);

			float bestScore = float.MinValue;
			int bestValue = 0;

			foreach (var candidate in candidates)
			{
				var prediction = predictionEngine.Predict(new CompetitionPreference
				{
					UserId = (uint)userId,
					ItemId = (uint)candidate
				});

				if (prediction.Score > bestScore)
				{
					bestScore = prediction.Score;
					bestValue = candidate;
				}
			}

			return bestValue;
		}
		private ITransformer TrainMatrixModel(List<CompetitionPreference> trainingData)
		{
			var dataView = _mlContext.Data.LoadFromEnumerable(trainingData);

			var options = new MatrixFactorizationTrainer.Options
			{
				MatrixColumnIndexColumnName = nameof(CompetitionPreference.UserId),
				MatrixRowIndexColumnName = nameof(CompetitionPreference.ItemId),
				LabelColumnName = nameof(CompetitionPreference.Label),
				NumberOfIterations = 5,
				ApproximationRank = 20,
				Alpha = 0.01,
				Lambda = 0.025,
				LossFunction = MatrixFactorizationTrainer.LossFunctionType.SquareLossOneClass
			};

			var estimator = _mlContext.Recommendation().Trainers.MatrixFactorization(options);

			var model = estimator.Fit(dataView);
			return model;
		}
	}
	public class CompetitionData
	{
		public float UserId { get; set; }
		public float CompetitionType { get; set; }
		public int MaxTeamCount { get; set; }
		public int MaxPlayersPerTeam { get; set; }
	}

	public class CompetitionPreference
	{
		[KeyType(count: 100000)]
		public uint UserId { get; set; }

		[KeyType(count: 100000)]
		public uint ItemId { get; set; }

		public float Label { get; set; }
	}

	public class CompetitionPrediction
	{
		public float Score { get; set; }
	}
}
