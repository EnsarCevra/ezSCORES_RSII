using System;
using System.Collections.Generic;
using System.Text;

namespace ezSCORES.Model
{
	public class Rewards
	{
		public int Id { get; set; }

		public int CompetitionId { get; set; }

		public string Name { get; set; } = null!;

		public int? RankingPosition { get; set; }

		public int Amount { get; set; }

		public string? Description { get; set; }
	}
}
