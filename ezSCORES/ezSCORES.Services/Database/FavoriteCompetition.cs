using System;
using System.Collections.Generic;

namespace ezSCORES.Services.Database;

public partial class FavoriteCompetition
{
    public int Id { get; set; }

    public int UserId { get; set; }

    public int CompetitionId { get; set; }

    public bool IsDeleted { get; set; }

    public DateTime? RemovedAt { get; set; }

    public bool IsActive { get; set; }

    public DateTime CreatedAt { get; set; }

    public DateTime? ModifiedAt { get; set; }

    public virtual Competition Competition { get; set; } = null!;

    public virtual User User { get; set; } = null!;
}
