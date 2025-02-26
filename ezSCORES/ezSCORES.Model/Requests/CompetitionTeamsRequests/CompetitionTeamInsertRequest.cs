using System;
using System.Collections.Generic;
using System.Text;

namespace ezSCORES.Model.Requests.CompetitionTeamsRequests
{
	public class CompetitionTeamInsertRequest
	{
		public int CompetitionId { get; set; }

		public int TeamId { get; set; }
	}
}
