using ezSCORES.Model;
using ezSCORES.Model.Requests;
using ezSCORES.Model.Requests.ApplicationRequests;
using ezSCORES.Model.Requests.CompetitionRequests;
using ezSCORES.Model.Requests.TeamsRequests;
using ezSCORES.Model.SearchObjects;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ezSCORES.Services
{
    public interface IApplicationService : ICRUDService<Applications, ApplicationSearchObject, ApplicationInsertRequest, ApplicationUpdateRequest>
	{
		Applications? ToogleStatus(int id, ToogleStatusRequest status);
		void ValidateTeam(int teamId, int competitionId);
		void ValidatePlayers(List<int> playerIds, int competitionId);
		Applications MakePayment(int id, ApplicationMakePaymentRequest request);
	}
}
