using ezSCORES.Model.ENUMs;
using System;
using System.Collections.Generic;
using System.Text;

namespace ezSCORES.Model.Requests.CompetitionRequests
{
    public class CompetitionsUpdateRequest
	{

        public int SelectionId { get; set; }

        public string Season { get; set; } = null!;

        public int CityId { get; set; }

        public string Name { get; set; } = null!;

        public string Description { get; set; } = null!;

        public CompetitionType CompetitionType { get; set; }

        public int MaxTeamCount { get; set; }

        public byte[]? Picture { get; set; }

        public DateTime StartDate { get; set; }

        public DateTime ApplicationEndDate { get; set; }

        public int? Fee { get; set; }
        public int Status { get; set; }

        public int MaxPlayersPerTeam { get; set; }
    }
}
