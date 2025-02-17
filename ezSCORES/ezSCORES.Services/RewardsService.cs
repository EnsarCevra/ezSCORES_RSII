using ezSCORES.Model;
using ezSCORES.Model.Requests;
using ezSCORES.Model.Requests.RewardRequest;
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
    public class RewardsService : BaseCRUDService<Rewards, BaseSearchObject, Reward, RewardInsertRequest, RewardUpdateRequest>, IRewardsService
	{
		public RewardsService(EzScoresdbRsiiContext context, IMapper mapper) : base(context, mapper)
		{
		}
	}
}
