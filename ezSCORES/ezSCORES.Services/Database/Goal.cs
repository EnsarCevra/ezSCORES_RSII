using System;
using System.Collections.Generic;

namespace ezSCORES.Services.Database;

public partial class Goal
{
    public int Id { get; set; }

    public int? CompetitionTeamPlayerId { get; set; }

    public int MatchId { get; set; }

    public int SequenceNumber { get; set; }

    public int ScoredAtMinute { get; set; }

    public bool IsHomeGoal { get; set; }

    public bool IsDeleted { get; set; }

    public DateTime? RemovedAt { get; set; }

    public bool IsActive { get; set; }

    public DateTime CreatedAt { get; set; }

    public DateTime? ModifiedAt { get; set; }

    public virtual CompetitionsTeamsPlayer? CompetitionTeamPlayer { get; set; }

    public virtual Match Match { get; set; } = null!;
}
