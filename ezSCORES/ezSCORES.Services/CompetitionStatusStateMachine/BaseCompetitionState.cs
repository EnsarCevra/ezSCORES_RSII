using ezSCORES.Model;
using ezSCORES.Model.Requests.CompetitionRequests;
using ezSCORES.Services.Database;
using MapsterMapper;
using Microsoft.Extensions.DependencyInjection;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ezSCORES.Services.CompetitionStatusStateMachine
{
	public class BaseCompetitionState
	{
		// each state can activate next one and that is it with feqw exceptions like aplOpen to aplClosed and vice versa...
		public EzScoresdbRsiiContext Context { get; set; }
		public IMapper Mapper;
		public IServiceProvider ServiceProvider;
		public BaseCompetitionState(EzScoresdbRsiiContext context, IMapper mapper, IServiceProvider serviceProvider)
		{
			Context = context;
			Mapper = mapper;
			ServiceProvider = serviceProvider;
		}
		public virtual Model.Competitions Insert(CompetitionsInsertRequest request)
		{
			throw new Exception("Method not allowed");
		}

		public virtual Model.Competitions Update (int id,  CompetitionsUpdateRequest request)
		{
			throw new UserException("Method not allowed");
		}
		public virtual Model.Competitions Peparation(int id)
		{
			throw new UserException("Method not allowed");
		}
		public virtual Model.Competitions OpenAplications(int id)
		{
			throw new UserException("Method not allowed");
		}
		public virtual Model.Competitions CloseApplications(int id)
		{
			throw new UserException("Method not allowed");
		}
		public virtual Model.Competitions StartCompetition(int id)
		{
			throw new UserException("Method not allowed");
		}
		public virtual Model.Competitions FinishCompetition(int id)
		{
			throw new UserException("Method not allowed");
		}
		public virtual Model.Competitions Activate(int id)
		{
			throw new UserException("Method not allowed");
		}
		public virtual Model.Competitions Hide(int id)
		{
			throw new UserException("Method not allowed");
		}

		public BaseCompetitionState CreateState(Model.ENUMs.CompetitionStatus status)
		{
			switch (status)
			{
				case Model.ENUMs.CompetitionStatus.Initial:
					return ServiceProvider.GetService<InitialCompetitionState>();
				case Model.ENUMs.CompetitionStatus.Preparation:
					return ServiceProvider.GetService<PreparationCompetitionState>();
				case Model.ENUMs.CompetitionStatus.ApplicationsOpen:
					return ServiceProvider.GetService<ApplicationsOpenCompetitionState>();
				case Model.ENUMs.CompetitionStatus.ApplicationsClosed:
					return ServiceProvider.GetService<ApplicationsClosedCompetitionState>();
				case Model.ENUMs.CompetitionStatus.Underway:
					return ServiceProvider.GetService<UnderwayCompetitionState>();
				case Model.ENUMs.CompetitionStatus.Finished:
					return ServiceProvider.GetService<FinishedCompetitionState>();
				default: throw new Exception("State not recognized");
			}
		}
	}
}
