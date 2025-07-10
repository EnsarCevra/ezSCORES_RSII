using ezSCORES.Model;
using ezSCORES.Model.DTOs;
using ezSCORES.Model.Requests;
using ezSCORES.Model.Requests.MatchRequests;
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
using static Microsoft.EntityFrameworkCore.DbLoggerCategory;

namespace ezSCORES.Services
{
    public class MatchesService : BaseCRUDService<Matches, MatchSearchObject, Match, MatchInsertRequest, MatchUpdateRequest>, IMatchesService
	{
		public MatchesService(EzScoresdbRsiiContext context, IMapper mapper) : base(context, mapper)
		{
		}

		public override IQueryable<Match> AddFilter(MatchSearchObject search, IQueryable<Match> query)
		{
			base.AddFilter(search, query);
			if(search.FixtureId != null)
			{
				query = query.Where(x => x.FixtureId == search.FixtureId)
					.OrderByDescending(x=>x.DateAndTime);
			}
			if(search.StadiumId != null)
			{
				query = query.Where(x=>x.StadiumId == search.StadiumId);
			}
			if(search.DateAndTime != null)
			{
				query = query.Where(x => x.DateAndTime.Date == search.DateAndTime.Value.Date);
			}
			return base.AddFilter(search, query);
		}

		public override void BeforeInsert(MatchInsertRequest request, Match entity)
		{
			if(request.HomeTeamId == request.AwayTeamId)
			{
				throw new UserException("Domaći i gostujući tim ne mogu biti isti!");
			}
			var competitionId = Context.Fixtures.Find(request.FixtureId)!.CompetitionId;

			var nonParticipatingTeamsIds = new List<int> {request.HomeTeamId, request.AwayTeamId }
								.Except(Context.CompetitionsTeams
									.Where(ct => ct.CompetitionId == competitionId)
									.Select(ct => ct.Id))
								.ToList();
			if(nonParticipatingTeamsIds.Count > 0)
			{
				throw new UserException($"Timovi ne pripadaju takmičenju: {string.Join(",", nonParticipatingTeamsIds)}");
			}
			var stadium = Context.Stadiums.Find(request.StadiumId);
			if(stadium == null)
			{
				throw new UserException("Stadion koji ste odabrali ne postoji ili je izbrisan!");
			}
			var fixtureGameStage = Context.Fixtures.Where(x => x.Id == request.FixtureId).FirstOrDefault()?.GameStage;
			if(fixtureGameStage != null)
			{
				if(fixtureGameStage == Model.ENUMs.GameStage.GroupPhase)
				{
					var homeTeamGroupId = Context.CompetitionsTeams.Where(x => x.Id == request.HomeTeamId).Select(x=>x.GroupId).FirstOrDefault();
					var awayTeamGroupId = Context.CompetitionsTeams.Where(x => x.Id == request.AwayTeamId).Select(x=>x.GroupId).FirstOrDefault();
					if (homeTeamGroupId != awayTeamGroupId)
					{
						throw new UserException("Ekipe moraju pripadati istoj grupi!");
					}
				}
			}
		}
		public override Match? BeforeDelete(int id, DbSet<Match> set)
		{
			var entity = set.Where(x => x.Id == id).Include(x => x.Goals).FirstOrDefault();
			return entity;
		}
		public void StartMatch(int id)
		{
			var match = Context.Matches.Find(id);
			if(!Context.Fixtures.Where(x=>x.Id == match!.FixtureId).FirstOrDefault()!.IsCurrentlyActive)
			{
				throw new UserException("Ova utakmica nije dio trenutno aktivnog kola ili je izbrisana!");
			}
			match!.IsUnderway = true;
			Context.SaveChanges();
		}

