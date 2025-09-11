using System;
using System.Collections.Generic;
using System.Text;

namespace ezSCORES.Model
{
	public class Applications
	{
		public int Id { get; set; }

		public int TeamId { get; set; }

		public int CompetitionId { get; set; }

		public string? Message { get; set; }

		public bool IsPaId { get; set; }

		public float? PaIdAmount { get; set; }

		public bool? IsAccepted { get; set; }
		public virtual Teams Team { get; set; } = null!;
		public virtual Competitions Competition { get; set; } = null!;
	}
}
