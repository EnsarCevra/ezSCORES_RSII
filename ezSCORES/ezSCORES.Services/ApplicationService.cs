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
			return query;
		}
		protected override IQueryable<Database.Application> ApplyIncludes(IQueryable<Database.Application> query)
		{
			return query.Include(x => x.Team)
							.ThenInclude(x => x.User)
							.Include(x => x.Team)
							.ThenInclude(x => x.CompetitionsTeams)
							.ThenInclude(x => x.CompetitionsTeamsPlayers)
							.ThenInclude(x=>x.Player);
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
				if (competition.Selection.AgeMax != null)//when selection is not null it is age restricted competition
				{
					if (teamSelection!.AgeMax == null || (teamSelection!.AgeMax > competition.Selection.AgeMax))//if team is senior team or exceedes year gap 
					{
						throw new UserException($"Ovo takmičenje je namijenjeno za selekciju {competition.Selection.Name}, a vaš tim je  selekcija {teamSelection.Name}!");
					}
				}
				else //in this case it is senior or veteran futsal
				{
					if(teamSelection!.Id != 10)//if it is veterans only veteran teams are allowed
					{
						throw new UserException($"Ovo takmičenje je namijenjeno samo za veteranske ekipe");
					}
				}
				//if selection is null it is senior futsal meaning all can apply 
				
			}
			ValidatePlayersForCompetition(request.PlayerIds, competition.Id, teamSelection);
			//var existingPlayersOnCompetition = Context.CompetitionsTeamsPlayers
			//	.Where(x => request.PlayerIds.Contains(x.PlayerId) && x.CompetitionsTeams.CompetitionId == request.CompetitionId)
			//	.Select(x => x.PlayerId)
			//	.ToList();
			//if (!existingPlayersOnCompetition.IsNullOrEmpty())
			//{
			//	throw new UserException($"Sljedeći igrači su već registrirani na takmičenju: {string.Join(",", existingPlayersOnCompetition)}");
			//}

			//var today = DateTime.Today;
			//var ageRestrictedPlayers = Context.Players
			//		.Where(x => request.PlayerIds.Contains(x.Id))
			//		.ToList()
			//		.Where(player => {
			//			int age = today.Year - player.BirthDate.Year;
			//			if (player.BirthDate > today.AddYears(-age)) age--;

			//			return teamSelection.AgeMax == null ? age < 40 : age > teamSelection.AgeMax;
			//		})
			//		.Select(player=> player.Id).ToList();
			//if(ageRestrictedPlayers != null)
			//{
			//	throw new UserException($"Sljedeći igrači ne mogu igrati na takmičenju zbog dobnih restrikcija: {string.Join(",", ageRestrictedPlayers)}");
			//}

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
				throw new UserException($"Sljedeći igrači su već registrirani na takmičenju: {string.Join(",", existingPlayersOnCompetition)}");
			}

			var today = DateTime.Today;
			var ageRestrictedPlayers = Context.Players
				.Where(x => playerIds.Contains(x.Id))
				.ToList()
				.Where(player => {
					int age = today.Year - player.BirthDate.Year;
					if (player.BirthDate > today.AddYears(-age)) age--;

					return teamSelection.AgeMax == null ? age < 40 : age > teamSelection.AgeMax;
				})
				.Select(player => player.Id)
				.ToList();

			if (ageRestrictedPlayers.Any())
			{
				throw new UserException($"Sljedeći igrači ne mogu igrati na takmičenju zbog dobnih restrikcija: {string.Join(",", ageRestrictedPlayers)}");
			}
		}

	}
}
