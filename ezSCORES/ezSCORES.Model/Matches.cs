using System;
using System.Collections.Generic;
using System.Text;

namespace ezSCORES.Model
{
	public class Matches
	{
		public int Id { get; set; }

		public int FixtureId { get; set; }

		public int HomeTeamId { get; set; }

		public int AwayTeamId { get; set; }

		public int StadiumId { get; set; }

		public int? WinnerId { get; set; }

		public DateTime DateAndTime { get; set; }

		public bool IsCompleted { get; set; }

		public bool IsCompletedInRegullarTime { get; set; }
		public bool IsUnderway { get; set; }
	}
}
