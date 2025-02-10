using ezSCORES.Model;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using ezSCORES.Model.Requests.CompetitionRequests;

namespace ezSCORES.Services
{
    public interface ICompetitionsService
	{
		Competitions Insert(CompetitionsInsertRequest request);
	}
}
