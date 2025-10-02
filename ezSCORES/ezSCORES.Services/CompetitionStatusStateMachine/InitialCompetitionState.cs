using ezSCORES.Model;
using ezSCORES.Model.Requests.CompetitionRequests;
using ezSCORES.Services.Auth;
using ezSCORES.Services.Database;
using ezSCORES.Services.Recommender;
using MapsterMapper;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ezSCORES.Services.CompetitionStatusStateMachine
{
	public class InitialCompetitionState : BaseCompetitionState
	{
		private readonly IActiveUserService _activeUserService;
		public InitialCompetitionState(EzScoresdbRsiiContext context, IMapper mapper, IServiceProvider serviceProvider, IActiveUserService activeUserService) : base(context, mapper, serviceProvider)
		{
			_activeUserService = activeUserService;
		}

		public override Competitions Insert(CompetitionsInsertRequest request)
		{
			var set = Context.Set<Competition>();
			var entity = Mapper.Map<Competition>(request);
			if (Context.Competitions.Any(x => x.Name == request.Name))
			{
				throw new UserException("Entitet sa ovim imenom već postoji!");
			}
			entity.UserId = _activeUserService.GetActiveUserId() ?? throw new InvalidOperationException("Authenticated user ID cannot be null.");
			entity.Status = Model.ENUMs.CompetitionStatus.Preparation;
			set.Add(entity);
			Context.SaveChanges();
			return Mapper.Map<Competitions>(entity);
		}
		public override Competitions Preparation(int id)
		{
			var set = Context.Set<Competition>();
			var entity = set.Find(id);
			entity.Status = Model.ENUMs.CompetitionStatus.Preparation;
			Context.SaveChanges();
			return Mapper.Map<Competitions>(entity);
		}
	}
}
