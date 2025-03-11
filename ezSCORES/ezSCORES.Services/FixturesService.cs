using ezSCORES.Model;
using ezSCORES.Model.Requests;
using ezSCORES.Model.Requests.FixtureRequests;
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
    public class FixturesService : BaseCRUDService<Fixtures, BaseCompetitionSearchObject, Fixture,FixtureInsertRequest, FixtureUpdateRequest>, IFixturesService
	{
		public FixturesService(EzScoresdbRsiiContext context, IMapper mapper) : base(context, mapper)
		{
		}

		public override IQueryable<Fixture> AddFilter(BaseCompetitionSearchObject search, IQueryable<Fixture> query)
		{
			if (search.CompetitionId != null)
			{
				query = query.Where(x => x.CompetitionId == search.CompetitionId)
					.Include(x => x.Matches)
					.OrderByDescending(x => x.GameStage)
					.ThenByDescending(x => x.SequenceNumber);
			}
			return query;

		}

		public override void BeforeInsert(FixtureInsertRequest request, Fixture entity)
		{
			base.BeforeInsert(request, entity);
			//can insert onlly when status applications closed and underway
			//can insert group game stage only if competition is with groups
		}

		protected override IQueryable<Fixture> ApplyIncludes(IQueryable<Fixture> query)
		{
			return query.Include(x => x.Matches);
		}
	}
}
