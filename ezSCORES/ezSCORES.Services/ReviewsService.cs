using ezSCORES.Model;
using ezSCORES.Model.Requests;
using ezSCORES.Model.Requests.ReviewRequests;
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
    public class ReviewsService : BaseCRUDService<Reviews, BaseSearchObject, Review,ReviewInsertRequest, ReviewUpdateRequest>, IReviewsService
	{
		public ReviewsService(EzScoresdbRsiiContext context, IMapper mapper) : base(context, mapper)
		{
		}

		public override void BeforeInsert(ReviewInsertRequest request, Review entity)
		{
			var competition = Context.Competitions.Find(request.CompetitionId);
			if(request.Rating < 1 || request.Rating > 5)
			{
				throw new UserException("Ocjena mora biti u rangu 1-5!");
			}
		}

		public override void BeforeUpdate(ReviewUpdateRequest request, Review entity)
		{
			if (request.Rating < 1 || request.Rating > 5)
			{
				throw new UserException("Ocjena mora biti u rangu 1-5!");
			}
		}
	}
}
