using ezSCORES.Model;
using ezSCORES.Model.ENUMs;
using ezSCORES.Model.Requests.CompetitionRequests;
using ezSCORES.Model.SearchObjects;
using ezSCORES.Services.Auth;
using ezSCORES.Services.CompetitionStatusStateMachine;
using ezSCORES.Services.Database;
using MapsterMapper;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.CompilerServices;
using System.Text;
using System.Threading.Tasks;
using static Microsoft.EntityFrameworkCore.DbLoggerCategory;

namespace ezSCORES.Services
{
    public class CompetitionsService : BaseCRUDService<Competitions, CompetitionsSearchObject, Competition, CompetitionsInsertRequest, CompetitionsUpdateRequest>, ICompetitionsService
	{
		private readonly IActiveUserService _activeUserService;
		public BaseCompetitionState BaseCompetitionState { get; set; }
		public CompetitionsService(EzScoresdbRsiiContext context, IMapper mapper, BaseCompetitionState baseCompetitionState, IActiveUserService activeUserService) : base(context, mapper)
		{
			BaseCompetitionState = baseCompetitionState;
			_activeUserService = activeUserService;
		}
		public override Competitions Insert(CompetitionsInsertRequest request)
		{
			var state = BaseCompetitionState.CreateState(CompetitionStatus.Initial);
			return state.Insert(request);
		}
		public override Competitions Update(int id, CompetitionsUpdateRequest request)
		{
			var entity = GetById(id);
			var state = BaseCompetitionState.CreateState(entity.Status);
			return state.Update(id, request);
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
			if(search.IsSelectionIncluded)
			{
				query = query.Include(x => x.Selection);
			}
			if(search.IsCompetitionRefereesIncluded == true)
			{
				query = query.Include(x => x.CompetitionsReferees).ThenInclude(x=>x.Referee);
			}
			if(search.MatchDay  != null)
			{
				query = query.Include(x => x.Fixtures).ThenInclude(x => x.Matches.Where(x => x.DateAndTime.Date == search.MatchDay.Value.Date));
			}
			return base.AddFilter(search, query);
		}
		protected override Competition? ApplyIncludes(int id, DbSet<Competition> set)
		{
			return set.Where(x=>x.Id == id).Include(x => x.CompetitionsReferees)
						.ThenInclude(x => x.Referee)
						.Include(x => x.CompetitionsSponsors)
						.ThenInclude(x => x.Sponsor)
						.Include(x => x.Rewards)
						.Include(x => x.City)
						.Include(x => x.Selection).FirstOrDefault();
		}
		public override void BeforeInsert(CompetitionsInsertRequest request, Competition entity)
		{
			entity.UserId = _activeUserService.GetActiveUserId() ?? throw new InvalidOperationException("Authenticated user ID cannot be null.");
		}

		public override void BeforeUpdate(CompetitionsUpdateRequest request, Competition entity)
		{
			base.BeforeUpdate(request, entity);
			//can be updated when competition is in preparation mode
			if(entity.Status != Model.ENUMs.CompetitionStatus.Preparation)
			{
				throw new UserException("Izmjene možete vršiti samo u fazi pripreme takmičenja!");
			}
		}

		public Competitions? ToogleCompetitionStatus(int id, CompetitionStatus status)
		{
			var competition = Context.Competitions.Include(x=>x.Groups).FirstOrDefault(x=>x.Id == id);
			if(competition != null)
			{
				if(status == CompetitionStatus.ApplicationsClosed && competition.CompetitionType == CompetitionType.League)
				{
					if(competition.Groups.Count < 1)//if someone changes status multiple times we want to avoid creating new groups all the time
					{
						var group = new Group
						{
							CompetitionId = competition.Id,
							Name = competition.Name,
							CreatedAt = DateTime.Now
						};
						Context.Add(group);
						Context.SaveChanges();
						var competitionTeams = Context.CompetitionsTeams.Where(x => x.CompetitionId == competition.Id).ToList();
						foreach(var team in competitionTeams)
						{
							team.GroupId = group.Id;
						}
					}
					
				}
				competition.Status = status;
				Context.SaveChanges();
			}
			return Mapper.Map<Competitions>(competition);
		}
		public Competitions PreparationState(int id)
		{
			var competition = Context.Competitions.Find(id);
			var state = BaseCompetitionState.CreateState(competition.Status);
			return state.Peparation(id);
		}

		public Competitions OpenAplications(int id)
		{
			var competition = Context.Competitions.Find(id);
			var state = BaseCompetitionState.CreateState(competition.Status);
			return state.OpenAplications(id);
		}

		public Competitions CloseApplications(int id)
		{
			var competition = Context.Competitions.Find(id);
			var state = BaseCompetitionState.CreateState(competition.Status);
			return state.CloseApplications(id);
		}

		public Competitions StartCompetition(int id)
		{
			var competition = Context.Competitions.Find(id);
			var state = BaseCompetitionState.CreateState(competition.Status);
			return state.StartCompetition(id);
		}

		public Competitions FinishCompetition(int id)
		{
			var competition = Context.Competitions.Find(id);
			var state = BaseCompetitionState.CreateState(competition.Status);
			return state.FinishCompetition(id);
		}
	}
}
