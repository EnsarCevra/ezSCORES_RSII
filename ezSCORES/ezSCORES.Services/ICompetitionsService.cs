using ezSCORES.Model;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using ezSCORES.Model.Requests.CompetitionRequests;
using ezSCORES.Model.SearchObjects;
using ezSCORES.Model.ENUMs;

namespace ezSCORES.Services
{
    public interface ICompetitionsService : ICRUDService<Competitions, CompetitionsSearchObject, CompetitionsInsertRequest, CompetitionsUpdateRequest>
	{
		Competitions? ToogleCompetitionStatus(int id, CompetitionStatus status);
		Competitions PreparationState(int id);
		Competitions OpenAplications(int id);
		Competitions CloseApplications(int id);
		Competitions StartCompetition(int id);
		Competitions FinishCompetition(int id);
	}
}
