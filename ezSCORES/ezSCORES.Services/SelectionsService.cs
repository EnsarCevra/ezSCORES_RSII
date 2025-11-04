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
    public class SelectionsService : BaseCRUDService<Selections, BaseSearchObject, Selection,SelectionUpsertRequest, SelectionUpsertRequest>, ISelectionsService
	{
		public SelectionsService(EzScoresdbRsiiContext context, IMapper mapper) : base(context, mapper)
		{
		}

		public override IQueryable<Selection> AddFilter(BaseSearchObject search, IQueryable<Selection> query)
		{
			query = query.OrderBy(s => s.Name == "Veterani" ? 0 : s.Name == "Seniori" ? 1 : 2)
				.ThenByDescending(s => s.AgeMax.HasValue ? s.AgeMax.Value : int.MaxValue);
			return query;
		}
		public override Selection? BeforeDelete(int id, DbSet<Selection> set)
		{
			var entity = base.BeforeDelete(id, set);
			if (entity == null)
				return null;

			bool isUsedInCompetition = Context.Competitions
				.Any(c => c.SelectionId == id);

			bool isUsedInTeam = Context.Teams
				.Any(t => t.SelectionId == id);

			if (isUsedInCompetition || isUsedInTeam)
				throw new UserException("Ne možete obrisati selekciju koja se već koristi u takmičenju ili ekipi.");
			return entity;
		}
	}
}
