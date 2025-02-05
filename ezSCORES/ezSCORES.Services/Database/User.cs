using System;
using System.Collections.Generic;

namespace ezSCORES.Services.Database;

public partial class User
{
    public int Id { get; set; }

    public int RoleId { get; set; }

    public string FirstName { get; set; } = null!;

    public string LastName { get; set; } = null!;

    public string UserName { get; set; } = null!;

    public byte[]? Picture { get; set; }

    public string Email { get; set; } = null!;

    public string PhoneNumber { get; set; }

    public bool IsActive { get; set; }

    public string PasswordHash { get; set; } = null!;

    public string PasswordSalt { get; set; } = null!;

    public bool IsDeleted { get; set; }

    public DateTime? RemovedAt { get; set; }

    public string? Organization { get; set; }

    public DateTime CreatedAt { get; set; }

    public DateTime? ModifiedAt { get; set; }

    public virtual ICollection<Competition> Competitions { get; set; } = new List<Competition>();

    public virtual ICollection<FavoriteCompetition> FavoriteCompetitions { get; set; } = new List<FavoriteCompetition>();

    public virtual ICollection<Review> Reviews { get; set; } = new List<Review>();

    public virtual Role Role { get; set; } = null!;

    public virtual ICollection<Team> Teams { get; set; } = new List<Team>();
}
