using System;
using System.Collections.Generic;
using System.Data;

namespace ezSCORES.Model
{
	public partial class Users
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

		public string? Organization { get; set; }
		public virtual Roles Role { get; set; } = null!;
	}

}