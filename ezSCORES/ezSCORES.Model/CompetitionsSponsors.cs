using System;
using System.Collections.Generic;
using System.Text;

namespace ezSCORES.Model
{
	public class CompetitionsSponsors
	{
		public int Id { get; set; }

		public int CompetitionId { get; set; }

		public int SponsorId { get; set; }

		public int? Type { get; set; }
	}
}
