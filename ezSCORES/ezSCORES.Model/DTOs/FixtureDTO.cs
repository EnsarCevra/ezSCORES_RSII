using ezSCORES.Model.ENUMs;
using System;
using System.Collections.Generic;
using System.Text;

namespace ezSCORES.Model.DTOs
{
	public class FixtureDTO
	{
		public int Id { get; set; }
		public GameStage GameStage { get; set; }
		public int SequenceNumber { get; set; }
		public List<MatchDTO> Matches { get; set; }
	}
}
