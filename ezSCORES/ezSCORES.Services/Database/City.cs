using System;
using System.Collections.Generic;

namespace ezSCORES.Services.Database;

public partial class City
{
    public int Id { get; set; }

    public string Name { get; set; } = null!;

    public bool IsDeleted { get; set; }

    public DateTime? RemovedAt { get; set; }

    public bool IsActive { get; set; }

    public DateTime CreatedAt { get; set; }

    public DateTime? ModifiedAt { get; set; }

    public virtual ICollection<Competition> Competitions { get; set; } = new List<Competition>();
}
