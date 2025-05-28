using ezSCORES.Model;
using ezSCORES.Model.DTOs;
using ezSCORES.Model.Requests;
using ezSCORES.Model.Requests.ApplicationRequests;
using ezSCORES.Model.Requests.FixtureRequests;
using ezSCORES.Model.Requests.TeamsRequests;
using ezSCORES.Model.SearchObjects;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ezSCORES.Services
{
    public interface IFixturesService : ICRUDService<Fixtures, BaseCompetitionSearchObject, FixtureInsertRequest, FixtureUpdateRequest>
	{
		void ToogleFixtureStatus(int fixtureId, ToogleStatusRequest request);
		void FinishFixture(int fixtureId);
		List<FixtureDTO> GetFixturesByCompetition(GetFixturesByCompetitionRequest request);
	}
}
