using System;
using System.Collections.Generic;

namespace ezSCORES.Services.Database;

public partial class Referee : ICreated, IModified, ISoftDelete
{
    public int Id { get; set; }

    public string FirstName { get; set; } = null!;

    public string LastName { get; set; } = null!;

    public byte[]? Picture { get; set; }

    public bool IsDeleted { get; set; }

    public DateTime? RemovedAt { get; set; }

    public bool IsActive { get; set; }

    public DateTime CreatedAt { get; set; }

    public DateTime? ModifiedAt { get; set; }

    public virtual ICollection<CompetitionsReferee> CompetitionsReferees { get; set; } = new List<CompetitionsReferee>();
}
