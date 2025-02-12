using System;
using System.Collections.Generic;

namespace ezSCORES.Services.Database;

public partial class Sponsor : ICreated, IModified, ISoftDelete
{
    public int Id { get; set; }

    public string Name { get; set; } = null!;

    public byte[]? Picture { get; set; }

    public bool IsDeleted { get; set; }

    public DateTime? RemovedAt { get; set; }

    public bool IsActive { get; set; }

    public DateTime CreatedAt { get; set; }

    public DateTime? ModifiedAt { get; set; }

    public virtual ICollection<CompetitionsSponsor> CompetitionsSponsors { get; set; } = new List<CompetitionsSponsor>();
}
