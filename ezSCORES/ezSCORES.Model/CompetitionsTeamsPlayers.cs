using System;
using System.Collections.Generic;
using System.Numerics;
using System.Text;

namespace ezSCORES.Model
{
	public class CompetitionsTeamsPlayers
	{
		public int Id { get; set; }

		public int CompetitionsTeamsId { get; set; }

		public int PlayerId { get; set; }

		public int GoalsTotal { get; set; }

		public bool IsVerified { get; set; }
		public virtual Players Player { get; set; } = null!;
	}
}
