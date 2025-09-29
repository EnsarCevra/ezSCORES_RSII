using ezSCORES.Model.Recommender;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ezSCORES.Services.Recommender
{
	public interface IRecommenderService
	{
		RecommendedCompetitionSetup RecommendCompetitionSetup(int userId);
	}
}
