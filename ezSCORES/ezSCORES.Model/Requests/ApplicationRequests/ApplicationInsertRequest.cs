using System;
using System.Collections.Generic;
using System.Text;

namespace ezSCORES.Model.Requests.CompetitionRequests
{
    public class ApplicationInsertRequest
    {
		public int TeamId { get; set; }

		public int CompetitionId { get; set; }

		public string? Message { get; set; }
		public List<CompetitionTeamsPlayerInsertRequest> Players { get; set; }
	}
}
