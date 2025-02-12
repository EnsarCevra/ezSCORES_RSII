﻿using ezSCORES.Model;
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
	}
}
