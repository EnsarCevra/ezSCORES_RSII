using System;
using System.Collections.Generic;
using System.Text;

namespace ezSCORES.Model.Requests.UserRequests
{
    public class UsersInsertRequests
    {
        public int RoleId { get; set; }
        public string FirstName { get; set; }

        public string LastName { get; set; }

        public string UserName { get; set; }

        public string? Email { get; set; }

        public string? PhoneNumber { get; set; }


        public string? Organization { get; set; }
        public string Password { get; set; }
        public string PasswordConfirmation { get; set; }
    }
}
