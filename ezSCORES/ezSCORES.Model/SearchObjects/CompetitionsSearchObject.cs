using System;
using System.Collections.Generic;
using System.Text;

namespace ezSCORES.Model.SearchObjects
{
	public class CompetitionsSearchObject
	{
		public int? SelectionId { get; set; }

		public string? Season { get; set; } = null!;

		public int? CityId { get; set; }

		public string? Name { get; set; } = null!;
		public int? CompetitionType { get; set; }
		public DateTime? StartDate { get; set; }

		public DateTime? ApplicationEndDate { get; set; }
		public int? Status { get; set; }
	}
}
