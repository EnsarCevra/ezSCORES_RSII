using System;
using System.Collections.Generic;
using System.Text;

namespace ezSCORES.Model.Requests.FixtureRequests
{
	public class GetFixturesByCompetitionRequest
	{
		public int competitionId {  get; set; }
		public bool GetSchedule {  get; set; }//if yes get unfinished games, if no get finished games
	}
}
