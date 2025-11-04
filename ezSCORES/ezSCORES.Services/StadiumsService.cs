using ezSCORES.Model;
using ezSCORES.Model.Requests;
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
    public class StadiumsService: BaseCRUDService<Stadiums, BaseSearchObject, Stadium,StadiumUpsertRequest, StadiumUpsertRequest>, IStadiumsService
	{
		public StadiumsService(EzScoresdbRsiiContext context, IMapper mapper) : base(context, mapper)
		{
		}
		public override Stadium? BeforeDelete(int id, DbSet<Stadium> set)
		{
			var entity = base.BeforeDelete(id, set);
			if (entity == null)
				return null;

			bool isUsedInCompetition = Context.Competitions
				.Any(c => c.SelectionId == id);

			if (isUsedInCompetition)
				throw new UserException("Ne možete obrisati stadion koja se već koristi u takmičenju.");
			return entity;
		}
	}
}
