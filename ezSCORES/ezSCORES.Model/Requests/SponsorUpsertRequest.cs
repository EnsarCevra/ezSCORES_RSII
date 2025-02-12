using System;
using System.Collections.Generic;
using System.Text;

namespace ezSCORES.Model.Requests
{
	public class SponsorUpsertRequest
	{
		public string Name { get; set; }

		public byte[]? Picture { get; set; }
	}
}
