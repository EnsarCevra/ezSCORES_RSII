using System;
using System.Collections.Generic;
using System.Text;

namespace ezSCORES.Model.SearchObjects
{
	public class CompetitionTeamsSearchObject : BaseCompetitionSearchObject
	{
		public int? TeamId { get; set; }
		public bool? isEliminated {  get; set; } 
		public int? GroupId { get; set; }
		public bool? isPlayersIncluded { get; set; }
	}
}
