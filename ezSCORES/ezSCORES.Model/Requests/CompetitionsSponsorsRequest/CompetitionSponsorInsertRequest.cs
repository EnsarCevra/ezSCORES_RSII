using System;
using System.Collections.Generic;
using System.Text;

namespace ezSCORES.Model.Requests.CompetitionsSponsorsRequest
{
	public class CompetitionSponsorInsertRequest
	{
		public int CompetitionId { get; set; }

		public int SponsorId { get; set; }

		public int? Type { get; set; }
	}
}
