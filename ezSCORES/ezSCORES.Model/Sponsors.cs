using System;
using System.Collections.Generic;
using System.Text;

namespace ezSCORES.Model
{
	public class Sponsors
	{
		public int Id { get; set; }

		public string Name { get; set; } = null!;

		public byte[]? Picture { get; set; }
	}
}
