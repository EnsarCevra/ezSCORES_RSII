using System;
using System.Collections.Generic;
using System.Text;

namespace ezSCORES.Model.Requests.FixtureRequests
{
	public class FixtureUpdateRequest
	{
		public int MatchLength { get; set; }

		public int GameStage { get; set; }

		public bool IsCurrentlyActive { get; set; }

		public bool IsCompleted { get; set; }
	}
}
