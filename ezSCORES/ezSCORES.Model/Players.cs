using System;
using System.Collections.Generic;
using System.Text;

namespace ezSCORES.Model
{
	public class Players
	{
		public int Id { get; set; }

		public string FirstName { get; set; } = null!;

		public string LastName { get; set; } = null!;

		public byte[]? Picture { get; set; }

		public DateTime BirthDate { get; set; }
	}
}
