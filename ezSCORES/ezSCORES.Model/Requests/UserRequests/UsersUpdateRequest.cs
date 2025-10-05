using System;
using System.Collections.Generic;
using System.Text;

namespace ezSCORES.Model.Requests.UserRequests
{
    public class UsersUpdateRequest
    {
        public string FirstName { get; set; }

        public string LastName { get; set; }
        public string UserName { get; set; }
		public byte[]? Picture { get; set; }

		public string PhoneNumber { get; set; }
        public string? Organization { get; set; }
        public string? OldPassword { get; set; }
        public string? Password { get; set; }
        public string? PasswordConfirmation { get; set; }
    }
}
