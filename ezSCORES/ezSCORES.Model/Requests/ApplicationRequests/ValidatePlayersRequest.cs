using System;
using System.Collections.Generic;
using System.Text;

namespace ezSCORES.Model.Requests.ApplicationRequests
{
	public class ValidatePlayersRequest
	{
		public int CompetitionId { get; set; }
		public List<int> PlayerIds { get; set; }
	}
}
