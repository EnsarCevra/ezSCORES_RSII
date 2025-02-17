using System;
using System.Collections.Generic;
using System.Text;

namespace ezSCORES.Model.Requests.GroupRequests
{
	public class GroupInsertRequest
	{
		public int CompetitionId { get; set; }

		public string Name { get; set; } = null!;
	}
}
