using ezSCORES.Model;
using ezSCORES.Model.Requests.GoalRequests;
using ezSCORES.Model.Requests.TeamsRequests;
using ezSCORES.Model.SearchObjects;
using ezSCORES.Services.Database;
using Mapster;
using MapsterMapper;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ezSCORES.Services
{
    public class GoalsService : BaseCRUDService<Goals, GoalSearchObject, Goal,GoalInsertRequest, GoalUpdateRequest>, IGoalsService
	{
		public GoalsService(EzScoresdbRsiiContext context, IMapper mapper) : base(context, mapper)
		{
		}

		public override IQueryable<Goal> AddFilter(GoalSearchObject search, IQueryable<Goal> query)
		{
			if(search.MatchId != null)
			{
				query = query.Where(x => x.MatchId == search.MatchId)
					.OrderBy(x=>x.SequenceNumber)
					.Include(x=>x.CompetitionTeamPlayer).ThenInclude(x=>x.Player);
			}
			return base.AddFilter(search, query);
		}
		public override void BeforeInsert(GoalInsertRequest request, Goal entity)
		{
			var match = Context.Matches.Where(x => x.Id == entity.MatchId)
				.Select(x => new
				{
					Match = x,
					MatchLength = x.Fixture.MatchLength 
				}).FirstOrDefault();
			if(request.ScoredAtMinute < 0 || request.ScoredAtMinute > match!.MatchLength)
			{
				throw new UserException($"Unijeli ste sljedeci minut pogotka:{request.ScoredAtMinute}, a utakmica traje {match!.MatchLength} minuta!");
			}
			if (request.CompetitionTeamPlayerId != null)
			{
				var playerTeamId = Context.CompetitionsTeamsPlayers.Where(x => x.Id == request.CompetitionTeamPlayerId)
					.Select(x => x.CompetitionsTeamsId).FirstOrDefault();
				if((request.IsHomeGoal && match.Match.HomeTeamId!=playerTeamId) ||
					(!request.IsHomeGoal && match.Match.AwayTeamId != playerTeamId))
				{
					throw new UserException("Odabrani strijelac nije član ekipe koja je postigla pogodak!");
				}
			}

			var laterGoals = Context.Goals
			.Where(g => g.MatchId == entity.MatchId && g.ScoredAtMinute >= entity.ScoredAtMinute)
			.OrderBy(g => g.ScoredAtMinute)
			.ThenBy(g => g.SequenceNumber)
			.ToList();

			if (laterGoals.Any())
			{
				var insertPosition = laterGoals.First().SequenceNumber;

				// Shift all later goals
				foreach (var goal in Context.Goals.Where(g => g.MatchId == entity.MatchId && g.SequenceNumber >= insertPosition))
				{
					goal.SequenceNumber += 1;
				}

				entity.SequenceNumber = insertPosition;
			}
			else
			{
				// Append at the end
				var lastSeq = Context.Goals
					.Where(g => g.MatchId == entity.MatchId)
					.Max(g => (int?)g.SequenceNumber) ?? 0;

				entity.SequenceNumber = lastSeq + 1;
			}

			Context.SaveChanges();
		}
		public override void BeforeUpdate(GoalUpdateRequest request, Goal entity)
		{
			var match = Context.Matches.Where(x => x.Id == entity.MatchId)
			.Select(x => new
			{
				Match = x,
				MatchLength = x.Fixture.MatchLength
			}).FirstOrDefault();

			if (request.ScoredAtMinute < 0 || request.ScoredAtMinute > match!.MatchLength)
			{
				throw new UserException($"Unijeli ste sljedeći minut pogotka: {request.ScoredAtMinute}, a utakmica traje {match.MatchLength} minuta!");
			}

			if (request.CompetitionTeamPlayerId != null)
			{
				var playerTeamId = Context.CompetitionsTeamsPlayers
					.Where(x => x.Id == request.CompetitionTeamPlayerId)
					.Select(x => x.CompetitionsTeamsId)
					.FirstOrDefault();

				if ((request.IsHomeGoal && match.Match.HomeTeamId != playerTeamId) ||
					(!request.IsHomeGoal && match.Match.AwayTeamId != playerTeamId))
				{
					throw new UserException("Odabrani strijelac nije član ekipe koja je postigla pogodak!");
				}
			}

			var existingGoal = Context.Goals
				.AsNoTracking()
				.FirstOrDefault(g => g.Id == entity.Id);

			if (existingGoal != null &&
				(existingGoal.ScoredAtMinute != request.ScoredAtMinute || existingGoal.MatchId != entity.MatchId))
			{
				// Step 1: Shift down others from old position
				var goalsToShiftDown = Context.Goals
					.Where(g => g.MatchId == existingGoal.MatchId && g.SequenceNumber > existingGoal.SequenceNumber)
					.ToList();

				foreach (var goal in goalsToShiftDown)
				{
					goal.SequenceNumber -= 1;
				}

				// Step 2: Find new insert position
				var laterGoals = Context.Goals
					.Where(g => g.MatchId == entity.MatchId &&
								g.ScoredAtMinute >= request.ScoredAtMinute &&
								g.Id != entity.Id)
					.OrderBy(g => g.ScoredAtMinute)
					.ThenBy(g => g.SequenceNumber)
					.ToList();

				if (laterGoals.Any())
				{
					var insertPosition = laterGoals.First().SequenceNumber;

					var goalsToShiftUp = Context.Goals
						.Where(g => g.MatchId == entity.MatchId && g.SequenceNumber >= insertPosition)
						.ToList();

					foreach (var goal in goalsToShiftUp)
					{
						goal.SequenceNumber += 1;
					}

					entity.SequenceNumber = insertPosition;
				}
				else
				{
					var lastSeq = Context.Goals
						.Where(g => g.MatchId == entity.MatchId)
						.Max(g => (int?)g.SequenceNumber) ?? 0;

					entity.SequenceNumber = lastSeq + 1;
				}

				entity.ScoredAtMinute = request.ScoredAtMinute;
			}

			Context.SaveChanges();
		}
		public override Goal? BeforeDelete(int id, DbSet<Goal> set)
		{
			var goalToDelete = Context.Goals
			.FirstOrDefault(x => x.Id == id);
			int sequenceNumberToDelete = goalToDelete.SequenceNumber;

			// Update sequence numbers for remaining fixtures
			var goalsToUpdate = Context.Goals
				.Where(g => g.MatchId == goalToDelete.MatchId &&
							g.SequenceNumber > sequenceNumberToDelete)
				.ToList();

			foreach (var goal in goalsToUpdate)
			{
				goal.SequenceNumber -= 1;
			}
			Context.SaveChanges();
			return goalToDelete;
		}
	}
}
