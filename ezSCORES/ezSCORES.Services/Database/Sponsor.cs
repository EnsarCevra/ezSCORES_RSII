using System;
using System.Collections.Generic;

namespace ezSCORES.Services.Database;

public partial class Sponsor
{
    public int Id { get; set; }

    public string Name { get; set; } = null!;

    public byte[]? Picture { get; set; }

    public bool IsDeleted { get; set; }

    public DateOnly? RemovedAt { get; set; }

    public bool IsActive { get; set; }

    public DateOnly CreatedAt { get; set; }

    public DateOnly? ModifiedAt { get; set; }

    public virtual ICollection<CompetitionsSponsor> CompetitionsSponsors { get; set; } = new List<CompetitionsSponsor>();
}
