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

		public override IQueryable<CompetitionsRefereesMatch> AddFilter(BaseCompetitionSearchObject search, IQueryable<CompetitionsRefereesMatch> query)
		{
			if (search.CompetitionId != null)
			{
				query = query.Where(x => x.CompetitionsReferees.CompetitionId == search.CompetitionId).Include(x => x.CompetitionsReferees).ThenInclude(x=>x.Referee);
			}
			return base.AddFilter(search, query);
		}
		public override void BeforeInsert(CompetitionRefereeMatchUpsertRequest request, CompetitionsRefereesMatch entity)
		{
			if(Context.CompetitionsRefereesMatches.
				Where(x=>x.CompetitionsRefereesId == request.CompetitionsRefereesId &&
						x.MatchId == request.MatchId).Any())
			{
				throw new UserException("Sudac je već dodijeljen na takmičenje!");
			}
		}
	}
}
