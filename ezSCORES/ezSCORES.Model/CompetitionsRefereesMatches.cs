using System;
using System.Collections.Generic;
using System.Text;

namespace ezSCORES.Model
{
	public class CompetitionsRefereesMatches
	{
		public int Id { get; set; }

		public int CompetitionsRefereesId { get; set; }

		public int MatchId { get; set; }
		public virtual CompetitionsReferees CompetitionReferee { get; set; }
	}
}
