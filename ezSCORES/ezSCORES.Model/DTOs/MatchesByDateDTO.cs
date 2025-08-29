using System;
using System.Collections.Generic;
using System.Text;

namespace ezSCORES.Model.DTOs
{
	public  class MatchesByDateDTO
	{
		public int CompetitionId { get; set; }
		public string CompetitionName { get; set;}
		public List<MatchDTO> Matches { get; set; }
	}
}
