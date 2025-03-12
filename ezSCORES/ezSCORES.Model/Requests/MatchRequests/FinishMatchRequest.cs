using System;
using System.Collections.Generic;
using System.Text;

namespace ezSCORES.Model.Requests.MatchRequests
{
	public class FinishMatchRequest
	{
		public int? WinnerId { get; set; }
		public bool IsCompletedInRegullarTime { get; set; }
	}
}
