using System;
using System.Collections.Generic;
using System.Text;

namespace ezSCORES.Model.Requests
{
	public class CompetitionRefereeMatchUpsertRequest
	{
		public int CompetitionsRefereesId { get; set; }

		public int MatchId { get; set; }
	}
}
