﻿using ezSCORES.Model;
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
    public class TeamsService : BaseCRUDService<Teams, TeamsSearchObject, Team, TeamsInsertRequest, TeamsUpdateRequest>, ITeamsService
	{
		public TeamsService(EzScoresdbRsiiContext context, IMapper mapper) : base(context, mapper)
		{
		}
	}
}
