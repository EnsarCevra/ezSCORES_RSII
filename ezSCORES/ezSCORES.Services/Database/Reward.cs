using System;
using System.Collections.Generic;

namespace ezSCORES.Services.Database;

public partial class Reward : ICreated, IModified, ISoftDelete, IHasName
{
    public int Id { get; set; }

    public int CompetitionId { get; set; }

    public string Name { get; set; } = null!;

    public int? RankingPosition { get; set; }

    public int Amount { get; set; }

    public string? Description { get; set; }

    public bool IsDeleted { get; set; }

    public DateTime? RemovedAt { get; set; }

    public bool IsActive { get; set; }

    public DateTime CreatedAt { get; set; }

    public DateTime? ModifiedAt { get; set; }

    public virtual Competition Competition { get; set; } = null!;
}
