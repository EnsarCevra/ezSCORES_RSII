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
    public class PlayersService : BaseCRUDService<Players, PlayersSearchObject, Player,PlayerUpsertRequest, PlayerUpsertRequest>, IPlayersService
	{
		public PlayersService(EzScoresdbRsiiContext context, IMapper mapper) : base(context, mapper)
		{
		}

		public override IQueryable<Player> AddFilter(PlayersSearchObject search, IQueryable<Player> query)
		{
			base.AddFilter(search, query);
			if (!string.IsNullOrWhiteSpace(search?.FirstNameLastNameGTE))
			{
				query = query.Where(x => (x.FirstName + " " + x.LastName).StartsWith(search.FirstNameLastNameGTE)
					|| (x.LastName + " " + x.FirstName).StartsWith(search.FirstNameLastNameGTE));
			}
			if(search?.BirthDate == null && search?.Year != null)
			{
				query = query.Where(x => x.BirthDate.Date.Year == search.Year);
			}
			if (search?.BirthDate != null)
			{
				query = query.Where(x=>x.BirthDate.Date == search.BirthDate.Value.Date);
			}
			return base.AddFilter(search, query);
		}

		public override void BeforeInsert(PlayerUpsertRequest request, Player entity)
		{
			if (Context.Players.Where(x => request.FirstName == x.FirstName && request.LastName == x.LastName && request.BirthDate == x.BirthDate).Any())
			{
				throw new UserException("Igrač sa unesenim imenom, prezimenom  i datumom rođenja već postoji!");
			}
		}
	}
}
