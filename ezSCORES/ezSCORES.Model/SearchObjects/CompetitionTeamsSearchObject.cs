using System;
using System.Collections.Generic;
using System.Text;

namespace ezSCORES.Model.SearchObjects
{
	public class CompetitionTeamsSearchObject : BaseCompetitionSearchObject
	{
		public int? TeamId { get; set; }
		public bool? IsEliminated {  get; set; } 
		public int? GroupId { get; set; }
		public bool? IsPlayersIncluded { get; set; }
		public bool? OnlyNullAndCurrentGroup { get; set; }
		public bool? IncludeDeletedRecords { get; set; }
		public int? ApplicationId {  get; set; }
	}
}
