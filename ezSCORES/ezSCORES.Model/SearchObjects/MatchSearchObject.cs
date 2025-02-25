using System;
using System.Collections.Generic;
using System.Text;

namespace ezSCORES.Model.SearchObjects
{
	public class MatchSearchObject : BaseSearchObject
	{
		public int? FixtureId { get; set; }

		public int? StadiumId { get; set; }

		public int? WinnerId { get; set; }

		public DateTime? DateAndTime { get; set; }
	}
}
