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
    public class RewardsService : BaseCRUDService<Rewards, BaseCompetitionSearchObject, Reward, RewardInsertRequest, RewardUpdateRequest>, IRewardsService
	{
		public RewardsService(EzScoresdbRsiiContext context, IMapper mapper) : base(context, mapper)
		{
		}

		public override void BeforeInsert(RewardInsertRequest request, Reward entity)
		{
			if (Context.Rewards.Where(x => x.RankingPosition == request.RankingPosition && x.CompetitionId == request.CompetitionId).Any())
			{
				throw new UserException("Nagrada za ovo mjesto već postoji!");
			}
			entity.Name = GetRewardNameByPosition(request.RankingPosition);
		}

		public override void BeforeUpdate(RewardUpdateRequest request, Reward entity)
		{
			if (Context.Rewards.Where(x => x.Id != entity.Id && x.RankingPosition == request.RankingPosition && x.CompetitionId == entity.CompetitionId).Any())
			{
				throw new UserException("Nagrada za ovo mjesto već postoji!");
			}
			entity.Name = GetRewardNameByPosition(request.RankingPosition);
		}
		public override IQueryable<Reward> AddFilter(BaseCompetitionSearchObject search, IQueryable<Reward> query)
		{
			if(search.CompetitionId != null)
			{
				query = query.Where(x=>x.CompetitionId ==  search.CompetitionId);
			}
			return base.AddFilter(search, query);
		}
		private static string GetRewardNameByPosition(int position)
		{
			return position switch
			{
				1 => "Prvo mjesto",
				2 => "Drugo mjesto",
				3 => "Treće mjesto",
				4 => "Četvrto mjesto",
				_ => $"{position}. mjesto"
			};
		}
	}
}
