using System;
using System.Collections.Generic;
using System.Text;

namespace ezSCORES.Model.SearchObjects
{
	public class PlayersSearchObject : BaseSearchObject
	{
		public string? FirstNameLastNameGTE { get; set; }
		public DateTime? BirthDate { get; set; }
		public int? Year { get; set; }
	}
}
