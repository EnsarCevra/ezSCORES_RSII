using System;
using System.Collections.Generic;
using System.Text;

namespace ezSCORES.Model.Requests.GoalRequests
{
	public class GoalInsertRequest
	{
		public int? CompetitionTeamPlayerId { get; set; }

		public int MatchId { get; set; }

		public int ScoredAtMinute { get; set; }

		public bool IsHomeGoal { get; set; }
	}
}
