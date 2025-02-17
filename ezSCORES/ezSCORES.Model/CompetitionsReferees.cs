using System;
using System.Collections.Generic;
using System.Text;

namespace ezSCORES.Model
{
	public class CompetitionsReferees
	{
		public int Id { get; set; }

		public int CompetitionId { get; set; }

		public int RefereeId { get; set; }
		public virtual Referees Referee { get; set; } = null!;
	}
}
