using System;
using System.Collections.Generic;

namespace ezSCORES.Services.Database;

public partial class Selection
{
    public int Id { get; set; }

    public string Name { get; set; } = null!;

    public int? AgeMax { get; set; }

    public bool IsDeleted { get; set; }

    public DateOnly? RemovedAt { get; set; }

    public bool IsActive { get; set; }

    public DateOnly CreatedAt { get; set; }

    public DateOnly? ModifiedAt { get; set; }

    public virtual ICollection<Competition> Competitions { get; set; } = new List<Competition>();

    public virtual ICollection<Team> Teams { get; set; } = new List<Team>();
}
