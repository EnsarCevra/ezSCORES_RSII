using ezSCORES.Model;
using ezSCORES.Model.Requests;
using ezSCORES.Model.Requests.CompetitionsRefereesRequests;
using ezSCORES.Model.Requests.CompetitionsSponsorsRequest;
using ezSCORES.Model.Requests.FavoriteCompetitionRequests;
using ezSCORES.Model.Requests.TeamsRequests;
using ezSCORES.Model.SearchObjects;
using ezSCORES.Services.Auth;
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
    public class FavoriteCompetitionsService : BaseCRUDService<FavoriteCompetitions, BaseSearchObject, FavoriteCompetition,FavoriteCompetitionInsertRequest, FavoriteCompetitionUpdateRequest>, IFavoriteCompetitionsService
	{
		private readonly IActiveUserService _activeUserService;
		public FavoriteCompetitionsService(EzScoresdbRsiiContext context, IMapper mapper, IActiveUserService activeUserService) : base(context, mapper)
		{
			_activeUserService = activeUserService;
		}

		public override IQueryable<FavoriteCompetition> AddFilter(BaseSearchObject search, IQueryable<FavoriteCompetition> query)
		{
			query = query.Where(x => x.UserId == _activeUserService.GetActiveUserId());
			query = query.Include(x => x.Competition);
			if(search.Name != null)
			{
				query = query.Where(x => x.Competition.Name.ToLower().StartsWith(search.Name.ToLower()));
			}
			return base.AddFilter(search, query);
		}
	}
}
