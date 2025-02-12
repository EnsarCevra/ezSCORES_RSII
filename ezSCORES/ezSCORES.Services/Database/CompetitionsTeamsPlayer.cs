using System;
using System.Collections.Generic;

namespace ezSCORES.Services.Database;

public partial class CompetitionsTeamsPlayer : ICreated, IModified, ISoftDelete
{
    public int Id { get; set; }

    public int CompetitionsTeamsId { get; set; }

    public int PlayerId { get; set; }

    public int GoalsTotal { get; set; }

    public bool IsVerified { get; set; }

    public bool IsDeleted { get; set; }

    public DateTime? RemovedAt { get; set; }
	public bool IsActive { get; set; }
	public DateTime CreatedAt { get; set; }

	public DateTime? ModifiedAt { get; set; }

	public virtual CompetitionsTeam CompetitionsTeams { get; set; } = null!;

    public virtual ICollection<Goal> Goals { get; set; } = new List<Goal>();

    public virtual Player Player { get; set; } = null!;
}
