using System;
using System.Collections.Generic;

namespace ezSCORES.Services.Database;

public partial class CompetitionsReferee
{
    public int Id { get; set; }

    public int CompetitionId { get; set; }

    public int RefereeId { get; set; }

    public bool IsDeleted { get; set; }

    public DateTime? RemovedAt { get; set; }

    public bool IsActive { get; set; }

    public DateTime CreatedAt { get; set; }

    public DateTime? ModifiedAt { get; set; }

    public virtual Competition Competition { get; set; } = null!;

    public virtual ICollection<CompetitionsRefereesMatch> CompetitionsRefereesMatches { get; set; } = new List<CompetitionsRefereesMatch>();

    public virtual Referee Referee { get; set; } = null!;
}
