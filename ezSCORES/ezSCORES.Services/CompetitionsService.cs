using ezSCORES.Model;
using ezSCORES.Model.Requests.CompetitionRequests;
using ezSCORES.Model.SearchObjects;
using ezSCORES.Services.Database;
using MapsterMapper;
using Microsoft.EntityFrameworkCore;
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

		public override IQueryable<Competition> AddFilter(CompetitionsSearchObject search, IQueryable<Competition> query)
		{
			base.AddFilter(search, query);
			if (search.SelectionId != null)
			{
				query = query.Where(x=>x.SelectionId == search.SelectionId);
			}
			if(!string.IsNullOrWhiteSpace(search.Season))
			{
				query = query.Where(x=>x.Season == search.Season);
			}
			if(search.StartDate != null)
			{
				query = query.Where(x => x.StartDate.Date == search.StartDate.Value.Date);
			}
			if (search.ApplicationEndDate != null)
			{
				query = query.Where(x => x.StartDate.Date == search.ApplicationEndDate.Value.Date);
			}
			if (search.CityId != null)
			{
				query = query.Where(x => x.CityId == search.CityId);
			}
			if (search.CompetitionType != null)
			{
				query = query.Where(x => x.CompetitionType == search.CompetitionType);
			}
			if(search.Status != null)
			{
				query = query.Where(x => x.Status == search.Status);
			}
			if(search.IsCompetitionRefereesIncluded == true)
			{
				query = query.Include(x => x.CompetitionsReferees).ThenInclude(x=>x.Referee);
			}
			if(search.MatchDay  != null)
			{
				query = query.Include(x => x.Fixtures).ThenInclude(x => x.Matches.Where(x => x.DateAndTime.Date == search.MatchDay.Value.Date));
			}
			return query;
		}
		protected override IQueryable<Competition> ApplyIncludes(IQueryable<Competition> query)
		{
			return query.Include(x => x.CompetitionsReferees)
						.ThenInclude(x => x.Referee)
						.Include(x => x.CompetitionsSponsors)
						.ThenInclude(x => x.Sponsor)
						.Include(x => x.Rewards)
						.Include(x => x.City)
						.Include(x => x.Selection);
		}
	}
}
