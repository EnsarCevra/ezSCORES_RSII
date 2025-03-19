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
	public class UnderwayCompetitionState : BaseCompetitionState
	{
		public UnderwayCompetitionState(EzScoresdbRsiiContext context, IMapper mapper, IServiceProvider serviceProvider) : base(context, mapper, serviceProvider)
		{
		}

		public override Competitions FinishCompetition(int id)
		{
			var set = Context.Set<Competition>();
			var entity = set.Find(id);
			entity.Status = Model.ENUMs.CompetitionStatus.Finished;
			Context.SaveChanges();
			return Mapper.Map<Competitions>(entity);
		}
	}
}
