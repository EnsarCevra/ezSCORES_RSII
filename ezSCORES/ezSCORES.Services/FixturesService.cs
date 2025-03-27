using ezSCORES.Model;
using ezSCORES.Model.DTOs;
using ezSCORES.Model.Requests;
using ezSCORES.Model.Requests.FixtureRequests;
using ezSCORES.Model.Requests.TeamsRequests;
using ezSCORES.Model.SearchObjects;
using ezSCORES.Services.Database;
using Mapster;
using MapsterMapper;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Linq.Dynamic.Core;
using System.Text;
using System.Threading.Tasks;

namespace ezSCORES.Services
{
    public class FixturesService : BaseCRUDService<Fixtures, BaseCompetitionSearchObject, Fixture,FixtureInsertRequest, FixtureUpdateRequest>, IFixturesService
	{
		public FixturesService(EzScoresdbRsiiContext context, IMapper mapper) : base(context, mapper)
		{
		}

		public void ActivateFixture(int fixtureId)
		{
			var fixture = Context.Fixtures.Find(fixtureId);
			if (fixture == null)
			{
				throw new UserException("Odabrano kolo ne postoji ili je izbrisano!");
			}
			var activeFixture = Context.Fixtures.FirstOrDefault(x => x.CompetitionId == fixture.CompetitionId && x.IsCurrentlyActive);
			if(activeFixture != null)
			{
				throw new UserException($"Već je aktivno drugo kolo: {activeFixture.Id}");
			}
			else
			{
				if(fixture.Id == fixtureId)
				{
					throw new UserException($"Ovo kolo je već aktivno!");
				}
			}
			fixture.IsActive = true;
			Context.SaveChanges();
		}

		public override IQueryable<Fixture> AddFilter(BaseCompetitionSearchObject search, IQueryable<Fixture> query)
		{
			if (search.CompetitionId != null)
			{
				query = query.Where(x => x.CompetitionId == search.CompetitionId)
					.Include(x => x.Matches)
					.OrderByDescending(x => x.GameStage)
					.ThenByDescending(x => x.SequenceNumber);
			}
			return query;

		}

		public override void BeforeInsert(FixtureInsertRequest request, Fixture entity)
		{
			base.BeforeInsert(request, entity);
			//can insert onlly when status applications closed and underway
			//can insert group game stage only if competition is with groups
			//after validation get highest squence number to increment it for current one
			if(entity.GameStage == Model.ENUMs.GameStage.GroupPhase || entity.GameStage == Model.ENUMs.GameStage.League)
			{
				//some tournamens have sequence numbers even on later stages but that won't be included for now
				int previousMaxSequenceNumber = Context.Fixtures.Where(x => x.CompetitionId == entity.CompetitionId)
				.OrderByDescending(x => x.SequenceNumber)
				.Select(x => x.SequenceNumber)
				.FirstOrDefault();
				//this will work if no deletion of fixtures is quarantied and if its all same game stage
				entity.SequenceNumber = previousMaxSequenceNumber + 1;
			}
			
		}

		public void FinishFixture(int fixtureId)
		{
			var fixture = Context.Fixtures.Find(fixtureId);
			if(fixture == null)
			{
				throw new UserException("Odabrano kolo ne postoji ili je izbrisano!");
			}
			var unfinishedMatchesIds = Context.Matches.Where(x => x.FixtureId == fixture.Id && !x.IsCompleted).Select(x=>x.Id);
			if(unfinishedMatchesIds.Any())
			{
				throw new UserException($"Nezavršeni susreti: {string.Join(",", unfinishedMatchesIds)}");
			}
			fixture.IsActive = false;
			fixture.IsCompleted = true;
			Context.SaveChanges();
		}

		public List<FixtureDTO> GetFixturesByCompetition(GetFixturesByCompetitionRequest request)
		{
			var fixtures = Context.Fixtures
							.AsSplitQuery() // ✅ Optimizes query execution
							.Where(f => f.CompetitionId == request.competitionId
							&&( (request.GetSchedule && !f.IsCompleted && !f.IsCurrentlyActive) || (!request.GetSchedule && (f.IsCompleted || f.IsCurrentlyActive) ) ))
							.OrderByDescending(f => f.GameStage) // ✅ Latest game stages first
							.ThenByDescending(f => f.SequenceNumber) // ✅ Latest sequence first
							.Include(f => f.Matches)
								.ThenInclude(m => m.HomeTeam).ThenInclude(t => t.Team)
							.Include(f => f.Matches)
								.ThenInclude(m => m.AwayTeam).ThenInclude(t => t.Team)
							.Include(f => f.Matches)
								.ThenInclude(m => m.Stadium)
							.Select(f => new FixtureDTO
							{
								Id = f.Id,
								GameStage = f.GameStage,
								SequenceNumber = f.SequenceNumber,
								Matches = f.Matches
									.OrderByDescending(m => m.DateAndTime) // ✅ Latest matches first
									.Select(m => new MatchDTO
									{
										MatchId = m.Id,
										DateAndTime = m.DateAndTime,
										HomeTeam = new TeamDTO
										{
											Id = m.HomeTeam.Team.Id,
											Name = m.HomeTeam.Team.Name
										},
										AwayTeam = new TeamDTO
										{
											Id = m.AwayTeam.Team.Id,
											Name = m.AwayTeam.Team.Name
										},
										Stadium = m.Stadium != null ? m.Stadium.Name : null,
										HomeTeamScore = m.IsCompleted ? Context.Goals.Count(g => g.MatchId == m.Id && g.IsHomeGoal) : null,
										AwayTeamScore = m.IsCompleted ? Context.Goals.Count(g => g.MatchId == m.Id && !g.IsHomeGoal) : null
									})
									.ToList()
							})
							.ToList();

			return fixtures;
		}

		protected override IQueryable<Fixture> ApplyIncludes(IQueryable<Fixture> query)
		{
			return query.Include(x => x.Matches).ThenInclude(x => x.HomeTeam).ThenInclude(x => x.Team)
							.Include(x => x.Matches).ThenInclude(x => x.AwayTeam).ThenInclude(x => x.Team);
		}

		public override void Delete(int id)
		{
			var fixtureToDelete = Context.Fixtures
			.FirstOrDefault(f => f.Id == id);

			if (fixtureToDelete != null)
			{
				if(fixtureToDelete.GameStage == Model.ENUMs.GameStage.GroupPhase || fixtureToDelete.GameStage == Model.ENUMs.GameStage.League)
				{
					int sequenceNumberToDelete = fixtureToDelete.SequenceNumber;

					// Update sequence numbers for remaining fixtures
					var fixturesToUpdate = Context.Fixtures
						.Where(f => f.CompetitionId == fixtureToDelete.CompetitionId &&
									f.SequenceNumber > sequenceNumberToDelete)
						.ToList();

					foreach (var fixture in fixturesToUpdate)
					{
						fixture.SequenceNumber -= 1;
					}
				}
				// Mark the fixture as deleted (soft delete)
				fixtureToDelete.IsDeleted = true;
				Context.SaveChanges();
			}
			else
			{
				throw new UserException("Odabrani zapis ne postoji!");
			}
		}
	}
}
