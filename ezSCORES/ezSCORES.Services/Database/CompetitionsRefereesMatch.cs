using System;
using System.Collections.Generic;

namespace ezSCORES.Services.Database;

public partial class CompetitionsRefereesMatch
{
    public int Id { get; set; }

    public int CompetitionsRefereesId { get; set; }

    public int MatchId { get; set; }

    public bool IsActive { get; set; }

    public bool IsDeleted { get; set; }

    public DateOnly? RemovedAt { get; set; }

    public DateOnly CreatedAt { get; set; }

    public DateOnly? ModifiedAt { get; set; }

    public virtual CompetitionsReferee CompetitionsReferees { get; set; } = null!;

    public virtual Match Match { get; set; } = null!;
}
