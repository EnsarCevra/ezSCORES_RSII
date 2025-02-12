using System;
using System.Collections.Generic;
using System.Text;

namespace ezSCORES.Model
{
	public class Referees
	{
		public int Id { get; set; }

		public string FirstName { get; set; } = null!;

		public string LastName { get; set; } = null!;

		public byte[]? Picture { get; set; }
	}
}
