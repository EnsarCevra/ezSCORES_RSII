using ezSCORES.Model;
using ezSCORES.Services.Database;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ezSCORES.Services
{
	public class TeamsService : ITeamsService
	{
		public EzScoresdbRsiiContext Context { get; set; }
		public TeamsService(EzScoresdbRsiiContext context)
		{
			Context = context;
		}
		
		public List<Teams> GetList()
		{
			var list = Context.Teams.ToList();
			var result = new List<Model.Teams>();
			list.ForEach(item =>
			{
				result.Add(new Model.Teams()
				{
					Id = item.Id,
					Name = item.Name
				});
			});
			return result;
		}
	}
}
