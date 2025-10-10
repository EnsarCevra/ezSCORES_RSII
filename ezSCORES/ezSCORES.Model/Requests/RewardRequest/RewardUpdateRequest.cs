using System;
using System.Collections.Generic;
using System.Text;

namespace ezSCORES.Model.Requests.RewardRequest
{
	public class RewardUpdateRequest
	{
		public int RankingPosition { get; set; }

		public int Amount { get; set; }

		public string? Description { get; set; }
	}
}
