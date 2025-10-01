using ezSCORES.Model;
using ezSCORES.Model.Constants;
using ezSCORES.Model.DTOs;
using ezSCORES.Model.ENUMs;
using ezSCORES.Model.Recommender;
using ezSCORES.Model.Requests.CompetitionRequests;
using ezSCORES.Model.SearchObjects;
using ezSCORES.Services.Auth;
using ezSCORES.Services.CompetitionStatusStateMachine;
using ezSCORES.Services.Database;
using ezSCORES.Services.Recommender;
using MapsterMapper;
using Microsoft.EntityFrameworkCore;

namespace ezSCORES.Services
{
    public class CompetitionsService : BaseCRUDService<Competitions, CompetitionsSearchObject, Competition, CompetitionsInsertRequest, CompetitionsUpdateRequest>, ICompetitionsService
	{
		private readonly IActiveUserService _activeUserService;
		private readonly IRecommenderService _recommenderService;
		public BaseCompetitionState BaseCompetitionState { get; set; }
		public CompetitionsService(EzScoresdbRsiiContext context, IMapper mapper, BaseCompetitionState baseCompetitionState, IActiveUserService activeUserService, IRecommenderService recommenderService) : base(context, mapper)
		{
			BaseCompetitionState = baseCompetitionState;
			_activeUserService = activeUserService;
			_recommenderService = recommenderService;
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
			//base.AddFilter(search, query);
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
			if (search.IsCityIncluded)
			{
				query = query.Include(x => x.City);
			}
			if (search.IsReviewsIncluded == true)
			{
				query = query.Include(x => x.Reviews);
			}
			if (search.IsCompetitionRefereesIncluded == true)
			{
				query = query.Include(x => x.CompetitionsReferees).ThenInclude(x=>x.Referee);
			}
			if(search.OnlyUserCompettions != null && search.OnlyUserCompettions == true)
			{
				query = query.Where(x => x.UserId == _activeUserService.GetActiveUserId());
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
						.Include(x => x.Reviews)
						.Include(x => x.City)
						.Include(x => x.Selection)
						.Include(x=>x.User).FirstOrDefault();
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
			return state.Preparation(id);
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

		public AdminDashboardDTO GetAdminDashboardInfo(AdminDashboardSearchObject searchObject)
		{
			var dto = new AdminDashboardDTO();
			if (_activeUserService.GetActiveUserRole() == Model.Constants.Roles.Admin)
			{
				dto.Competitions = Context.Competitions.Count();
				dto.Teams = Context.Teams.Count();
				dto.Players = Context.Players.Count();
				dto.TotalFeeAmount = Context.Applications.Where(x => x.IsPaId).Sum(x => x.PaIdAmount);
				dto.CompetitionsByStatus = new CompetitionsByStatusCountDTO
				{
					PreparationCount = Context.Competitions.Where(x => x.Status == CompetitionStatus.Preparation).Count(),
					ApplicationsOpenedCount = Context.Competitions.Where(x => x.Status == CompetitionStatus.ApplicationsOpen).Count(),
					ApplicationsClosedCount = Context.Competitions.Where(x => x.Status == CompetitionStatus.ApplicationsClosed).Count(),
					UnderwayCount = Context.Competitions.Where(x => x.Status == CompetitionStatus.Underway).Count(),
					FinishedCount = Context.Competitions.Where(x => x.Status == CompetitionStatus.Finished).Count(),
				};
				dto.CompetitionsByMonth = GetCompetitionsByMonth(searchObject.Year);
			}
			else
			{
				dto.Competitions = Context.Competitions.Where(x=>x.UserId == _activeUserService.GetActiveUserId()).Count();
				dto.TotalFeeAmount = Context.Applications.Where(x=>x.Competition.UserId == _activeUserService.GetActiveUserId() && x.IsPaId).Sum(x=>x.PaIdAmount);
				dto.CompetitionsByStatus = new CompetitionsByStatusCountDTO
				{
					PreparationCount = Context.Competitions.Where(x => x.Status == CompetitionStatus.Preparation && x.UserId == _activeUserService.GetActiveUserId()).Count(),
					ApplicationsOpenedCount = Context.Competitions.Where(x => x.Status == CompetitionStatus.ApplicationsOpen && x.UserId == _activeUserService.GetActiveUserId()).Count(),
					ApplicationsClosedCount = Context.Competitions.Where(x => x.Status == CompetitionStatus.ApplicationsClosed && x.UserId == _activeUserService.GetActiveUserId()).Count(),
					UnderwayCount = Context.Competitions.Where(x => x.Status == CompetitionStatus.Underway && x.UserId == _activeUserService.GetActiveUserId()).Count(),
					FinishedCount = Context.Competitions.Where(x => x.Status == CompetitionStatus.Finished && x.UserId == _activeUserService.GetActiveUserId()).Count(),
				};
				dto.CompetitionsByMonth = GetCompetitionsByMonth(searchObject.Year);
			}
			return dto;
		}

		private Dictionary<int, int> GetCompetitionsByMonth(int? selectedYear)
		{
			var rawData = new Dictionary<int, int>();
			if(_activeUserService.GetActiveUserRole() == Model.Constants.Roles.Admin)
			{
				rawData = Context.Competitions
					.Where(c => c.StartDate.Year == (selectedYear ?? DateTime.Now.Year))
					.GroupBy(c => c.StartDate.Month)
					.ToDictionary(g => g.Key, g => g.Count());
			}
			else
			{
				rawData = Context.Competitions
					.Where(c => c.StartDate.Year == (selectedYear ?? DateTime.Now.Year) && c.UserId == _activeUserService.GetActiveUserId())
					.GroupBy(c => c.StartDate.Month)
					.ToDictionary(g => g.Key, g => g.Count());
			}
			var fullYearData = Enumerable.Range(1, 12)
				.ToDictionary(month => month, month => rawData.ContainsKey(month) ? rawData[month] : 0);
			return fullYearData;
		}

		public RecommendedCompetitionSetup RecommendCompetitionSetup(int userId)
		{
			return _recommenderService.RecommendCompetitionSetup(userId);
		}
	}
}
