using System;
using System.Collections.Generic;
using System.Text;

namespace ezSCORES.Model.SearchObjects
{
	public class TeamsSearchObject : BaseSearchObject
	{
		public int? SelectionId { get; set; }
		public bool OnlyUsersTeams { get; set; }
		public bool? IncludeTeamsThatAlreadyAppliedForCompetition { get; set; }
	}
}