		public void FinishMatch(int id, FinishMatchRequest request)
		{
			var match = Context.Matches.Find(id);
			var homeGoals = Context.Goals.Count(g => g.MatchId == match!.Id && g.IsHomeGoal);
			var awayGoals = Context.Goals.Count(g => g.MatchId == match!.Id && !g.IsHomeGoal);
			if(!request.IsCompletedInRegullarTime)
			{
				//this means it went on penalty shoutout and has to be processed 
			}
			match!.WinnerId = homeGoals > awayGoals ? match.HomeTeamId
			  : awayGoals > homeGoals ? match.AwayTeamId
			  : null;  // Null when draw
			//match!.WinnerId = request.WinnerId;
			match!.IsUnderway = false;
			match.IsCompleted = true;
			match.IsCompletedInRegullarTime = request.IsCompletedInRegullarTime;
			
			Context.SaveChanges();
		}
		protected override Match? ApplyIncludes(int id, DbSet<Match> set)
		{
			return set.AsSplitQuery()
						.Where(x => x.Id == id)
						.Include(x => x.HomeTeam).ThenInclude(x => x.Team)
						.Include(x => x.HomeTeam).ThenInclude(x => x.CompetitionsTeamsPlayers).ThenInclude(x => x.Player)
						.Include(x => x.HomeTeam).ThenInclude(x => x.Group)
						.Include(x => x.AwayTeam).ThenInclude(x => x.CompetitionsTeamsPlayers).ThenInclude(x => x.Player)
						.Include(x => x.AwayTeam).ThenInclude(x => x.Team)
						.Include(x => x.Stadium)
						.Include(x => x.Goals).ThenInclude(x => x.CompetitionTeamPlayer).ThenInclude(x => x.Player)
						.Include(x => x.CompetitionsRefereesMatches).ThenInclude(x => x.CompetitionsReferees).ThenInclude(x => x.Referee)
						.Include(x => x.Fixture)
						.FirstOrDefault();
		}
		public MatchDTO GetMatchDetails(int id)
		{
			var match = Context.Matches.AsSplitQuery()
						.Include(x => x.HomeTeam).ThenInclude(x => x.Team)
						.Include(x => x.HomeTeam).ThenInclude(x => x.CompetitionsTeamsPlayers).ThenInclude(x => x.Player)
						.Include(x => x.HomeTeam).ThenInclude(x => x.Group)
						.Include(x => x.AwayTeam).ThenInclude(x => x.CompetitionsTeamsPlayers).ThenInclude(x => x.Player)
						.Include(x => x.AwayTeam).ThenInclude(x => x.Team)
						.Include(x => x.Stadium)
						.Include(x => x.Goals).ThenInclude(x => x.CompetitionTeamPlayer).ThenInclude(x => x.Player)
						.Include(x => x.CompetitionsRefereesMatches).ThenInclude(x => x.CompetitionsReferees).ThenInclude(x => x.Referee)
						.Include(x=>x.Fixture)
						.Where(x => x.Id == id)
						.Select(x => new MatchDTO
						{
							MatchId = x.Id,
							DateAndTime = x.DateAndTime,
							FixtureId = x.FixtureId,
							Group = new GroupDTO
							{
								Id = x.HomeTeam.Group.Id,
								Name = x.HomeTeam.Group.Name
							},
							GameStage = x.Fixture.GameStage,
							FixtureSequenceNumber = x.Fixture.SequenceNumber,
							IsCompleted = x.IsCompleted,
							IsUnderway = x.IsUnderway,
							HomeTeam = new TeamDTO
							{
								Id = x.HomeTeam.Id,
								Name = x.HomeTeam.Team.Name,
								Players = x.HomeTeam.CompetitionsTeamsPlayers.Select(p => new PlayerDTO
								{
									Id = p.Id,
									Name = p.Player.FirstName + " " + p.Player.LastName
								}).ToList()
							},
							AwayTeam = new TeamDTO
							{
								Id = x.AwayTeam.Id,
								Name = x.AwayTeam.Team.Name,
								Players = x.AwayTeam.CompetitionsTeamsPlayers.Select(p => new PlayerDTO
								{
									Id = p.Id,
									Name = p.Player.FirstName + " " + p.Player.LastName
								}).ToList()
							},
							Referees = x.CompetitionsRefereesMatches.Select(crm => new RefereesDTO
							{
								Id = crm.Id,
								CompetitionRefereeId = crm.CompetitionsRefereesId,
								Name = crm.CompetitionsReferees.Referee.FirstName + " " + crm.CompetitionsReferees.Referee.LastName
							}).ToList(),
							Stadium = new Stadiums
							{
								Id = x.Stadium.Id,
								Name = x.Stadium.Name,
								Picture = x.Stadium.Picture
							},
							Goals = x.Goals.Select(g => new GoalDTO
							{
								Id = g.Id,
								CompetitionTeamPlayerId = g.CompetitionTeamPlayerId,
								Scorer = g.CompetitionTeamPlayer != null ? g.CompetitionTeamPlayer.Player.FirstName + " " + g.CompetitionTeamPlayer.Player.LastName : null,
								ScoredAtMinute = g.ScoredAtMinute,
								SequenceNumber = g.SequenceNumber,
								IsHomeGoal = g.IsHomeGoal
							}).OrderBy(g=>g.SequenceNumber).ToList(),
						}).FirstOrDefault();
			if (match == null)
				throw new UserException("Odabrana utakmica ne postoji!");
			if (match.Group != null && match.GameStage != Model.ENUMs.GameStage.GroupPhase && match.GameStage == Model.ENUMs.GameStage.League)
				match.Group = null;//if it's not group stage, group name will not be displayed
			return match;
		}
	}
}
