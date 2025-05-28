using ezSCORES.Model.ENUMs;
using System;
using System.Collections.Generic;
using System.Text;

namespace ezSCORES.Model.Requests.FixtureRequests
{
	public class FixtureUpdateRequest
	{
		public int MatchLength { get; set; }

		public GameStage GameStage { get; set; }

	}
}
