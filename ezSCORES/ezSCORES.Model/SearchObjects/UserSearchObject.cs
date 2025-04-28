using System;
using System.Collections.Generic;
using System.Text;

namespace ezSCORES.Model.SearchObjects
{
	public class UserSearchObject : BaseSearchObject
	{
		public string? FirstNameGTE { get; set; }
		public string? LastNameGTE { get; set; }
		public int? RoleId { get; set; }
		public string? UserName { get; set; }
		public string? Email { get; set; }
		public bool? IsRolesIncluded { get; set; }
		public string? OrderBy { get; set; }
	}
}
