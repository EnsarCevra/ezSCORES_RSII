using ezSCORES.Model.ENUMs;
using ezSCORES.Model.Recommender;
using ezSCORES.Services.Database;
using Microsoft.ML;
using Microsoft.ML.Data;
using Microsoft.ML.Trainers;

namespace ezSCORES.Services.Recommender
{
	public class RecommenderService : IRecommenderService
	{
		private readonly MLContext _mlContext;
		private readonly EzScoresdbRsiiContext	_dbContext;

		private ITransformer _competitionTypeModel;
		private ITransformer _maxTeamCountModel;
		private ITransformer _maxPlayersModel;

		private readonly string _modelDir = Path.Combine(AppContext.BaseDirectory, "RecommenderModels");

		private readonly object _competitionTypeLock = new();
		private readonly object _maxTeamCountLock = new();
		private readonly object _maxPlayersLock = new();

		public RecommenderService(EzScoresdbRsiiContext dbContext)
		{
			_mlContext = new MLContext();
			_dbContext = dbContext;
			if (!Directory.Exists(_modelDir))
				Directory.CreateDirectory(_modelDir);
		}

		public RecommendedCompetitionSetup RecommendCompetitionSetup(int userId)
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

			var response = new RecommendedCompetitionSetup();

			if (!competitions.Any())
			{
				response.CompetitionType = CompetitionType.League;
				response.MaxTeamCount = 8;
				response.MaxPlayersPerTeam = 10;

				return response; // fallback defaults
			}

			_competitionTypeModel ??= LoadOrTrainModel(
			Path.Combine(_modelDir, "competitionTypeModel.zip"),
			competitions.Select(c => new CompetitionPreference
			{
				UserId = (uint)c.UserId,
				ItemId = (uint)c.CompetitionType,
				Label = 1f
			}).ToList(),
			_competitionTypeLock);

			_maxTeamCountModel ??= LoadOrTrainModel(
				Path.Combine(_modelDir, "maxTeamCountModel.zip"),
				competitions.Select(c => new CompetitionPreference
				{
					UserId = (uint)c.UserId,
					ItemId = (uint)c.MaxTeamCount,
					Label = 1f
				}).ToList(),
				_maxTeamCountLock);

			_maxPlayersModel ??= LoadOrTrainModel(
				Path.Combine(_modelDir, "maxPlayersModel.zip"),
				competitions.Select(c => new CompetitionPreference
				{
					UserId = (uint)c.UserId,
					ItemId = (uint)c.MaxPlayersPerTeam,
					Label = 1f
				}).ToList(),
				_maxPlayersLock);

			// Train
			var bestType = Predict(userId, _competitionTypeModel, Enum.GetValues(typeof(CompetitionType)).Cast<int>());
			var bestTeamCount = Predict(userId, _maxTeamCountModel, competitions.Select(c => c.MaxTeamCount).Distinct());
			var bestPlayers = Predict(userId, _maxPlayersModel, competitions.Select(c => c.MaxPlayersPerTeam).Distinct());

			response.CompetitionType = (CompetitionType)bestType;
			response.MaxTeamCount = bestTeamCount;
			response.MaxPlayersPerTeam = bestPlayers;
			return response;
		}
		private ITransformer LoadOrTrainModel(string filePath, List<CompetitionPreference> trainingData, object lockObj, bool forceTrain = false)
		{
			lock (lockObj)
			{
				if (!forceTrain && File.Exists(filePath))
				{
					using var stream = File.OpenRead(filePath);
					return _mlContext.Model.Load(stream, out _);
				}

				var model = TrainMatrixModel(trainingData);

				using var fs = File.Create(filePath);
				_mlContext.Model.Save(model, _mlContext.Data.LoadFromEnumerable(trainingData).Schema, fs);

				return model;
			}
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
				NumberOfIterations = 20,
				ApproximationRank = 50,
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
		[KeyType(count: 100000)] // adjust capacity
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
