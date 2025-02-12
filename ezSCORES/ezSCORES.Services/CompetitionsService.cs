using ezSCORES.Model;
using ezSCORES.Model.Requests.CompetitionRequests;
using ezSCORES.Model.SearchObjects;
using ezSCORES.Services.Database;
using MapsterMapper;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.CompilerServices;
using System.Text;
using System.Threading.Tasks;

namespace ezSCORES.Services
{
    public class CompetitionsService : BaseCRUDService<Competitions, CompetitionsSearchObject, Competition, CompetitionsInsertRequest, CompetitionsUpdateRequest>, ICompetitionsService
	{
		public CompetitionsService(EzScoresdbRsiiContext context, IMapper mapper) : base(context, mapper)
		{
		}
	}
}
