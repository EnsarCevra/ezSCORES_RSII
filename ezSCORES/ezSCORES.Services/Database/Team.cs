using System;
using System.Collections.Generic;

namespace ezSCORES.Services.Database;

public partial class Team : ICreated, IModified, ISoftDelete
{
    public int Id { get; set; }

    public int UserId { get; set; }

    public int SelectionId { get; set; }

    public string Name { get; set; } = null!;

    public byte[]? Picture { get; set; }

    public bool IsDeleted { get; set; }

    public DateTime? RemovedAt { get; set; }

    public bool IsActive { get; set; }

    public DateTime CreatedAt { get; set; }

    public DateTime? ModifiedAt { get; set; }

    public virtual ICollection<Application> Applications { get; set; } = new List<Application>();

    public virtual ICollection<CompetitionsTeam> CompetitionsTeams { get; set; } = new List<CompetitionsTeam>();

    public virtual Selection Selection { get; set; } = null!;

    public virtual User User { get; set; } = null!;
}
