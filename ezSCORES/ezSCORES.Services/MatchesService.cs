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
			return query;
		}

		public override void BeforeInsert(MatchInsertRequest request, Match entity)
		{
			if(request.HomeTeamId == request.AwayTeamId)
			{
				throw new UserException("Domaći i gostujući tim ne mogu biti isti!");
			}
			var stadium = Context.Stadiums.Find(request.StadiumId);
			if(stadium == null || stadium.IsDeleted)
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

		public void StartMatch(int id)
		{
			var match = Context.Matches.Find(id);
			if(!Context.Fixtures.Where(x=>x.Id == match!.FixtureId).FirstOrDefault()!.IsActive)
			{
				throw new UserException("Ova utakmica nije dio trenutno aktivnog kola!");
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

		public MatchDTO GetMatchDetails(int id)
		{
			var match = Context.Matches.AsSplitQuery()
						.Include(x => x.HomeTeam).ThenInclude(x => x.Team)
						.Include(x => x.HomeTeam).ThenInclude(x => x.CompetitionsTeamsPlayers).ThenInclude(x => x.Player)
						.Include(x => x.AwayTeam).ThenInclude(x => x.CompetitionsTeamsPlayers).ThenInclude(x => x.Player)
						.Include(x => x.AwayTeam).ThenInclude(x => x.Team)
						.Include(x => x.Stadium)
						.Include(x => x.Goals).ThenInclude(x => x.CompetitionTeamPlayer).ThenInclude(x => x.Player)
						.Include(x => x.CompetitionsRefereesMatches).ThenInclude(x => x.CompetitionsReferees).ThenInclude(x => x.Referee)
						.Where(x => x.Id == id)
						.Select(x => new MatchDTO
						{
							MatchId = x.Id,
							DateAndTime = x.DateAndTime,
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
							Stadium = x.Stadium.Name,
							Goals = x.Goals.Select(g => new GoalDTO
							{
								Id = g.Id,
								Scorer = g.CompetitionTeamPlayer != null ? g.CompetitionTeamPlayer.Player.FirstName + " " + g.CompetitionTeamPlayer.Player.LastName : null
							}).ToList(),
						}).FirstOrDefault();
			if (match == null)
				throw new UserException("Odabrana utakmica ne postoji!");
			return match;
		}
	}
}
