using System;
using System.Collections.Generic;
using System.Text;

namespace ezSCORES.Model.DTOs
{
	public class AdminDashboardDTO
	{
		public int Competitions { get; set; }
		public int Teams {  get; set; }
		public int Players { get; set; }
		public CompetitionsByStatusCountDTO CompetitionsByStatus { get; set; }
		public Dictionary<int, int> CompetitionsByMonth { get; set; }
	}
	public class CompetitionsByStatusCountDTO
	{
		public int PreparationCount { get; set; }
		public int ApplicationsOpenedCount { get; set; }
		public int ApplicationsClosedCount { get; set; }
		public int UnderwayCount { get; set; }
		public int FinishedCount { get; set; }
	}
}
