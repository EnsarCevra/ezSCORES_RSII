using System;
using System.Collections.Generic;
using System.Text;

namespace ezSCORES.Model.Requests.CompetitionRequests
{
    public class CompetitionTeamsPlayerInsertRequest
	{
		public int CompetitionsTeamsId { get; set; }

		public int PlayerId { get; set; }
	}
}
