using System;
using System.Collections.Generic;
using System.Text;

namespace ezSCORES.Model
{
	public  class GroupStandingsDTO
	{
		public int GroupId { get; set; }
		public string GroupName { get; set; }
		public List<TeamStandingsDTO> Standings { get; set; }
	}

	public class TeamStandingsDTO
	{
		public int CompetitionTeamId { get; set; }
		public string TeamName { get; set; }
		public int Played { get; set; }
		public int Wins { get; set; }
		public int Draws { get; set; }
		public int Losses { get; set; }
		public int GoalsScored { get; set; }
		public int GoalsConceded { get; set; }
		public int Points { get; set; }
		public int GoalDifference { get; set; }
	}
}
