using Azure.Core;
using ezSCORES.Model;
using ezSCORES.Services.Database;
using MapsterMapper;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ezSCORES.Services.CompetitionStatusStateMachine
{
	public class ApplicationsClosedCompetitionState : BaseCompetitionState
	{
		public ApplicationsClosedCompetitionState(EzScoresdbRsiiContext context, IMapper mapper, IServiceProvider serviceProvider) : base(context, mapper, serviceProvider)
		{
		}

		public override Competitions StartCompetition(int id)
		{
			var set = Context.Set<Competition>();
			var entity = set.Find(id);
			entity.Status = Model.ENUMs.CompetitionStatus.Underway;
			Context.SaveChanges();
			return Mapper.Map<Competitions>(entity);
		}
	}
}
