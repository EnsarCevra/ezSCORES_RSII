﻿using System;
using System.Collections.Generic;
using System.Text;

namespace ezSCORES.Model.Requests.RewardRequest
{
	public class RewardInsertRequest
	{
		public int CompetitionId { get; set; }

		public string Name { get; set; } = null!;

		public int? RankingPosition { get; set; }

		public int Amount { get; set; }

		public string? Description { get; set; }
	}
}
