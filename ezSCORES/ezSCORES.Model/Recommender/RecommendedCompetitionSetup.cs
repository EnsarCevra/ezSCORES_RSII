using ezSCORES.Model.ENUMs;
using System;
using System.Collections.Generic;
using System.Text;

namespace ezSCORES.Model.Recommender
{
	public class RecommendedCompetitionSetup
	{
		public CompetitionType CompetitionType { get; set; }
		public int MaxTeamCount { get; set; }
		public int MaxPlayersPerTeam { get; set; }
	}
}
