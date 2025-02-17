using System;
using System.Collections.Generic;
using System.Text;

namespace ezSCORES.Model
{
	public class Goals
	{
		public int Id { get; set; }

		public int? CompetitionTeamPlayerId { get; set; }

		public int MatchId { get; set; }

		public int SequenceNumber { get; set; }

		public int ScoredAtMinute { get; set; }

		public bool IsHomeGoal { get; set; }
	}
}
