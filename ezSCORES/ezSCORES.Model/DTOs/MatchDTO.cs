using ezSCORES.Model.ENUMs;
using System;
using System.Collections.Generic;
using System.Text;

namespace ezSCORES.Model.DTOs
{
	public class MatchDTO
	{
		public int MatchId { get; set; }
		public int? HomeTeamScore { get; set; }
		public int? AwayTeamScore { get; set; }
		public DateTime DateAndTime { get; set; }
		public TeamDTO HomeTeam { get; set; }
		public TeamDTO AwayTeam { get; set; }
		public string Stadium { get; set; }
		public List<GoalDTO> Goals { get; set; }
		public List<string> Referees { get; set; }
		public int FixtureId { get; set; }
		public string? Group { get; set; }
		public int FixtureSequenceNumber { get; set; }
		public GameStage GameStage{ get; set; }
	}
}
