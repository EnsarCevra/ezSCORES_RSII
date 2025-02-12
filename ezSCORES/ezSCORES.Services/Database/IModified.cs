using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ezSCORES.Services.Database
{
	internal interface IModified
	{
		public DateTime? ModifiedAt { get; set; }
	}
}
