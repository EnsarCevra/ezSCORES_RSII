using ezSCORES.Model;
using ezSCORES.Model.Requests;
using ezSCORES.Model.Requests.CompetitionsRefereesRequests;
using ezSCORES.Model.Requests.TeamsRequests;
using ezSCORES.Model.SearchObjects;
using ezSCORES.Services.Database;
using Mapster;
using MapsterMapper;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ezSCORES.Services
{
    public class CompetitionsRefereesMatchService : BaseCRUDService<CompetitionsRefereesMatches, BaseCompetitionSearchObject, CompetitionsRefereesMatch,CompetitionRefereeMatchUpsertRequest, CompetitionRefereeMatchUpsertRequest>, ICompetitionsRefereesMatchService
	{
		public CompetitionsRefereesMatchService(EzScoresdbRsiiContext context, IMapper mapper) : base(context, mapper)
		{
		}
	}
}
