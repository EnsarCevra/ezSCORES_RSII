using ezSCORES.Model.ENUMs;
using System;
using System.Collections.Generic;
using System.Text;

namespace ezSCORES.Model
{
	public class Fixtures
	{
		public int Id { get; set; }

		public int CompetitionId { get; set; }

		public int SequenceNumber { get; set; }

		public int MatchLength { get; set; }

		public GameStage GameStage { get; set; }

		public bool IsCurrentlyActive { get; set; }

		public bool IsCompleted { get; set; }
	}
}
