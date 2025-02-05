using System;
using System.Collections.Generic;

namespace ezSCORES.Services.Database;

public partial class Match
{
    public int Id { get; set; }

    public int FixtureId { get; set; }

    public int HomeTeamId { get; set; }

    public int AwayTeamId { get; set; }

    public int StadiumId { get; set; }

    public int? WinnerId { get; set; }

    public DateTime DateAndTime { get; set; }

    public bool IsCompleted { get; set; }

    public bool IsCompletedInRegullarTime { get; set; }

    public bool IsCurrentlyActive { get; set; }

    public bool IsDeleted { get; set; }

    public DateTime? RemovedAt { get; set; }

    public bool IsUnderway { get; set; }

    public bool IsActive { get; set; }

    public DateTime CreatedAt { get; set; }

    public DateTime? ModifiedAt { get; set; }

    public virtual CompetitionsTeam AwayTeam { get; set; } = null!;

    public virtual ICollection<CompetitionsRefereesMatch> CompetitionsRefereesMatches { get; set; } = new List<CompetitionsRefereesMatch>();

    public virtual Fixture Fixture { get; set; } = null!;

    public virtual ICollection<Goal> Goals { get; set; } = new List<Goal>();

    public virtual CompetitionsTeam HomeTeam { get; set; } = null!;

    public virtual Stadium Stadium { get; set; } = null!;

    public virtual CompetitionsTeam? Winner { get; set; }
}
