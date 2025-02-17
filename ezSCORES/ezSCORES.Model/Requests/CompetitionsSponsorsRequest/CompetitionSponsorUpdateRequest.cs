using System;
using System.Collections.Generic;
using System.Text;

namespace ezSCORES.Model.Requests.CompetitionsSponsorsRequest
{
	public class CompetitionSponsorUpdateRequest
	{
		public int SponsorId { get; set; }

		public int? Type { get; set; }
	}
}
