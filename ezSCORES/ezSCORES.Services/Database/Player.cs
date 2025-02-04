using System;
using System.Collections.Generic;

namespace ezSCORES.Services.Database;

public partial class Player
{
    public int Id { get; set; }

    public string FirstName { get; set; } = null!;

    public string LastName { get; set; } = null!;

    public byte[]? Picture { get; set; }

    public DateOnly BirthDate { get; set; }

    public bool IsDeleted { get; set; }

    public DateOnly? RemovedAt { get; set; }

    public bool IsActive { get; set; }

    public DateOnly CreatedAt { get; set; }

    public DateOnly? ModifiedAt { get; set; }

    public virtual ICollection<CompetitionsTeamsPlayer> CompetitionsTeamsPlayers { get; set; } = new List<CompetitionsTeamsPlayer>();
}
