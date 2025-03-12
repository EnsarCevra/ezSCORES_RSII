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
using System.Linq.Dynamic.Core;
using System.Text;
using System.Threading.Tasks;

namespace ezSCORES.Services
{
    public class FixturesService : BaseCRUDService<Fixtures, BaseCompetitionSearchObject, Fixture,FixtureInsertRequest, FixtureUpdateRequest>, IFixturesService
	{
		public FixturesService(EzScoresdbRsiiContext context, IMapper mapper) : base(context, mapper)
		{
		}

		public void ActivateFixture(int fixtureId)
		{
			var fixture = Context.Fixtures.Find(fixtureId);
			if (fixture == null)
			{
				throw new UserException("Odabrano kolo ne postoji!");//maybe I dont need this since middleware check wether entity exists
			}
			var activeFixture = Context.Fixtures.FirstOrDefault(x => x.CompetitionId == fixture.CompetitionId && x.IsActive);
			if(activeFixture != null)
			{
				throw new UserException($"Već je aktivno drugo kolo: {activeFixture.Id}");
			}
			else
			{
				if(fixture.Id == fixtureId)
				{
					throw new UserException($"Ovo kolo je već aktivno!");
				}
			}
			fixture.IsActive = true;
			Context.SaveChanges();
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
			//after validation get highest squence number to increment it for current one
			int previousMaxSequenceNumber = Context.Fixtures.Where(x => x.CompetitionId == entity.CompetitionId)
				.OrderByDescending(x => x.SequenceNumber)
				.Select(x => x.SequenceNumber)
				.FirstOrDefault();
			//this will work if no deletion of fixtures is quarantied and if its all same game stage
			entity.SequenceNumber = previousMaxSequenceNumber + 1;
		}

		public void FinishFixture(int fixtureId)
		{
			var fixture = Context.Fixtures.Find(fixtureId);
			if(fixture == null)
			{
				throw new UserException("Odabrano kolo ne postoji!");
			}
			var unfinishedMatchesIds = Context.Matches.Where(x => x.FixtureId == fixture.Id && !x.IsCompleted).Select(x=>x.Id);
			if(unfinishedMatchesIds.Any())
			{
				throw new UserException($"Nezavršeni susreti: {string.Join(",", unfinishedMatchesIds)}");
			}
			fixture.IsActive = false;
			fixture.IsCompleted = true;
			Context.SaveChanges();
		}

		protected override IQueryable<Fixture> ApplyIncludes(IQueryable<Fixture> query)
		{
			return query.Include(x => x.Matches);
		}
	}
}
