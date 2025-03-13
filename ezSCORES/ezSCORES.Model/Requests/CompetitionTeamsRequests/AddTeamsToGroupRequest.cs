using System;
using System.Collections.Generic;
using System.Text;

namespace ezSCORES.Model.Requests.CompetitionTeamsRequests
{
	public class AddTeamsToGroupRequest
	{
		public int GroupId { get; set; }
		public int CompetitionId {  get; set; }
		public List<int> CompetitionTeamIds { get; set; }
	}
}
