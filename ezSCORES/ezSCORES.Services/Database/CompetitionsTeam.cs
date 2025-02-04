using System;
using System.Collections.Generic;

namespace ezSCORES.Services.Database;

public partial class CompetitionsTeam
{
    public int Id { get; set; }

    public int CompetitionId { get; set; }

    public int TeamId { get; set; }

    public int? GroupId { get; set; }

    public bool IsEliminated { get; set; }

    public bool IsDeleted { get; set; }

    public DateOnly? RemovedAt { get; set; }

    public bool IsActive { get; set; }

    public DateOnly CreatedAt { get; set; }

    public DateOnly? ModifiedAt { get; set; }

    public virtual Competition Competition { get; set; } = null!;

    public virtual ICollection<CompetitionsTeamsPlayer> CompetitionsTeamsPlayers { get; set; } = new List<CompetitionsTeamsPlayer>();

    public virtual Group? Group { get; set; }

    public virtual ICollection<Match> MatchAwayTeams { get; set; } = new List<Match>();

    public virtual ICollection<Match> MatchHomeTeams { get; set; } = new List<Match>();

    public virtual ICollection<Match> MatchWinners { get; set; } = new List<Match>();

    public virtual Team Team { get; set; } = null!;
}
