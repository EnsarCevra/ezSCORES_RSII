using System;
using System.Collections.Generic;
using System.Text;

namespace ezSCORES.Model
{
	public class UserException : Exception
	{
        public UserException(string messaage) : base(messaage)  { }
    }
}
