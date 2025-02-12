using System;
using System.Collections.Generic;
using System.Text;

namespace ezSCORES.Model.Requests
{
	public class SelectionUpsertRequest
	{
		public string Name { get; set; }

		public int? AgeMax { get; set; }
	}
}
