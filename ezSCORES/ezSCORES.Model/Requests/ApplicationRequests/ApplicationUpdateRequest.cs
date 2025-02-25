﻿using System;
using System.Collections.Generic;
using System.Text;

namespace ezSCORES.Model.Requests.ApplicationRequests
{
	public class ApplicationUpdateRequest
	{
		public int TeamId { get; set; }

		public int CompetitionId { get; set; }

		public string? Message { get; set; }
		public List<int>? PlayerIds { get; set; }
	}
}
