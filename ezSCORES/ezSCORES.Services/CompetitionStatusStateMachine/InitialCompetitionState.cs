using ezSCORES.Model;
using ezSCORES.Model.Requests.CompetitionRequests;
using ezSCORES.Services.Database;
using MapsterMapper;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ezSCORES.Services.CompetitionStatusStateMachine
{
	public class InitialCompetitionState : BaseCompetitionState
	{
		public InitialCompetitionState(EzScoresdbRsiiContext context, IMapper mapper, IServiceProvider serviceProvider) : base(context, mapper, serviceProvider)
		{
		}

		public override Competitions Insert(CompetitionsInsertRequest request)
		{
			var set = Context.Set<Competition>();
			var entity = Mapper.Map<Competition>(request);
			entity.Status = Model.ENUMs.CompetitionStatus.Preparation;
			set.Add(entity);
			Context.SaveChanges();

			return Mapper.Map<Competitions>(entity);
		}
	}
}
