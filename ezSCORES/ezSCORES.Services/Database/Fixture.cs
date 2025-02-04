using System;
using System.Collections.Generic;

namespace ezSCORES.Services.Database;

public partial class Fixture
{
    public int Id { get; set; }

    public int CompetitionId { get; set; }

    public int SequenceNumber { get; set; }

    public int MatchLength { get; set; }

    public int GameStage { get; set; }

    public bool IsCurrentlyActive { get; set; }

    public bool IsCompleted { get; set; }

    public bool IsDeleted { get; set; }

    public DateOnly? RemovedAt { get; set; }

    public bool IsActive { get; set; }

    public DateOnly CreatedAt { get; set; }

    public DateOnly? ModifiedAt { get; set; }

    public virtual Competition Competition { get; set; } = null!;

    public virtual ICollection<Match> Matches { get; set; } = new List<Match>();
}
