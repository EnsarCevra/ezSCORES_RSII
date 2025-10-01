using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ezSCORES.Services.Recommender
{
	public interface IRecommenderRetrainingService
	{
		public Task RetrainModelsAsync();
	}
}
