using Azure.Core;
using ezSCORES.Model;
using ezSCORES.Model.Requests;
using ezSCORES.Model.Requests.ApplicationRequests;
using ezSCORES.Model.Requests.CompetitionRequests;
using ezSCORES.Model.Requests.TeamsRequests;
using ezSCORES.Model.SearchObjects;
using ezSCORES.Services.Database;
using Mapster;
using MapsterMapper;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Query;
using Microsoft.IdentityModel.Tokens;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using static Microsoft.EntityFrameworkCore.DbLoggerCategory;
using static System.Net.Mime.MediaTypeNames;

namespace ezSCORES.Services
{
    public class ApplicationService : BaseCRUDService<Applications, ApplicationSearchObject, Database.Application,ApplicationInsertRequest, ApplicationUpdateRequest>, IApplicationService
	{
		public ApplicationService(EzScoresdbRsiiContext context, IMapper mapper) : base(context, mapper)
		{
		}

		public override IQueryable<Database.Application> AddFilter(ApplicationSearchObject search, IQueryable<Database.Application> query)
		{
			//filter by status?
			if(search.CompetitionId != null)
			{
				query = query.Where(x => x.CompetitionId == search.CompetitionId).Include(x => x.Team).ThenInclude(x => x.User);
			}
			return base.AddFilter(search, query);
		}
		protected override Database.Application? ApplyIncludes(int id, DbSet<Database.Application> set)
		{
			return set.Where(x=>x.Id == id).Include(x => x.Team)
							.ThenInclude(x => x.User)
							.Include(x => x.Team)
							.ThenInclude(x => x.CompetitionsTeams)
							.ThenInclude(x => x.CompetitionsTeamsPlayers)
							.ThenInclude(x => x.Player).FirstOrDefault();
		}
		public override void BeforeInsert(ApplicationInsertRequest request, Database.Application entity)
		{
			base.BeforeInsert(request, entity);
			//validation required
			var competition = Context.Competitions.Include(x=>x.Selection).FirstOrDefault(x=>x.Id == request.CompetitionId);
			var teamSelection = Context.Teams.Where(x => x.Id == request.TeamId).Select(x => x.Selection).FirstOrDefault();
			if (competition != null)
			{
				if (competition.Status != Model.ENUMs.CompetitionStatus.ApplicationsOpen)
				{
					// Competition exists and its status is NOT "ApplicationsOpen"
					throw new UserException("Ne možete se prijaviti na odabrano takmičenje jer prijave nisu otvorene!");
				}
				if (Context.CompetitionsTeams.Where(x => x.TeamId == request.TeamId && x.CompetitionId == competition.Id && !x.IsDeleted).Any())
				{
					throw new UserException("Ovaj tim je već prijavljen na takmičenje!");
				}
				if (Context.CompetitionsTeams.Where(x => x.CompetitionId == competition.Id).Count() > competition.MaxTeamCount)
				{
					throw new UserException("Kapacitet ekipa dostignut, prijavu nije moguće izvršiti!");
				}
				if(request.PlayerIds.Count > competition.MaxPlayersPerTeam)
				{
					throw new UserException($"Prijavu nije moguće izvršiti - maksimalan broj igrača po ekipi je {competition.MaxPlayersPerTeam}, a vi prijavljujete {request.PlayerIds.Count} igrača!");
				}
				if(teamSelection != null)
				{
					ValidateTeamSelection(competition.Selection, teamSelection);
					ValidatePlayersForCompetition(request.PlayerIds, competition.Id, teamSelection);
				}
			}

			CompetitionsTeam competitionTeamEntity = Mapper.Map<CompetitionsTeam>(request);
			if (competitionTeamEntity is ICreated created)
			{
				created.CreatedAt = DateTime.Now;
			}
			Context.Add(competitionTeamEntity);
			Context.SaveChanges();
			foreach (var playerId in request.PlayerIds)
			{
				var competitionTeamPlayer = new CompetitionsTeamsPlayer
				{
					CompetitionsTeamsId = competitionTeamEntity.Id,
					PlayerId = playerId,
					CreatedAt = DateTime.Now
				};
				Context.Add(competitionTeamPlayer);
			}
			Context.SaveChanges();
		}
		public override void AfterInsert(ApplicationInsertRequest request, Database.Application entity)
		{

		}

		public Applications? ToogleStatus(int id, ToogleStatusRequest request)
		{
			var application = Context.Applications.Find(id);
			if(application != null)
			{
				var competition = Context.Competitions.Find(application.CompetitionId);
				if(competition!.Status != Model.ENUMs.CompetitionStatus.ApplicationsOpen && competition!.Status != Model.ENUMs.CompetitionStatus.ApplicationsClosed)
				{
					throw new UserException("Status prijave možete mijenjati samo kada je status takmičenja prijave otvorene ili prijave zatvorene!");
				}
				application.IsAccepted = request.Status;
				//if status is false application is denied - you have to delete every related entity that has been already created - CompetitionTeams and CompetitionTeamsPlayers
				Context.SaveChanges();
				return Mapper.Map<Applications>(application);
			}
			else
			{
				return null;
			}
		}

