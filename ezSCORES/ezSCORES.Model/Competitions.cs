using ezSCORES.Model.ENUMs;
using System;
using System.Collections.Generic;
using System.Text;

namespace ezSCORES.Model
{
	public class Competitions
	{
		public int Id { get; set; }
		public int UserId { get; set; }

		public int SelectionId { get; set; }

		public string Season { get; set; } = null!;

		public int CityId { get; set; }

		public string Name { get; set; } = null!;

		public string Description { get; set; } = null!;

		public CompetitionType CompetitionType { get; set; }

		public int MaxTeamCount { get; set; }

		public byte[]? Picture { get; set; }

		public DateTime StartDate { get; set; }

		public DateTime ApplicationEndDate { get; set; }

		public int? Fee { get; set; }
		public CompetitionStatus Status { get; set; } = ENUMs.CompetitionStatus.Preparation;

		public int MaxPlayersPerTeam { get; set; }
		public virtual ICollection<CompetitionsReferees> CompetitionsReferees { get; set; } = new List<CompetitionsReferees>();
		public virtual ICollection<CompetitionsSponsors> CompetitionsSponsors { get; set; } = new List<CompetitionsSponsors>();
		public virtual ICollection<Rewards> Rewards { get; set; } = new List<Rewards>();
		public virtual ICollection<Reviews> Reviews { get; set; } = new List<Reviews>();

		public virtual Selections Selection { get; set; } = null!;
		public virtual Cities City { get; set; } = null!;
	}
}
