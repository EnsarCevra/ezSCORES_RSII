using ezSCORES.Model.ENUMs;
using System;
using System.Collections.Generic;
using System.Text;

namespace ezSCORES.Model.Requests.CompetitionRequests
{
	public class ToggleCompetitionStatusRequest
	{
		public CompetitionStatus Status { get; set; }
	}
}
