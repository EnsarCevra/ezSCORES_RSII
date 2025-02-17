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
			if(search.IsCompetitionRefereesIncluded == true)
			{
				query = query.Include(x => x.CompetitionsReferees).ThenInclude(x=>x.Referee);
			}
			return base.AddFilter(search, query);
			
		}
	}
}
