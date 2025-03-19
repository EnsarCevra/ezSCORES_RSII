using Azure.Core;
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
	public class PreparationCompetitionState : BaseCompetitionState
	{
		public PreparationCompetitionState(EzScoresdbRsiiContext context, IMapper mapper, IServiceProvider serviceProvider) : base(context, mapper, serviceProvider)
		{
		}
		public override Competitions Update(int id, CompetitionsUpdateRequest request)
		{
			var set = Context.Set<Competition>();
			var entity = set.Find(id);
			Mapper.Map(request, entity);
			Context.SaveChanges();
			return Mapper.Map<Competitions>(entity);
		}
		public override Competitions OpenAplications(int id)
		{
			var set = Context.Set<Competition>();
			var entity = set.Find(id);
			entity.Status = Model.ENUMs.CompetitionStatus.ApplicationsOpen;
			Context.SaveChanges();
			return Mapper.Map<Competitions>(entity);
		}
	}
}
