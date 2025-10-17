using ezSCORES.Model;
using ezSCORES.Model.Requests;
using ezSCORES.Model.Requests.TeamsRequests;
using ezSCORES.Model.SearchObjects;
using ezSCORES.Services.Database;
using Mapster;
using MapsterMapper;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ezSCORES.Services
{
    public class SponsorsService : BaseCRUDService<Sponsors, BaseCompetitionSearchObject, Sponsor,SponsorUpsertRequest, SponsorUpsertRequest>, ISponsorsService
	{
		public SponsorsService(EzScoresdbRsiiContext context, IMapper mapper) : base(context, mapper)
		{
		}
		public override IQueryable<Sponsor> AddFilter(BaseCompetitionSearchObject search, IQueryable<Sponsor> query)
		{
			query = base.AddFilter(search, query);
			if (search.CompetitionId != null)
			{
				var existingSponsors = Context.CompetitionsSponsors.Where(x => x.CompetitionId == search.CompetitionId).Select(x => x.SponsorId).ToList();
				query = query.Where(x => !existingSponsors.Contains(x.Id));
			}
			return query;
		}
	}
}
