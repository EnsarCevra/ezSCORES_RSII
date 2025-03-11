using System;
using System.Collections.Generic;
using System.Text;

namespace ezSCORES.Model
{
	public  class Teams
	{
		public int Id { get; set; }
		public int UserId { get; set; }
		public string Name { get; set; }
		public int SelectionId { get; set; }
		public byte[]? Picture { get; set; }
		public virtual Users User { get; set; } = null!;
		public virtual Selections Selection { get; set; } = null!;
		public virtual ICollection<CompetitionsTeams> CompetitionsTeams { get; set; } = new List<CompetitionsTeams>();
	}
}
