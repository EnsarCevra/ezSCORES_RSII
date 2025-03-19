using ezSCORES.Services.Database;
using MapsterMapper;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ezSCORES.Services.CompetitionStatusStateMachine
{
	public class FinishedCompetitionState : BaseCompetitionState
	{
		public FinishedCompetitionState(EzScoresdbRsiiContext context, IMapper mapper, IServiceProvider serviceProvider) : base(context, mapper, serviceProvider)
		{
		}
	}
}
