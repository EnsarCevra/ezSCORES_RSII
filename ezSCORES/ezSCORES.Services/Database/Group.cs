using System;
using System.Collections.Generic;

namespace ezSCORES.Services.Database;

public partial class Group
{
    public int Id { get; set; }

    public int CompetitionId { get; set; }

    public string Name { get; set; } = null!;

    public bool IsDeleted { get; set; }

    public DateOnly? RemovedAt { get; set; }

    public bool IsActive { get; set; }

    public DateOnly CreatedAt { get; set; }

    public DateOnly? ModifiedAt { get; set; }

    public virtual Competition Competition { get; set; } = null!;

    public virtual ICollection<CompetitionsTeam> CompetitionsTeams { get; set; } = new List<CompetitionsTeam>();
}
