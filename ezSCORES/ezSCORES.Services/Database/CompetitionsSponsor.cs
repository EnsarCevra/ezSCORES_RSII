using System;
using System.Collections.Generic;

namespace ezSCORES.Services.Database;

public partial class CompetitionsSponsor
{
    public int Id { get; set; }

    public int CompetitionId { get; set; }

    public int SponsorId { get; set; }

    public int? Type { get; set; }

    public bool IsDeleted { get; set; }

    public DateTime? RemovedAt { get; set; }

    public bool IsActive { get; set; }

    public DateTime CreatedAt { get; set; }

    public DateTime? ModifiedAt { get; set; }

    public virtual Competition Competition { get; set; } = null!;

    public virtual Sponsor Sponsor { get; set; } = null!;
}
