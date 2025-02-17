using System;
using System.Collections.Generic;
using System.Text;

namespace ezSCORES.Model.Requests.MatchRequests
{
	public class MatchUpdateRequest
	{
		public int FixtureId { get; set; }

		public int HomeTeamId { get; set; }

		public int AwayTeamId { get; set; }

		public int StadiumId { get; set; }

		public int? WinnerId { get; set; }

		public DateTime DateAndTime { get; set; }
	}
}
