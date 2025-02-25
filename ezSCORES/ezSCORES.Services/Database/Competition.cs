using ezSCORES.Model.ENUMs;
using System;
using System.Collections.Generic;

namespace ezSCORES.Services.Database;

public partial class Competition : ICreated, IModified, ISoftDelete
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

    public bool IsDeleted { get; set; }

    public DateTime? RemovedAt { get; set; }

    public CompetitionStatus Status { get; set; }

    public int MaxPlayersPerTeam { get; set; }

    public bool IsActive { get; set; }

    public DateTime CreatedAt { get; set; }

    public DateTime? ModifiedAt { get; set; }

    public virtual ICollection<Application> Applications { get; set; } = new List<Application>();

    public virtual City City { get; set; } = null!;

    public virtual ICollection<CompetitionsReferee> CompetitionsReferees { get; set; } = new List<CompetitionsReferee>();

    public virtual ICollection<CompetitionsSponsor> CompetitionsSponsors { get; set; } = new List<CompetitionsSponsor>();

    public virtual ICollection<CompetitionsTeam> CompetitionsTeams { get; set; } = new List<CompetitionsTeam>();

    public virtual ICollection<FavoriteCompetition> FavoriteCompetitions { get; set; } = new List<FavoriteCompetition>();

    public virtual ICollection<Fixture> Fixtures { get; set; } = new List<Fixture>();

    public virtual ICollection<Group> Groups { get; set; } = new List<Group>();

    public virtual ICollection<Review> Reviews { get; set; } = new List<Review>();

    public virtual ICollection<Reward> Rewards { get; set; } = new List<Reward>();

    public virtual Selection Selection { get; set; } = null!;

    public virtual User User { get; set; } = null!;
}
