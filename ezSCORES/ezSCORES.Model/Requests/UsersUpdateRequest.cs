﻿using System;
using System.Collections.Generic;
using System.Text;

namespace ezSCORES.Model.Requests
{
	public class UsersUpdateRequest
	{
		public string FirstName { get; set; }

		public string LastName { get; set; }

		public int? PhoneNumber { get; set; }


		public string? Organization { get; set; }
		public string? Password { get; set; }
		public string? PasswordConfirmation { get; set; }
	}
}
