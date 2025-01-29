using ezSCORES.Model;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ezSCORES.Services
{
	public interface ITeamsService
	{
		List<Teams> GetList();
	}
}
