using System;
using System.Collections.Generic;
using System.Text;

namespace ezSCORES.Model.Requests.ReviewRequests
{
	public class ReviewInsertRequest
	{
		public int UserId { get; set; }

		public int CompetitionId { get; set; }

		public float Rating { get; set; }
	}
}
