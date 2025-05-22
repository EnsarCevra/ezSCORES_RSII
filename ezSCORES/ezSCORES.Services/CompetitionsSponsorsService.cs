using ezSCORES.Model;
using ezSCORES.Model.Requests;
using ezSCORES.Model.Requests.CompetitionsRefereesRequests;
using ezSCORES.Model.Requests.CompetitionsSponsorsRequest;
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
    public class CompetitionsSponsorsService : BaseCRUDService<CompetitionsSponsors, BaseCompetitionSearchObject, CompetitionsSponsor,CompetitionSponsorInsertRequest, CompetitionSponsorUpdateRequest>, ICompetitionsSponsorsService
	{
		public CompetitionsSponsorsService(EzScoresdbRsiiContext context, IMapper mapper) : base(context, mapper)
		{
		}

		public override IQueryable<CompetitionsSponsor> AddFilter(BaseCompetitionSearchObject search, IQueryable<CompetitionsSponsor> query)
		{
			if (search.CompetitionId != null)
			{
				query = query.Where(x => x.CompetitionId == search.CompetitionId).Include(x => x.Sponsor);
			}
			return base.AddFilter(search, query);
		}
	}
}
