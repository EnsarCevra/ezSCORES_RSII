using ezSCORES.Model.Messages;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ezSCORESSubscriber
{
	public interface IEmailService
	{
		Task SendEmail(ApplicationStatusChanged msg);
	}
}
