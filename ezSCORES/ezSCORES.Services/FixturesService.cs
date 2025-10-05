using ezSCORES.Model;
using ezSCORES.Model.DTOs;
using ezSCORES.Model.Requests;
using ezSCORES.Model.Requests.ApplicationRequests;
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
using static Microsoft.EntityFrameworkCore.DbLoggerCategory;

namespace ezSCORES.Services
{
    public class FixturesService : BaseCRUDService<Fixtures, BaseCompetitionSearchObject, Fixture,FixtureInsertRequest, FixtureUpdateRequest>, IFixturesService
	{
		public FixturesService(EzScoresdbRsiiContext context, IMapper mapper) : base(context, mapper)
		{
		}

		public void ToogleFixtureStatus(int fixtureId, ToogleStatusRequest request)
		{
			var fixture = Context.Fixtures.Find(fixtureId);
			if (fixture == null)
			{
				throw new UserException("Odabrano kolo ne postoji ili je izbrisano!");
			}
			var activeFixture = Context.Fixtures.FirstOrDefault(x => x.Id != fixtureId && x.CompetitionId == fixture.CompetitionId && x.IsCurrentlyActive);
			if(activeFixture != null)
			{
				throw new UserException($"Već postoji drugo aktivno kolo!");
			}
			fixture.IsCurrentlyActive = request.Status;
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
			return base.AddFilter(search, query);

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
				//if its initial fixture it should have sequence nubmer 0
				entity.SequenceNumber = previousMaxSequenceNumber == 0 && !Context.Fixtures.Any(x => x.CompetitionId == entity.CompetitionId)
				? 0
				: previousMaxSequenceNumber + 1;
			}
			
		}

		public void FinishFixture(int fixtureId)
		{
			var fixture = Context.Fixtures.Find(fixtureId);
			if(fixture == null)
			{
				throw new UserException("Odabrano kolo ne postoji ili je izbrisano!");
			}
			var unfinishedMatchesExist = Context.Matches.Where(x => x.FixtureId == fixture.Id && !x.IsCompleted).Any();
			if(unfinishedMatchesExist)
			{
				throw new UserException($"Da biste završili kolo morate završiti sve utakmice u okviru tog kola!");
			}
			fixture.IsCurrentlyActive = false;
			fixture.IsCompleted = true;
			Context.SaveChanges();
		}

		public List<FixtureDTO> GetFixturesByCompetition(GetFixturesByCompetitionRequest request)
		{
			var fixtures = Context.Fixtures
							.AsSplitQuery()
							.Where(f => f.CompetitionId == request.competitionId
							&&( request.GetSchedule == null ||
								(request.GetSchedule == true && !f.IsCompleted && !f.IsCurrentlyActive) || 
								(request.GetSchedule == false  && (f.IsCompleted || f.IsCurrentlyActive) ) ))
							.OrderByDescending(f => f.GameStage) 
							.ThenByDescending(f => f.SequenceNumber) 
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
								IsCurrentlyActive = f.IsCurrentlyActive,
								IsCompleted = f.IsCompleted,
								Matches = f.Matches
									.OrderByDescending(m => m.DateAndTime)
									.Select(m => new MatchDTO
									{
										MatchId = m.Id,
										DateAndTime = m.DateAndTime,
										IsCompleted = m.IsCompleted,
										IsUnderway = m.IsUnderway,
										GameStage = f.GameStage,
										Group = m.HomeTeam.Group == null
										? null
										: new GroupDTO
										{
											Id = m.HomeTeam.Group.Id,
											Name = m.HomeTeam.Group.Name
										},
										HomeTeam = new TeamDTO
										{
											Id = m.HomeTeam.Team.Id,
											Name = m.HomeTeam.Team.Name,
											Picture = m.HomeTeam.Team.Picture
										},
										AwayTeam = new TeamDTO
										{
											Id = m.AwayTeam.Team.Id,
											Name = m.AwayTeam.Team.Name,
											Picture = m.AwayTeam.Team.Picture
										},
										Stadium = m.Stadium != null ? new Stadiums {Id = m.Stadium.Id, Name = m.Stadium.Name, Picture = m.Stadium.Picture } : null,
										HomeTeamScore = m.IsCompleted ? Context.Goals.Count(g => g.MatchId == m.Id && g.IsHomeGoal) : null,
										AwayTeamScore = m.IsCompleted ? Context.Goals.Count(g => g.MatchId == m.Id && !g.IsHomeGoal) : null
									})
									.ToList()
							})
							.ToList();

			return fixtures;
		}
		public override Fixture? BeforeDelete(int id, DbSet<Fixture> set)
		{
			var fixtureToDelete = Context.Fixtures.Include(x => x.Matches).ThenInclude(x => x.Goals)
			.FirstOrDefault(f => f.Id == id);

			if (fixtureToDelete != null)
			{
				if (fixtureToDelete.GameStage == Model.ENUMs.GameStage.GroupPhase || fixtureToDelete.GameStage == Model.ENUMs.GameStage.League)
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
				Context.SaveChanges();
			}
			return fixtureToDelete;
		}
	}
}
