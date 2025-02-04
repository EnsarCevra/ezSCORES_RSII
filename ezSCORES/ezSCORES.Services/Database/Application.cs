using System;
using System.Collections.Generic;

namespace ezSCORES.Services.Database;

public partial class Application
{
    public int Id { get; set; }

    public int TeamId { get; set; }

    public int CompetitionId { get; set; }

    public string? Message { get; set; }

    public bool IsPaId { get; set; }

    public float? PaIdAmount { get; set; }

    public bool? IsAccepted { get; set; }

    public bool IsDeleted { get; set; }

    public DateOnly? RemovedAt { get; set; }

    public bool IsActive { get; set; }

    public DateOnly CreatedAt { get; set; }

    public DateOnly? ModifiedAt { get; set; }

    public virtual Competition Competition { get; set; } = null!;

    public virtual Team Team { get; set; } = null!;
}