		public override void BeforeUpdate(ApplicationUpdateRequest request, Database.Application entity)
		{
			if(entity.IsAccepted != null)
			{
				throw new UserException("Ne možete uređivati - prijava već obrađena");
			}
			//if (competition.Status != Model.ENUMs.CompetitionStatus.ApplicationsOpen)
			//{
			//	throw new UserException("");
			//}
			if (request.PlayerIds != null)
			{
				var competition = Context.Competitions.Find(entity.CompetitionId);
				var existingPlayerIds = Context.CompetitionsTeamsPlayers
					.Where(x => x.CompetitionsTeamsId == request.CompetitionTeamId)
					.Select(x => x.PlayerId)
					.ToList();
				var newPlayersToAdd = request.PlayerIds.Except(existingPlayerIds).ToList();
				var playersToRemove = Context.CompetitionsTeamsPlayers.Where(x => x.CompetitionsTeamsId == request.CompetitionTeamId
					&& !request.PlayerIds.Contains(x.PlayerId));
				ValidatePlayersForCompetition(newPlayersToAdd, competition.Id, competition.Selection);
				foreach ( var newPlayerId in newPlayersToAdd) 
				{
					var competitionTeamPlayer = new CompetitionsTeamsPlayer
					{
						CompetitionsTeamsId = request.CompetitionTeamId,
						PlayerId = newPlayerId,
						CreatedAt = DateTime.Now
					};
					Context.Add(competitionTeamPlayer);
				}
				Context.CompetitionsTeamsPlayers.RemoveRange(playersToRemove);
				Context.SaveChanges();
			}
			
		}

		private void ValidatePlayersForCompetition(List<int> playerIds, int competitionId, Selection teamSelection)
		{
			var existingPlayersOnCompetition = Context.CompetitionsTeamsPlayers
				.Where(x => playerIds.Contains(x.PlayerId) && x.CompetitionsTeams.CompetitionId == competitionId)
				.Select(x => x.PlayerId)
				.ToList();

			if (existingPlayersOnCompetition.Any())
			{
				if(existingPlayersOnCompetition.Count>1)
				{
					throw new UserException($"Sljedeći igrači su već registrirani na takmičenju: {string.Join(",", existingPlayersOnCompetition)}");
				}
				else
				{
					throw new UserException($"Igrači je već registrovan na takmičenje: {existingPlayersOnCompetition[0]}");
				}
			}

			var today = DateTime.Today;
			var ageRestrictedPlayers = Context.Players
				.Where(x => playerIds.Contains(x.Id))
				.ToList()
				.Where(player => {
					int age = today.Year - player.BirthDate.Year;
					if (player.BirthDate > today.AddYears(-age)) age--;

					if(teamSelection.AgeMax == null)
					{
						return teamSelection.Id == 10 ? age < 40 : false;
					}
					return age > teamSelection.AgeMax;
				})
				.Select(player => player.Id)
				.ToList();

			if (ageRestrictedPlayers.Any())
			{
				if(ageRestrictedPlayers.Count>1)
				{
					throw new UserException($"Sljedeći igrači ne mogu igrati na takmičenju zbog dobnih restrikcija: {string.Join(",", ageRestrictedPlayers)}");
				}
				else
				{
					throw new UserException($"Igrači ne može igrati na takmičenju zbog dobnih restrikcija: {ageRestrictedPlayers[0]}");
				}
			}
		}

		public void ValidateTeam(int teamId, int competitionId)
		{
			if (Context.CompetitionsTeams.Any(x => x.TeamId == teamId && x.CompetitionId == competitionId && !x.IsDeleted))
			{
				throw new UserException("Ovaj tim je već prijavljen na takmičenje!");
			}
			var data = Context.Competitions
								.Where(c => c.Id == competitionId)
								.Select(c => new
								{
									   CompetitionSelection = c.Selection,
									   TeamSelection = Context.Teams.Where(t => t.Id == teamId).Select(t => t.Selection).FirstOrDefault()
								})
								.FirstOrDefault();
			if(data == null || data.TeamSelection == null)
			{
				throw new UserException("Takmičenje ili tim ne postoje.");
			}
			ValidateTeamSelection(data.CompetitionSelection, data.TeamSelection);
		}
		private void ValidateTeamSelection(Selection competitionSelection, Selection teamSelection)
		{
			if (competitionSelection.AgeMax != null) // Age-restricted competition
			{
				if (teamSelection!.AgeMax == null || teamSelection.AgeMax > competitionSelection.AgeMax)
				{
					throw new UserException($"Ovo takmičenje je namijenjeno za selekciju {competitionSelection.Name}, a vaš tim je selekcija {teamSelection.Name}!");
				}
			}
			else // Senior or veteran futsal
			{
				if (competitionSelection!.Id == 10) // If it is veterans, only veteran teams are allowed
				{
					throw new UserException("Ovo takmičenje je namijenjeno samo za veteranske ekipe");
				}
			}
		}

		public void ValidatePlayers(List<int> playerIds, int competitionId)
		{
			var competitionSelection = Context.Competitions.Where(x => x.Id == competitionId).
				Select(x => x.Selection).FirstOrDefault();
			if(competitionSelection != null)
			{
				ValidatePlayersForCompetition(playerIds, competitionId, competitionSelection);
			}
			else
			{
				throw new UserException("Selekcija na odabranom takmičenju ne postoji ili nije unesena!");
			}
		}
	}
}
