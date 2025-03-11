using System;
using System.Collections.Generic;
using System.Text;

namespace ezSCORES.Model.Requests.ApplicationRequests
{
	public class ValidateTeamRequest
	{
		public int TeamId { get; set; }
		public int CompetitionId { get; set; }
	}
}
