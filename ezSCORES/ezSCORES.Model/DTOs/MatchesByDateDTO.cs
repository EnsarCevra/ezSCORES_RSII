using System;
using System.Collections.Generic;
using System.Text;

namespace ezSCORES.Model.DTOs
{
	public  class MatchesByDateDTO
	{
		public Competitions Competition { get; set; }
		public List<MatchDTO> Matches { get; set; }
	}
}
