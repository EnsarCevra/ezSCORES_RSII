﻿using System;
using System.Collections.Generic;

namespace ezSCORES.Services.Database;

public partial class Review
{
    public int Id { get; set; }

    public int UserId { get; set; }

    public int CompetitionId { get; set; }

    public float Rating { get; set; }

    public bool IsDeleted { get; set; }

    public DateOnly? RemovedAt { get; set; }

    public bool IsActive { get; set; }

    public DateOnly CreatedAt { get; set; }

    public DateOnly ModifiedAt { get; set; }

    public virtual Competition Competition { get; set; } = null!;

    public virtual User User { get; set; } = null!;
}
