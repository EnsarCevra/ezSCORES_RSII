using System;
using System.Collections.Generic;
using System.Text;

namespace ezSCORES.Model.DTOs
{
	public class TeamDTO
	{
		public int Id { get; set; }
		public string Name { get; set; }
		public byte[]? Picture { get; set; }
		public List<PlayerDTO> Players { get; set; }
	}
}
