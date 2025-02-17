using System;
using System.Collections.Generic;
using System.Text;

namespace ezSCORES.Model.Requests.FavoriteCompetitionRequests
{
	public class FavoriteCompetitionInsertRequest
	{
		public int UserId { get; set; }

		public int CompetitionId { get; set; }
	}
}
