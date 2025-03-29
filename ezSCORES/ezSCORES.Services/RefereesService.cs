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
    public class RefereesService : BaseCRUDService<Referees, RefereesSearchObject, Referee,RefereeUpsertRequest, RefereeUpsertRequest>, IRefereesService
	{
		public RefereesService(EzScoresdbRsiiContext context, IMapper mapper) : base(context, mapper)
		{
		}

		public override IQueryable<Referee> AddFilter(RefereesSearchObject search, IQueryable<Referee> query)
		{
			base.AddFilter(search, query);
			if (!string.IsNullOrWhiteSpace(search?.FirstNameLastNameGTE))
			{
				query = query.Where(x => (x.FirstName + " " + x.LastName).StartsWith(search.FirstNameLastNameGTE)
					|| (x.LastName + " " + x.FirstName).StartsWith(search.FirstNameLastNameGTE));
			}
			return base.AddFilter(search, query);
		}

		public override void BeforeInsert(RefereeUpsertRequest request, Referee entity)
		{
			if(Context.Referees.Where(x => request.FirstName == x.FirstName && request.LastName == x.LastName).Any())
			{
				throw new UserException("Sudac sa unesenim imenom i prezimenom već postoji!");
			}
		}
		public override void BeforeUpdate(RefereeUpsertRequest request, Referee entity)
		{
			if (Context.Referees.Where(x => request.FirstName == x.FirstName && request.LastName == x.LastName).Any())
			{
				throw new UserException("Sudac sa unesenim imenom i prezimenom već postoji!");
			}
		}
	}
}
