using System;
using System.Collections.Generic;
using System.Text;

namespace ezSCORES.Model.Requests
{
	public class CompetitionTeamsPlayerUpsertRequest
	{
		public int CompetitionsTeamsId { get; set; }

		public int PlayerId { get; set; }
	}
}
