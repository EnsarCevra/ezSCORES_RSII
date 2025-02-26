using System;
using System.Collections.Generic;
using System.Text;

namespace ezSCORES.Model
{
	public class CompetitionsTeams
	{
		public int Id { get; set; }

		public int CompetitionId { get; set; }

		public int TeamId { get; set; }

		public int? GroupId { get; set; }

		public bool IsEliminated { get; set; }
		public virtual ICollection<CompetitionsTeamsPlayers> CompetitionsTeamsPlayers { get; set; } = new List<CompetitionsTeamsPlayers>();
	}
}
