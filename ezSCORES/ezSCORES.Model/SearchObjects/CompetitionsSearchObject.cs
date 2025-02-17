using System;
using System.Collections.Generic;
using System.Text;

namespace ezSCORES.Model.SearchObjects
{
	public class CompetitionsSearchObject : BaseSearchObject
	{
		public int? SelectionId { get; set; }

		public string? Season { get; set; } = null!;

		public int? CityId { get; set; }
		public int? CompetitionType { get; set; }
		public DateTime? StartDate { get; set; }

		public DateTime? ApplicationEndDate { get; set; }
		public int? Status { get; set; }
		public bool? IsCompetitionRefereesIncluded { get; set; }
	}
}
