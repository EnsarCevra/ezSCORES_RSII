using System;
using System.Collections.Generic;
using System.Text;

namespace ezSCORES.Model.SearchObjects
{
	public class ApplicationSearchObject : BaseSearchObject
	{
		public int TeamId { get; set; }

		public int CompetitionId { get; set; }

		public bool IsPaId { get; set; }

		public bool? IsAccepted { get; set; }
	}
}
