using ezSCORES.Model.ENUMs;
using System;
using System.Collections.Generic;
using System.Text;

namespace ezSCORES.Model.Requests.FixtureRequests
{
	public class FixtureInsertRequest
	{
		public int CompetitionId { get; set; }

		public int MatchLength { get; set; }

		public GameStage GameStage { get; set; }

	}
}
