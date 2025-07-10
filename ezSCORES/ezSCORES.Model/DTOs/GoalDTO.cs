using System;
using System.Collections.Generic;
using System.IO;
using System.Text;

namespace ezSCORES.Model.DTOs
{
	public class GoalDTO
	{
		public int Id { get; set; }
		public int? CompetitionTeamPlayerId { get; set; }
		public string? Scorer { get; set; }
		public int ScoredAtMinute { get; set; }
		public bool IsHomeGoal { get; set; }
		public int SequenceNumber { get; set; }

	}
}
