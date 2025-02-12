using System;
using System.Collections.Generic;
using System.Text;

namespace ezSCORES.Model.Requests
{
	public class PlayerUpsertRequest
	{
		public string FirstName { get; set; }

		public string LastName { get; set; } 

		public byte[]? Picture { get; set; }

		public DateTime BirthDate { get; set; }
	}
}
