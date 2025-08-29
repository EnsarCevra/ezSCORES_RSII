using System;
using System.Collections.Generic;
using System.Text;

namespace ezSCORES.Model
{
	public class FavoriteCompetitions
	{
		public int Id { get; set; }

		public int UserId { get; set; }

		public int CompetitionId { get; set; }
		public virtual Competitions? Competition { get; set; }
	}
}
