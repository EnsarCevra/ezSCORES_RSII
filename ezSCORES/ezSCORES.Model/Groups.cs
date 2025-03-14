using System;
using System.Collections.Generic;
using System.Text;

namespace ezSCORES.Model
{
	public class Groups
	{
		public int Id { get; set; }

		public int CompetitionId { get; set; }

		public string Name { get; set; } = null!;
		public virtual ICollection<CompetitionsTeams> CompetitionsTeams { get; set; } = new List<CompetitionsTeams>();
	}
}
