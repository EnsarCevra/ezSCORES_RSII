using System;
using System.Collections.Generic;

namespace ezSCORES.Services.Database;

public partial class CompetitionsReferee
{
    public int Id { get; set; }

    public int CompetitionId { get; set; }

    public int RefereeId { get; set; }

    public bool IsDeleted { get; set; }

    public DateOnly? RemovedAt { get; set; }

    public bool IsActive { get; set; }

    public DateOnly CreatedAt { get; set; }

    public DateOnly? ModifiedAt { get; set; }

    public virtual Competition Competition { get; set; } = null!;

    public virtual ICollection<CompetitionsRefereesMatch> CompetitionsRefereesMatches { get; set; } = new List<CompetitionsRefereesMatch>();

    public virtual Referee Referee { get; set; } = null!;
}
