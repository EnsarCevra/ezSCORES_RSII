using ezSCORES.Model;
using ezSCORES.Model.Requests;
using ezSCORES.Model.Requests.CompetitionTeamsRequests;
using ezSCORES.Model.Requests.TeamsRequests;
using ezSCORES.Model.SearchObjects;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ezSCORES.Services
{
    public interface ICompetitionTeamsService : ICRUDService<CompetitionsTeams, CompetitionTeamsSearchObject, CompetitionTeamInsertRequest, CompetitionTeamUpdateRequest>
	{
	}
}
