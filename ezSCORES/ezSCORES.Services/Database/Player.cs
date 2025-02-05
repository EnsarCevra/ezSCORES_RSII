using System;
using System.Collections.Generic;

namespace ezSCORES.Services.Database;

public partial class Player
{
    public int Id { get; set; }

    public string FirstName { get; set; } = null!;

    public string LastName { get; set; } = null!;

    public byte[]? Picture { get; set; }

    public DateTime BirthDate { get; set; }

    public bool IsDeleted { get; set; }

    public DateTime? RemovedAt { get; set; }

    public bool IsActive { get; set; }

    public DateTime CreatedAt { get; set; }

    public DateTime? ModifiedAt { get; set; }

    public virtual ICollection<CompetitionsTeamsPlayer> CompetitionsTeamsPlayers { get; set; } = new List<CompetitionsTeamsPlayer>();
}
