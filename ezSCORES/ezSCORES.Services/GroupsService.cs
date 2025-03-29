using ezSCORES.Model;
using ezSCORES.Model.Requests;
using ezSCORES.Model.Requests.GroupRequests;
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
    public class GroupesService : BaseCRUDService<Groups, GroupSearchObject, Group,GroupInsertRequest, GroupUpdateRequest>, IGroupsService
	{
		public GroupesService(EzScoresdbRsiiContext context, IMapper mapper) : base(context, mapper)
		{
		}

		public override IQueryable<Group> AddFilter(GroupSearchObject search, IQueryable<Group> query)
		{
			if(search.CompetitionId != null)
			{
				query = query.Where(x => x.CompetitionId == search.CompetitionId).Include(x=>x.CompetitionsTeams).ThenInclude(x=>x.Team);
			}
			return base.AddFilter(search, query);
		}
		protected override Group? ApplyIncludes(int id, DbSet<Group> set)
		{
			return set.Where(x=>x.Id == id).Include(x => x.CompetitionsTeams).ThenInclude(x => x.Team).FirstOrDefault();
		}
		public override void BeforeInsert(GroupInsertRequest request, Group entity)
		{
			if(Context.Groups.Where(x=>x.Name == request.Name && request.CompetitionId == x.CompetitionId).Any())
			{
				throw new UserException($"{request.Name} već postoji na ovom takmičenju!");
			}
		}

		public List<GroupStandingsDTO> GetGroupStandings(int competitionId)
		{
			// ✅ Fetch all relevant matches & goals in bulk (single DB hit per entity)
			var allMatches = Context.Matches
				.Where(m => m.IsCompleted && m.Fixture.CompetitionId == competitionId)
				.ToList();

			var allGoals = Context.Goals
				.Where(g => g.Match.IsCompleted && g.Match.Fixture.CompetitionId == competitionId)
				.ToList();

			// ✅ Fetch groups & teams in bulk (avoiding nested queries)
			var groups = Context.Groups
				.Where(g => g.CompetitionId == competitionId)
				.Select(g => new GroupStandingsDTO
				{
					GroupId = g.Id,
					GroupName = g.Name,
					Standings = Context.CompetitionsTeams
						.Where(ct => ct.GroupId == g.Id)
						.Select(ct => new TeamStandingsDTO
						{
							CompetitionTeamId = ct.Id,
							TeamName = ct.Team.Name
						})
						.ToList()
				})
				.ToList();

			// ✅ Process all calculations in C# to reduce DB queries
			foreach (var group in groups)
			{
				foreach (var team in group.Standings)
				{
					// ✅ Filter matches for the team
					var teamMatches = allMatches
						.Where(m => m.HomeTeamId == team.CompetitionTeamId || m.AwayTeamId == team.CompetitionTeamId)
						.ToList();

					// ✅ Calculate match-related statistics
					team.Played = teamMatches.Count;
					team.Wins = teamMatches.Count(m => m.WinnerId == team.CompetitionTeamId);
					team.Draws = teamMatches.Count(m => m.WinnerId == null);
					team.Losses = teamMatches.Count(m => m.WinnerId != null && m.WinnerId != team.CompetitionTeamId);

					// ✅ Filter goals for the team
					var teamGoals = allGoals
						.Where(g => g.Match.HomeTeamId == team.CompetitionTeamId || g.Match.AwayTeamId == team.CompetitionTeamId)
						.ToList();

					// ✅ Calculate goal-related statistics
					team.GoalsScored = teamGoals.Count(g =>
						(g.Match.HomeTeamId == team.CompetitionTeamId && g.IsHomeGoal) ||
						(g.Match.AwayTeamId == team.CompetitionTeamId && !g.IsHomeGoal));

					team.GoalsConceded = teamGoals.Count(g =>
						(g.Match.HomeTeamId == team.CompetitionTeamId && !g.IsHomeGoal) ||
						(g.Match.AwayTeamId == team.CompetitionTeamId && g.IsHomeGoal));

					// ✅ Goal Difference & Points
					team.GoalDifference = team.GoalsScored - team.GoalsConceded;
					team.Points = (team.Wins * 3) + team.Draws;
				}
				group.Standings = group.Standings.OrderByDescending(x => x.Points).ThenByDescending(x => x.GoalDifference).ToList();
			}
			groups = groups.OrderBy(x => x.GroupName).ToList();
			return groups;
		}

		public override void Delete(int id)
		{
			var group = Context.Groups.Find(id);
			if(group == null)
			{
				throw new UserException("Zapis nije pronađen");
			}
			var teamsInGroup = Context.CompetitionsTeams.Where(x => x.GroupId == id);
			if(teamsInGroup.Count()>0)
			{
				foreach(var team in teamsInGroup)
				{
					team.GroupId = null;
				}
			}
			group.IsDeleted = true;
			Context.SaveChanges();
		}
	}
}
