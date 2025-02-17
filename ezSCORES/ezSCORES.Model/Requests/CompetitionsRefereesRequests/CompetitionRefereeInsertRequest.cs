using System;
using System.Collections.Generic;
using System.Text;

namespace ezSCORES.Model.Requests.CompetitionsRefereesRequests
{
	public class CompetitionRefereeInsertRequest
	{
		public int CompetitionId { get; set; }

		public int RefereeId { get; set; }
	}
}
