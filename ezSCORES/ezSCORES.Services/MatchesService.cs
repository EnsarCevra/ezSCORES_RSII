using ezSCORES.Model;
using ezSCORES.Model.Requests;
using ezSCORES.Model.Requests.MatchRequests;
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
    public class MatchesService : BaseCRUDService<Matches, MatchSearchObject, Match, MatchInsertRequest, MatchUpdateRequest>, IMatchesService
	{
		public MatchesService(EzScoresdbRsiiContext context, IMapper mapper) : base(context, mapper)
		{
		}

		public override IQueryable<Match> AddFilter(MatchSearchObject search, IQueryable<Match> query)
		{
			base.AddFilter(search, query);
			if(search.FixtureId != null)
			{
				query = query.Where(x => x.FixtureId == search.FixtureId);
			}
			if(search.StadiumId != null)
			{
				query = query.Where(x=>x.StadiumId == search.StadiumId);
			}
			if(search.DateAndTime != null)
			{
				query = query.Where(x => x.DateAndTime.Date == search.DateAndTime.Value.Date);
			}
			return query;
		}

		protected override IQueryable<Match> ApplyIncludes(IQueryable<Match> query)
		{
			return query.Include(x => x.HomeTeam)
						.Include(x => x.AwayTeam)
						.Include(x => x.Stadium)
						.Include(x => x.Goals)
						.Include(x => x.CompetitionsRefereesMatches).ThenInclude(x => x.CompetitionsReferees).ThenInclude(x => x.Referee);
		}
	}
}
