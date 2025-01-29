using ezSCORES.Model;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ezSCORES.Services
{
	public class TeamsService : ITeamsService
	{
		public List<Teams> List = new List<Teams>()
		{
			new Teams
			{
				Id = 1,
				Name = "Bjelopoljac"
			},
			new Teams
			{
				Id = 2,
				Name = "Lokomotiva"
			}
		};
		public List<Teams> GetList()
		{
			return List;
		}
	}
}
