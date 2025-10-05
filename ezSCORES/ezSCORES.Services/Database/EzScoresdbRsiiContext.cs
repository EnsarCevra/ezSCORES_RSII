using System;
using System.Collections.Generic;
using System.Runtime.CompilerServices;
using ezSCORES.Model.ENUMs;
using Microsoft.EntityFrameworkCore;

namespace ezSCORES.Services.Database;

public partial class EzScoresdbRsiiContext : DbContext
{
    public EzScoresdbRsiiContext()
    {
    }

    public EzScoresdbRsiiContext(DbContextOptions<EzScoresdbRsiiContext> options)
        : base(options)
    {
    }

    public virtual DbSet<Application> Applications { get; set; }

    public virtual DbSet<City> Cities { get; set; }

    public virtual DbSet<Competition> Competitions { get; set; }

    public virtual DbSet<CompetitionsReferee> CompetitionsReferees { get; set; }

    public virtual DbSet<CompetitionsRefereesMatch> CompetitionsRefereesMatches { get; set; }

    public virtual DbSet<CompetitionsSponsor> CompetitionsSponsors { get; set; }

    public virtual DbSet<CompetitionsTeam> CompetitionsTeams { get; set; }

    public virtual DbSet<CompetitionsTeamsPlayer> CompetitionsTeamsPlayers { get; set; }

    public virtual DbSet<FavoriteCompetition> FavoriteCompetitions { get; set; }

    public virtual DbSet<Fixture> Fixtures { get; set; }

    public virtual DbSet<Goal> Goals { get; set; }

    public virtual DbSet<Group> Groups { get; set; }

    public virtual DbSet<Match> Matches { get; set; }

    public virtual DbSet<Player> Players { get; set; }

    public virtual DbSet<Referee> Referees { get; set; }

    public virtual DbSet<Review> Reviews { get; set; }

    public virtual DbSet<Reward> Rewards { get; set; }

    public virtual DbSet<Role> Roles { get; set; }

    public virtual DbSet<Selection> Selections { get; set; }

    public virtual DbSet<Sponsor> Sponsors { get; set; }

    public virtual DbSet<Stadium> Stadiums { get; set; }

    public virtual DbSet<Team> Teams { get; set; }

    public virtual DbSet<User> Users { get; set; }

    protected override void OnModelCreating(ModelBuilder modelBuilder)
    {
        modelBuilder.Entity<Application>(entity =>
        {
            entity.HasKey(e => e.Id).HasName("PK__Applicat__3214EC0724EF6103");

            entity.ToTable("Application");

            entity.HasIndex(e => e.Id, "Application_Id");

            entity.Property(e => e.Message)
                .HasMaxLength(255)
                .IsUnicode(true);

            entity.HasOne(d => d.Competition).WithMany(p => p.Applications)
                .HasForeignKey(d => d.CompetitionId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FKApplicatio868810");

            entity.HasOne(d => d.Team).WithMany(p => p.Applications)
                .HasForeignKey(d => d.TeamId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FKApplicatio882038");
        });

        modelBuilder.Entity<City>(entity =>
        {
            entity.HasKey(e => e.Id).HasName("PK__City__3214EC071DEF76E6");

            entity.ToTable("City");

            entity.HasIndex(e => e.Id, "City_Id");

            entity.Property(e => e.Name)
                .HasMaxLength(50)
                .IsUnicode(true);
        });

        modelBuilder.Entity<Competition>(entity =>
        {
            entity.HasKey(e => e.Id).HasName("PK__Competit__3214EC07AB2663C6");

            entity.ToTable("Competition");

            entity.HasIndex(e => e.Id, "Competition_Id");

            entity.Property(e => e.Description)
                .HasMaxLength(255)
                .IsUnicode(true);
            entity.Property(e => e.Name)
                .HasMaxLength(50)
                .IsUnicode(true);
            entity.Property(e => e.Season)
                .HasMaxLength(30)
                .IsUnicode(true);

            entity.HasOne(d => d.City).WithMany(p => p.Competitions)
                .HasForeignKey(d => d.CityId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FKCompetitio697082");

            entity.HasOne(d => d.Selection).WithMany(p => p.Competitions)
                .HasForeignKey(d => d.SelectionId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FKCompetitio79001");

            entity.HasOne(d => d.User).WithMany(p => p.Competitions)
                .HasForeignKey(d => d.UserId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FKCompetitio44846");
        });

        modelBuilder.Entity<CompetitionsReferee>(entity =>
        {
            entity.HasKey(e => e.Id).HasName("PK__Competit__3214EC07E77F3110");

            entity.HasIndex(e => e.Id, "CompetitionsReferees_Id");

            entity.HasOne(d => d.Competition).WithMany(p => p.CompetitionsReferees)
                .HasForeignKey(d => d.CompetitionId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FKCompetitio239972");

            entity.HasOne(d => d.Referee).WithMany(p => p.CompetitionsReferees)
                .HasForeignKey(d => d.RefereeId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FKCompetitio314320");
        });

        modelBuilder.Entity<CompetitionsRefereesMatch>(entity =>
        {
            entity.HasKey(e => e.Id).HasName("PK__Competit__3214EC07BDBF23B5");

            entity.ToTable("CompetitionsRefereesMatch");

            entity.HasOne(d => d.CompetitionsReferees).WithMany(p => p.CompetitionsRefereesMatches)
                .HasForeignKey(d => d.CompetitionsRefereesId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FKCompetitio933480");

            entity.HasOne(d => d.Match).WithMany(p => p.CompetitionsRefereesMatches)
                .HasForeignKey(d => d.MatchId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FKCompetitio997653");
        });

        modelBuilder.Entity<CompetitionsSponsor>(entity =>
        {
            entity.HasKey(e => e.Id).HasName("PK__Competit__3214EC0729DE339E");

            entity.HasIndex(e => e.Id, "CompetitionsSponsors_Id");

            entity.HasOne(d => d.Competition).WithMany(p => p.CompetitionsSponsors)
                .HasForeignKey(d => d.CompetitionId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FKCompetitio193295");

            entity.HasOne(d => d.Sponsor).WithMany(p => p.CompetitionsSponsors)
                .HasForeignKey(d => d.SponsorId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FKCompetitio368850");
        });

        modelBuilder.Entity<CompetitionsTeam>(entity =>
        {
            entity.HasKey(e => e.Id).HasName("PK__Competit__3214EC0785B5A9B9");

            entity.HasIndex(e => e.Id, "CompetitionsTeams_Id");

            entity.HasOne(d => d.Competition).WithMany(p => p.CompetitionsTeams)
                .HasForeignKey(d => d.CompetitionId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FKCompetitio723071");

            entity.HasOne(d => d.Group).WithMany(p => p.CompetitionsTeams)
                .HasForeignKey(d => d.GroupId)
                .HasConstraintName("FKCompetitio461609");

            entity.HasOne(d => d.Team).WithMany(p => p.CompetitionsTeams)
                .HasForeignKey(d => d.TeamId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FKCompetitio27778");
        });

        modelBuilder.Entity<CompetitionsTeamsPlayer>(entity =>
        {
            entity.HasKey(e => e.Id).HasName("PK__Competit__3214EC07D9313C4C");

            entity.HasIndex(e => e.Id, "CompetitionsTeamsPlayers_Id");

            entity.HasOne(d => d.CompetitionsTeams).WithMany(p => p.CompetitionsTeamsPlayers)
                .HasForeignKey(d => d.CompetitionsTeamsId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FKCompetitio399896");

            entity.HasOne(d => d.Player).WithMany(p => p.CompetitionsTeamsPlayers)
                .HasForeignKey(d => d.PlayerId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FKCompetitio720212");
        });

        modelBuilder.Entity<FavoriteCompetition>(entity =>
        {
            entity.HasKey(e => e.Id).HasName("PK__Favorite__3214EC070C68C883");

            entity.HasIndex(e => e.Id, "FavoriteCompetitions_Id");

            entity.HasOne(d => d.Competition).WithMany(p => p.FavoriteCompetitions)
                .HasForeignKey(d => d.CompetitionId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FKFavoriteCo848933");

            entity.HasOne(d => d.User).WithMany(p => p.FavoriteCompetitions)
                .HasForeignKey(d => d.UserId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FKFavoriteCo627745");
        });

        modelBuilder.Entity<Fixture>(entity =>
        {
            entity.HasKey(e => e.Id).HasName("PK__Fixture__3214EC07DDA6DF62");

            entity.ToTable("Fixture");

            entity.HasIndex(e => e.Id, "Fixture_Id");

            entity.HasOne(d => d.Competition).WithMany(p => p.Fixtures)
                .HasForeignKey(d => d.CompetitionId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FKFixture182036");
        });

        modelBuilder.Entity<Goal>(entity =>
        {
            entity.HasKey(e => e.Id).HasName("PK__Goal__3214EC077EAB4DD5");

            entity.ToTable("Goal");

            entity.HasIndex(e => e.Id, "Goal_Id");

            entity.HasOne(d => d.CompetitionTeamPlayer).WithMany(p => p.Goals)
                .HasForeignKey(d => d.CompetitionTeamPlayerId)
                .HasConstraintName("FKGoal189887");

            entity.HasOne(d => d.Match).WithMany(p => p.Goals)
                .HasForeignKey(d => d.MatchId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FKGoal111806");
        });

        modelBuilder.Entity<Group>(entity =>
        {
            entity.HasKey(e => e.Id).HasName("PK__Group__3214EC077C17C5A0");

            entity.ToTable("Group");

            entity.HasIndex(e => e.Id, "Group_Id");

            entity.Property(e => e.Name)
                .HasMaxLength(50)
                .IsUnicode(true);

            entity.HasOne(d => d.Competition).WithMany(p => p.Groups)
                .HasForeignKey(d => d.CompetitionId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FKGroup54426");
        });

        modelBuilder.Entity<Match>(entity =>
        {
            entity.HasKey(e => e.Id).HasName("PK__Match__3214EC071F8B3D0F");

            entity.ToTable("Match");

            entity.HasIndex(e => e.Id, "Match_Id");

            entity.HasOne(d => d.AwayTeam).WithMany(p => p.MatchAwayTeams)
                .HasForeignKey(d => d.AwayTeamId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FKMatch980815");

            entity.HasOne(d => d.Fixture).WithMany(p => p.Matches)
                .HasForeignKey(d => d.FixtureId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FKMatch159901");

            entity.HasOne(d => d.HomeTeam).WithMany(p => p.MatchHomeTeams)
                .HasForeignKey(d => d.HomeTeamId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FKMatch812227");

            entity.HasOne(d => d.Stadium).WithMany(p => p.Matches)
                .HasForeignKey(d => d.StadiumId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FKMatch149665");

            entity.HasOne(d => d.Winner).WithMany(p => p.MatchWinners)
                .HasForeignKey(d => d.WinnerId)
                .HasConstraintName("FKMatch584835");
        });

        modelBuilder.Entity<Player>(entity =>
        {
            entity.HasKey(e => e.Id).HasName("PK__Player__3214EC07005A96A9");

            entity.ToTable("Player");

            entity.HasIndex(e => e.Id, "Player_Id");

            entity.Property(e => e.FirstName)
                .HasMaxLength(50)
                .IsUnicode(true);
            entity.Property(e => e.LastName)
                .HasMaxLength(50)
                .IsUnicode(true);
        });

        modelBuilder.Entity<Referee>(entity =>
        {
            entity.HasKey(e => e.Id).HasName("PK__Referee__3214EC07FBECF17D");

            entity.ToTable("Referee");

            entity.HasIndex(e => e.Id, "Referee_Id");

            entity.Property(e => e.FirstName)
                .HasMaxLength(50)
                .IsUnicode(true);
            entity.Property(e => e.LastName)
                .HasMaxLength(50)
                .IsUnicode(true);
        });

        modelBuilder.Entity<Review>(entity =>
        {
            entity.HasKey(e => e.Id).HasName("PK__Review__3214EC07E1FC36A9");

            entity.ToTable("Review");

            entity.HasIndex(e => e.Id, "Review_Id");

            entity.HasOne(d => d.Competition).WithMany(p => p.Reviews)
                .HasForeignKey(d => d.CompetitionId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FKReview505868");

            entity.HasOne(d => d.User).WithMany(p => p.Reviews)
                .HasForeignKey(d => d.UserId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FKReview970810");
        });

        modelBuilder.Entity<Reward>(entity =>
        {
            entity.HasKey(e => e.Id).HasName("PK__Reward__3214EC07BCCEE2C9");

            entity.ToTable("Reward");

            entity.HasIndex(e => e.Id, "Reward_Id");

            entity.Property(e => e.Description)
                .HasMaxLength(255)
                .IsUnicode(true);
            entity.Property(e => e.Name)
                .HasMaxLength(100)
                .IsUnicode(true);

            entity.HasOne(d => d.Competition).WithMany(p => p.Rewards)
                .HasForeignKey(d => d.CompetitionId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FKReward483381");
        });

        modelBuilder.Entity<Role>(entity =>
        {
            entity.HasKey(e => e.Id).HasName("PK__Role__3214EC07CD5B98F8");

            entity.ToTable("Role");

            entity.HasIndex(e => e.Id, "Role_Id");

            entity.Property(e => e.Description)
                .HasMaxLength(255)
                .IsUnicode(true);
            entity.Property(e => e.Name)
                .HasMaxLength(50)
                .IsUnicode(true);
        });

        modelBuilder.Entity<Selection>(entity =>
        {
            entity.HasKey(e => e.Id).HasName("PK__Selectio__3214EC07556A3345");

            entity.ToTable("Selection");

            entity.HasIndex(e => e.Id, "Selection_Id");

            entity.Property(e => e.Name)
                .HasMaxLength(50)
                .IsUnicode(true);
        });

        modelBuilder.Entity<Sponsor>(entity =>
        {
            entity.HasKey(e => e.Id).HasName("PK__Sponsors__3214EC0758CE2867");

            entity.HasIndex(e => e.Id, "Sponsors_Id");

            entity.Property(e => e.Name)
                .HasMaxLength(255)
                .IsUnicode(true);
        });

        modelBuilder.Entity<Stadium>(entity =>
        {
            entity.HasKey(e => e.Id).HasName("PK__Stadium__3214EC07FBE7F165");

            entity.ToTable("Stadium");

            entity.HasIndex(e => e.Id, "Stadium_Id");

            entity.Property(e => e.Name)
                .HasMaxLength(50)
                .IsUnicode(true);
        });

        modelBuilder.Entity<Team>(entity =>
        {
            entity.HasKey(e => e.Id).HasName("PK__Team__3214EC0789ED9810");

            entity.ToTable("Team");

            entity.HasIndex(e => e.Id, "Team_Id");

            entity.Property(e => e.Name)
                .HasMaxLength(50)
                .IsUnicode(true);

            entity.HasOne(d => d.Selection).WithMany(p => p.Teams)
                .HasForeignKey(d => d.SelectionId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FKTeam948660");

            entity.HasOne(d => d.User).WithMany(p => p.Teams)
                .HasForeignKey(d => d.UserId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FKTeam914505");
        });

        modelBuilder.Entity<User>(entity =>
        {
            entity.HasKey(e => e.Id).HasName("PK__User__3214EC079B2B3FAA");

            entity.ToTable("User");

            entity.HasIndex(e => e.Id, "User_Id");

            entity.Property(e => e.Email)
                .HasMaxLength(255)
                .IsUnicode(false);
            entity.Property(e => e.FirstName)
                .HasMaxLength(100)
                .IsUnicode(true);
            entity.Property(e => e.LastName)
                .HasMaxLength(100)
                .IsUnicode(true);
            entity.Property(e => e.Organization)
                .HasMaxLength(100)
                .IsUnicode(true);
            entity.Property(e => e.PasswordHash)
                .HasMaxLength(100)
                .IsUnicode(false);
            entity.Property(e => e.PasswordSalt)
                .HasMaxLength(100)
                .IsUnicode(false);
            entity.Property(e => e.UserName)
                .HasMaxLength(50)
                .IsUnicode(true);

            entity.HasOne(d => d.Role).WithMany(p => p.Users)
                .HasForeignKey(d => d.RoleId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FKUser349727");
            try
            {
                Console.WriteLine("Data seed started.");
				modelBuilder.Seed();
			}
			catch (Exception err)
            {

                Console.WriteLine(err.ToString());
            }
            OnModelCreatingPartial(modelBuilder);
        });
        modelBuilder.Entity<Application>().HasQueryFilter(m => !m.IsDeleted);
        modelBuilder.Entity<City>().HasQueryFilter(g => !g.IsDeleted);
        modelBuilder.Entity<Competition>().HasQueryFilter(g => !g.IsDeleted);
        modelBuilder.Entity<CompetitionsReferee>().HasQueryFilter(ct => !ct.IsDeleted);
        modelBuilder.Entity<CompetitionsRefereesMatch>().HasQueryFilter(m => !m.IsDeleted);
        modelBuilder.Entity<CompetitionsSponsor>().HasQueryFilter(g => !g.IsDeleted);
        modelBuilder.Entity<CompetitionsTeam>().HasQueryFilter(g => !g.IsDeleted);
        modelBuilder.Entity<CompetitionsTeamsPlayer>().HasQueryFilter(ct => !ct.IsDeleted);
        modelBuilder.Entity<FavoriteCompetition>().HasQueryFilter(m => !m.IsDeleted);
        modelBuilder.Entity<Fixture>().HasQueryFilter(g => !g.IsDeleted);
        modelBuilder.Entity<Goal>().HasQueryFilter(g => !g.IsDeleted);
        modelBuilder.Entity<Group>().HasQueryFilter(ct => !ct.IsDeleted);
        modelBuilder.Entity<Match>().HasQueryFilter(m => !m.IsDeleted);
        modelBuilder.Entity<Player>().HasQueryFilter(g => !g.IsDeleted);
        modelBuilder.Entity<Referee>().HasQueryFilter(g => !g.IsDeleted);
        modelBuilder.Entity<Review>().HasQueryFilter(ct => !ct.IsDeleted);
        modelBuilder.Entity<Reward>().HasQueryFilter(ct => !ct.IsDeleted);
		modelBuilder.Entity<Role>().HasQueryFilter(m => !m.IsDeleted);
        modelBuilder.Entity<Selection>().HasQueryFilter(g => !g.IsDeleted);
        modelBuilder.Entity<Sponsor>().HasQueryFilter(g => !g.IsDeleted);
        modelBuilder.Entity<Stadium>().HasQueryFilter(ct => !ct.IsDeleted);
        modelBuilder.Entity<Team>().HasQueryFilter(m => !m.IsDeleted);
        modelBuilder.Entity<User>().HasQueryFilter(g => !g.IsDeleted);
        OnModelCreatingPartial(modelBuilder);
    }

    partial void OnModelCreatingPartial(ModelBuilder modelBuilder);
}
public static class ModelBuilderExtensions
{
	public static void Seed(this ModelBuilder modelBuilder)
	{
        modelBuilder.Entity<Database.Application>().HasData(
			new Application() { Id = 1, CompetitionId = 1, TeamId = 1, Message = "Prijava tima", IsAccepted = true, IsPaId = true, PaIdAmount = 100, IsDeleted = false, RemovedAt = null, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00") },
			new Application() { Id = 2, CompetitionId = 1, TeamId = 2, Message = "Prijava tima", IsAccepted = true, IsPaId = true, PaIdAmount = 100, IsDeleted = false, RemovedAt = null, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00") },
			new Application() { Id = 3, CompetitionId = 1, TeamId = 3, Message = "Prijava tima", IsAccepted = true, IsPaId = true, PaIdAmount = 100, IsDeleted = false, RemovedAt = null, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00") },
			new Application() { Id = 4, CompetitionId = 1, TeamId = 4, Message = "Prijava tima", IsAccepted = true, IsPaId = true, PaIdAmount = 100, IsDeleted = false, RemovedAt = null, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00") },
			new Application() { Id = 5, CompetitionId = 1, TeamId = 5, Message = "Prijava tima", IsAccepted = false, IsPaId = false, PaIdAmount = null, IsDeleted = false, RemovedAt = null, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00") },

			// Competition 2 — 16 applications, all accepted & paid
			new Application() { Id = 6, CompetitionId = 2, TeamId = 1, Message = "Prijava tima", IsAccepted = true, IsPaId = true, PaIdAmount = 80, IsDeleted = false, RemovedAt = null, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00") },
			new Application() { Id = 7, CompetitionId = 2, TeamId = 2, Message = "Prijava tima", IsAccepted = true, IsPaId = true, PaIdAmount = 80, IsDeleted = false, RemovedAt = null, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00") },
			new Application() { Id = 8, CompetitionId = 2, TeamId = 3, Message = "Prijava tima", IsAccepted = true, IsPaId = true, PaIdAmount = 80, IsDeleted = false, RemovedAt = null, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00") },
			new Application() { Id = 9, CompetitionId = 2, TeamId = 4, Message = "Prijava tima", IsAccepted = true, IsPaId = true, PaIdAmount = 80, IsDeleted = false, RemovedAt = null, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00") },
			new Application() { Id = 10, CompetitionId = 2, TeamId = 5, Message = "Prijava tima", IsAccepted = true, IsPaId = true, PaIdAmount = 80, IsDeleted = false, RemovedAt = null, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00") },
			new Application() { Id = 11, CompetitionId = 2, TeamId = 6, Message = "Prijava tima", IsAccepted = true, IsPaId = true, PaIdAmount = 80, IsDeleted = false, RemovedAt = null, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00") },
			new Application() { Id = 12, CompetitionId = 2, TeamId = 7, Message = "Prijava tima", IsAccepted = true, IsPaId = true, PaIdAmount = 80, IsDeleted = false, RemovedAt = null, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00") },
			new Application() { Id = 13, CompetitionId = 2, TeamId = 8, Message = "Prijava tima", IsAccepted = true, IsPaId = true, PaIdAmount = 80, IsDeleted = false, RemovedAt = null, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00") },
			new Application() { Id = 14, CompetitionId = 2, TeamId = 9, Message = "Prijava tima", IsAccepted = true, IsPaId = true, PaIdAmount = 80, IsDeleted = false, RemovedAt = null, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00") },
			new Application() { Id = 15, CompetitionId = 2, TeamId = 10, Message = "Prijava tima", IsAccepted = true, IsPaId = true, PaIdAmount = 80, IsDeleted = false, RemovedAt = null, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00") },
			new Application() { Id = 16, CompetitionId = 2, TeamId = 11, Message = "Prijava tima", IsAccepted = true, IsPaId = true, PaIdAmount = 80, IsDeleted = false, RemovedAt = null, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00") },
			new Application() { Id = 17, CompetitionId = 2, TeamId = 12, Message = "Prijava tima", IsAccepted = true, IsPaId = true, PaIdAmount = 80, IsDeleted = false, RemovedAt = null, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00") },
			new Application() { Id = 18, CompetitionId = 2, TeamId = 13, Message = "Prijava tima", IsAccepted = true, IsPaId = true, PaIdAmount = 80, IsDeleted = false, RemovedAt = null, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00") },
			new Application() { Id = 19, CompetitionId = 2, TeamId = 14, Message = "Prijava tima", IsAccepted = true, IsPaId = true, PaIdAmount = 80, IsDeleted = false, RemovedAt = null, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00") },
			new Application() { Id = 20, CompetitionId = 2, TeamId = 15, Message = "Prijava tima", IsAccepted = true, IsPaId = true, PaIdAmount = 80, IsDeleted = false, RemovedAt = null, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00") },
			new Application() { Id = 21, CompetitionId = 2, TeamId = 16, Message = "Prijava tima", IsAccepted = true, IsPaId = true, PaIdAmount = 80, IsDeleted = false, RemovedAt = null, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00") },

			// Competition 3 — 4 applications, last 4 teams, not accepted, not paid
			new Application() { Id = 22, CompetitionId = 3, TeamId = 17, Message = "Prijava tima", IsAccepted = null, IsPaId = false, PaIdAmount = null, IsDeleted = false, RemovedAt = null, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00") },
			new Application() { Id = 23, CompetitionId = 3, TeamId = 18, Message = "Prijava tima", IsAccepted = null, IsPaId = false, PaIdAmount = null, IsDeleted = false, RemovedAt = null, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00") },
			new Application() { Id = 24, CompetitionId = 3, TeamId = 19, Message = "Prijava tima", IsAccepted = null, IsPaId = false, PaIdAmount = null, IsDeleted = false, RemovedAt = null, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00") },
			new Application() { Id = 25, CompetitionId = 3, TeamId = 20, Message = "Prijava tima", IsAccepted = null, IsPaId = false, PaIdAmount = null, IsDeleted = false, RemovedAt = null, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00") },

			// Competition 5 — 8 applications, first 8 teams, accepted & paid
			new Application() { Id = 26, CompetitionId = 5, TeamId = 1, Message = "Prijava tima", IsAccepted = true, IsPaId = true, PaIdAmount = 200, IsDeleted = false, RemovedAt = null, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00") },
			new Application() { Id = 27, CompetitionId = 5, TeamId = 2, Message = "Prijava tima", IsAccepted = true, IsPaId = true, PaIdAmount = 200, IsDeleted = false, RemovedAt = null, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00") },
			new Application() { Id = 28, CompetitionId = 5, TeamId = 3, Message = "Prijava tima", IsAccepted = true, IsPaId = true, PaIdAmount = 200, IsDeleted = false, RemovedAt = null, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00") },
			new Application() { Id = 29, CompetitionId = 5, TeamId = 4, Message = "Prijava tima", IsAccepted = true, IsPaId = true, PaIdAmount = 200, IsDeleted = false, RemovedAt = null, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00") },
			new Application() { Id = 30, CompetitionId = 5, TeamId = 5, Message = "Prijava tima", IsAccepted = true, IsPaId = true, PaIdAmount = 200, IsDeleted = false, RemovedAt = null, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00") },
			new Application() { Id = 31, CompetitionId = 5, TeamId = 6, Message = "Prijava tima", IsAccepted = true, IsPaId = true, PaIdAmount = 200, IsDeleted = false, RemovedAt = null, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00") },
			new Application() { Id = 32, CompetitionId = 5, TeamId = 7, Message = "Prijava tima", IsAccepted = true, IsPaId = true, PaIdAmount = 200, IsDeleted = false, RemovedAt = null, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00") },
			new Application() { Id = 33, CompetitionId = 5, TeamId = 8, Message = "Prijava tima", IsAccepted = true, IsPaId = true, PaIdAmount = 200, IsDeleted = false, RemovedAt = null, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00") }
		);
		modelBuilder.Entity<Database.City>().HasData(
            new City { Id = 1, Name = "Mostar", IsActive = true, IsDeleted = false, CreatedAt = DateTime.Parse("2025-10-04 14:30:00")},
			new City { Id = 2, Name = "Sarajevo", IsActive = true, IsDeleted = false, CreatedAt = DateTime.Parse("2025-10-04 14:30:00") },
			new City { Id = 3, Name = "Tuzla", IsActive = true, IsDeleted = false, CreatedAt = DateTime.Parse("2025-10-04 14:30:00") },
			new City { Id = 4, Name = "Zenica", IsActive = true, IsDeleted = false, CreatedAt = DateTime.Parse("2025-10-04 14:30:00") },
			new City { Id = 5, Name = "Banja Luka", IsActive = true, IsDeleted = false, CreatedAt = DateTime.Parse("2025-10-04 14:30:00") },
			new City { Id = 6, Name = "Bihać", IsActive = true, IsDeleted = false, CreatedAt = DateTime.Parse("2025-10-04 14:30:00") },
			new City { Id = 7, Name = "Trebinje", IsActive = true, IsDeleted = false, CreatedAt = DateTime.Parse("2025-10-04 14:30:00") },
			new City { Id = 8, Name = "Goražde", IsActive = true, IsDeleted = false, CreatedAt = DateTime.Parse("2025-10-04 14:30:00") },
			new City { Id = 9, Name = "Konjic", IsActive = true, IsDeleted = false, CreatedAt = DateTime.Parse("2025-10-04 14:30:00") },
			new City { Id = 10, Name = "Čapljina", IsActive = true, IsDeleted = false, CreatedAt = DateTime.Parse("2025-10-04 14:30:00") },
			new City { Id = 11, Name = "Stolac", IsActive = true, IsDeleted = false, CreatedAt = DateTime.Parse("2025-10-04 14:30:00") }
		);
        modelBuilder.Entity<Database.Competition>().HasData(
			 new Competition
			 {
				 Id = 1,
				 UserId = 2,
				 SelectionId = 2,
				 CityId = 2,
				 Season = "2025/2026",
				 Name = "Zimska Liga Sarajevo",
				 Description = "Tradicionalna zimska futsal liga koja okuplja najbolje timove iz Sarajeva i okoline.",
				 CompetitionType = CompetitionType.League,
				 MaxTeamCount = 16,
				 MaxPlayersPerTeam = 15,
				 Picture = null,
				 StartDate = DateTime.Parse("2025-10-14 14:30:00"),
				 ApplicationEndDate = DateTime.Parse("2025-10-13 14:30:00"),
				 Fee = 100,
				 IsDeleted = false,
				 Status = CompetitionStatus.ApplicationsOpen,
				 IsActive = true,
				 CreatedAt = DateTime.Parse("2025-10-04 14:30:00"),
				 ModifiedAt = null
			 },
			new Competition
			{
				Id = 2,
				UserId = 3,
				SelectionId = 2,
				CityId = 1,
				Season = "2025/2026",
				Name = "Futsal Kup Mostar",
				Description = "Kup takmičenje u Mostaru poznato po uzbudljivim utakmicama i sjajnoj atmosferi.",
				CompetitionType = CompetitionType.Tournament,
				MaxTeamCount = 16,
				MaxPlayersPerTeam = 12,
				Picture = null,
				StartDate = DateTime.Parse("2025-11-5 14:30:00"),
				ApplicationEndDate = DateTime.Parse("2025-10-25 14:30:00"),
				Fee = 80,
				IsDeleted = false,
				Status = CompetitionStatus.ApplicationsClosed,
				IsActive = true,
				CreatedAt = DateTime.Parse("2025-10-04 14:30:00").AddDays(-25),
				ModifiedAt = null
			},
			new Competition
			{
				Id = 3,
				UserId = 2,
				SelectionId = 1,
				CityId = 3,
				Season = "2025/2026",
				Name = "Proljetna Liga Tuzla U21",
				Description = "Proljetno futsal prvenstvo Tuzle za amatere i poluprofesionalce do 21 godine.",
				CompetitionType = CompetitionType.League,
				MaxTeamCount = 10,
				MaxPlayersPerTeam = 15,
				Picture = null,
				StartDate = DateTime.Parse("2025-10-14 14:30:00"),
				ApplicationEndDate = DateTime.Parse("2025-10-13 14:30:00"),
				Fee = 120,
				IsDeleted = false,
				Status = CompetitionStatus.ApplicationsOpen,
				IsActive = true,
				CreatedAt = DateTime.Parse("2025-10-04 14:30:00").AddDays(-5),
				ModifiedAt = null
			},
			new Competition
			{
				Id = 4,
				UserId = 3,
				SelectionId = 2,
				CityId = 4,
				Season = "2025/2026",
				Name = "Ljetni Turnir Zenica",
				Description = "Popularni ljetni turnir u Zenici koji svake godine privlači veliki broj ekipa i gledalaca.",
				CompetitionType = CompetitionType.Tournament,
				MaxTeamCount = 20,
				MaxPlayersPerTeam = 12,
				Picture = null,
				StartDate = DateTime.Parse("2025-10-14 14:30:00"),
				ApplicationEndDate = DateTime.Parse("2025-10-13 14:30:00"),
				Fee = 150,
				IsDeleted = false,
				Status = CompetitionStatus.Preparation,
				IsActive = true,
				CreatedAt = DateTime.Parse("2025-10-04 14:30:00"),
				ModifiedAt = null
			},
			new Competition
			{
				Id = 5,
				UserId = 3,
				SelectionId = 2,
				CityId = 11,
				Season = "2025/2026",
				Name = "Futsal Kup Stolac",
				Description = "Noćni turnir koji se igra pod reflektorima — spoj sporta, muzike i dobre zabave.",
				CompetitionType = CompetitionType.TournamentKnockOutOnly,
				MaxTeamCount = 8,
				MaxPlayersPerTeam = 12,
				Picture = null,
				StartDate = DateTime.Parse("2025-10-14 14:30:00"),
				ApplicationEndDate = DateTime.Parse("2025-10-13 14:30:00"),
				Fee = 200,
				IsDeleted = false,
				Status = CompetitionStatus.Finished,
				IsActive = false,
				CreatedAt = DateTime.Parse("2025-10-04 14:30:00").AddDays(-30),
				ModifiedAt = null
			}
		);
        modelBuilder.Entity<Database.CompetitionsReferee>().HasData(
			new CompetitionsReferee() { Id = 1, CompetitionId = 1, RefereeId = 1, IsDeleted = false, RemovedAt = null, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00"), ModifiedAt = null },
			new CompetitionsReferee() { Id = 2, CompetitionId = 1, RefereeId = 2, IsDeleted = false, RemovedAt = null, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00"), ModifiedAt = null },
			new CompetitionsReferee() { Id = 3, CompetitionId = 1, RefereeId = 3, IsDeleted = false, RemovedAt = null, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00"), ModifiedAt = null },
			new CompetitionsReferee() { Id = 4, CompetitionId = 1, RefereeId = 4, IsDeleted = false, RemovedAt = null, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00"), ModifiedAt = null },
			new CompetitionsReferee() { Id = 5, CompetitionId = 1, RefereeId = 5, IsDeleted = false, RemovedAt = null, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00"), ModifiedAt = null },
			new CompetitionsReferee() { Id = 6, CompetitionId = 1, RefereeId = 6, IsDeleted = false, RemovedAt = null, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00"), ModifiedAt = null },
			new CompetitionsReferee() { Id = 7, CompetitionId = 1, RefereeId = 7, IsDeleted = false, RemovedAt = null, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00"), ModifiedAt = null },
			new CompetitionsReferee() { Id = 8, CompetitionId = 1, RefereeId = 8, IsDeleted = false, RemovedAt = null, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00"), ModifiedAt = null },
			new CompetitionsReferee() { Id = 9, CompetitionId = 1, RefereeId = 9, IsDeleted = false, RemovedAt = null, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00"), ModifiedAt = null },

			new CompetitionsReferee() { Id = 10, CompetitionId = 2, RefereeId = 10, IsDeleted = false, RemovedAt = null, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00").AddDays(-6), ModifiedAt = null },
			new CompetitionsReferee() { Id = 11, CompetitionId = 2, RefereeId = 11, IsDeleted = false, RemovedAt = null, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00").AddDays(-6), ModifiedAt = null },
			new CompetitionsReferee() { Id = 12, CompetitionId = 2, RefereeId = 12, IsDeleted = false, RemovedAt = null, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00").AddDays(-6), ModifiedAt = null },
			new CompetitionsReferee() { Id = 13, CompetitionId = 2, RefereeId = 13, IsDeleted = false, RemovedAt = null, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00").AddDays(-6), ModifiedAt = null },
			new CompetitionsReferee() { Id = 14, CompetitionId = 2, RefereeId = 14, IsDeleted = false, RemovedAt = null, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00").AddDays(-6), ModifiedAt = null },
			new CompetitionsReferee() { Id = 15, CompetitionId = 2, RefereeId = 15, IsDeleted = false, RemovedAt = null, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00").AddDays(-6), ModifiedAt = null },

			new CompetitionsReferee() { Id = 16, CompetitionId = 3, RefereeId = 16, IsDeleted = false, RemovedAt = null, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00").AddDays(-4), ModifiedAt = null },
			new CompetitionsReferee() { Id = 17, CompetitionId = 3, RefereeId = 17, IsDeleted = false, RemovedAt = null, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00").AddDays(-4), ModifiedAt = null },

			new CompetitionsReferee() { Id = 18, CompetitionId = 5, RefereeId = 10, IsDeleted = false, RemovedAt = null, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00").AddDays(-2), ModifiedAt = null },
			new CompetitionsReferee() { Id = 19, CompetitionId = 5, RefereeId = 11, IsDeleted = false, RemovedAt = null, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00").AddDays(-2), ModifiedAt = null },
			new CompetitionsReferee() { Id = 20, CompetitionId = 5, RefereeId = 12, IsDeleted = false, RemovedAt = null, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00").AddDays(-2), ModifiedAt = null },
			new CompetitionsReferee() { Id = 21, CompetitionId = 5, RefereeId = 13, IsDeleted = false, RemovedAt = null, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00").AddDays(-2), ModifiedAt = null },
			new CompetitionsReferee() { Id = 22, CompetitionId = 5, RefereeId = 14, IsDeleted = false, RemovedAt = null, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00").AddDays(-2), ModifiedAt = null },
			new CompetitionsReferee() { Id = 23, CompetitionId = 5, RefereeId = 15, IsDeleted = false, RemovedAt = null, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00").AddDays(-2), ModifiedAt = null },
			new CompetitionsReferee() { Id = 24, CompetitionId = 5, RefereeId = 16, IsDeleted = false, RemovedAt = null, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00").AddDays(-2), ModifiedAt = null },
			new CompetitionsReferee() { Id = 25, CompetitionId = 5, RefereeId = 17, IsDeleted = false, RemovedAt = null, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00").AddDays(-2), ModifiedAt = null },
			new CompetitionsReferee() { Id = 26, CompetitionId = 5, RefereeId = 18, IsDeleted = false, RemovedAt = null, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00").AddDays(-2), ModifiedAt = null },
			new CompetitionsReferee() { Id = 27, CompetitionId = 5, RefereeId = 19, IsDeleted = false, RemovedAt = null, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00").AddDays(-2), ModifiedAt = null },
			new CompetitionsReferee() { Id = 28, CompetitionId = 5, RefereeId = 20, IsDeleted = false, RemovedAt = null, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00").AddDays(-2), ModifiedAt = null }
		);
		modelBuilder.Entity<CompetitionsRefereesMatch>().HasData(
			// Competition 2 matches (assuming match IDs 1 and 2)
			new CompetitionsRefereesMatch { Id = 1, CompetitionsRefereesId = 10, MatchId = 1, IsActive = true, IsDeleted = false, CreatedAt = DateTime.Parse("2025-10-04 14:30:00") },
			new CompetitionsRefereesMatch { Id = 2, CompetitionsRefereesId = 11, MatchId = 1, IsActive = true, IsDeleted = false, CreatedAt = DateTime.Parse("2025-10-04 14:30:00") },
			new CompetitionsRefereesMatch { Id = 3, CompetitionsRefereesId = 12, MatchId = 2, IsActive = true, IsDeleted = false, CreatedAt = DateTime.Parse("2025-10-04 14:30:00") },
			new CompetitionsRefereesMatch { Id = 4, CompetitionsRefereesId = 13, MatchId = 2, IsActive = true, IsDeleted = false, CreatedAt = DateTime.Parse("2025-10-04 14:30:00") },

			// Competition 5 matches (match IDs 3 to 9)
			new CompetitionsRefereesMatch { Id = 5, CompetitionsRefereesId = 18, MatchId = 3, IsActive = true, IsDeleted = false, CreatedAt = DateTime.Parse("2025-10-04 14:30:00") },
			new CompetitionsRefereesMatch { Id = 6, CompetitionsRefereesId = 19, MatchId = 3, IsActive = true, IsDeleted = false, CreatedAt = DateTime.Parse("2025-10-04 14:30:00") },
			new CompetitionsRefereesMatch { Id = 7, CompetitionsRefereesId = 20, MatchId = 4, IsActive = true, IsDeleted = false, CreatedAt = DateTime.Parse("2025-10-04 14:30:00") },
			new CompetitionsRefereesMatch { Id = 8, CompetitionsRefereesId = 21, MatchId = 4, IsActive = true, IsDeleted = false, CreatedAt = DateTime.Parse("2025-10-04 14:30:00") },
			new CompetitionsRefereesMatch { Id = 9, CompetitionsRefereesId = 22, MatchId = 5, IsActive = true, IsDeleted = false, CreatedAt = DateTime.Parse("2025-10-04 14:30:00") },
			new CompetitionsRefereesMatch { Id = 10, CompetitionsRefereesId = 23, MatchId = 5, IsActive = true, IsDeleted = false, CreatedAt = DateTime.Parse("2025-10-04 14:30:00") },
			new CompetitionsRefereesMatch { Id = 11, CompetitionsRefereesId = 24, MatchId = 6, IsActive = true, IsDeleted = false, CreatedAt = DateTime.Parse("2025-10-04 14:30:00") },
			new CompetitionsRefereesMatch { Id = 12, CompetitionsRefereesId = 25, MatchId = 6, IsActive = true, IsDeleted = false, CreatedAt = DateTime.Parse("2025-10-04 14:30:00") },
			new CompetitionsRefereesMatch { Id = 13, CompetitionsRefereesId = 26, MatchId = 7, IsActive = true, IsDeleted = false, CreatedAt = DateTime.Parse("2025-10-04 14:30:00") },
			new CompetitionsRefereesMatch { Id = 14, CompetitionsRefereesId = 27, MatchId = 7, IsActive = true, IsDeleted = false, CreatedAt = DateTime.Parse("2025-10-04 14:30:00") },
			new CompetitionsRefereesMatch { Id = 15, CompetitionsRefereesId = 28, MatchId = 8, IsActive = true, IsDeleted = false, CreatedAt = DateTime.Parse("2025-10-04 14:30:00") },
			new CompetitionsRefereesMatch { Id = 16, CompetitionsRefereesId = 18, MatchId = 8, IsActive = true, IsDeleted = false, CreatedAt = DateTime.Parse("2025-10-04 14:30:00") },
			new CompetitionsRefereesMatch { Id = 17, CompetitionsRefereesId = 19, MatchId = 9, IsActive = true, IsDeleted = false, CreatedAt = DateTime.Parse("2025-10-04 14:30:00") },
			new CompetitionsRefereesMatch { Id = 18, CompetitionsRefereesId = 20, MatchId = 9, IsActive = true, IsDeleted = false, CreatedAt = DateTime.Parse("2025-10-04 14:30:00") }
		);
		modelBuilder.Entity<Database.CompetitionsSponsor>().HasData(
			new CompetitionsSponsor() { Id = 1, CompetitionId = 1, SponsorId = 1, Type = null, IsDeleted = false, RemovedAt = null, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00"), ModifiedAt = null },
			new CompetitionsSponsor() { Id = 2, CompetitionId = 1, SponsorId = 2, Type = null, IsDeleted = false, RemovedAt = null, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00"), ModifiedAt = null },
			new CompetitionsSponsor() { Id = 3, CompetitionId = 1, SponsorId = 3, Type = null, IsDeleted = false, RemovedAt = null, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00"), ModifiedAt = null },
			new CompetitionsSponsor() { Id = 4, CompetitionId = 1, SponsorId = 4, Type = null, IsDeleted = false, RemovedAt = null, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00"), ModifiedAt = null },
			new CompetitionsSponsor() { Id = 5, CompetitionId = 1, SponsorId = 5, Type = null, IsDeleted = false, RemovedAt = null, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00"), ModifiedAt = null },
			    
			new CompetitionsSponsor() { Id = 6, CompetitionId = 2, SponsorId = 6, Type = null, IsDeleted = false, RemovedAt = null, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00").AddDays(-6), ModifiedAt = null },
			new CompetitionsSponsor() { Id = 7, CompetitionId = 2, SponsorId = 7, Type = null, IsDeleted = false, RemovedAt = null, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00").AddDays(-6), ModifiedAt = null },
			new CompetitionsSponsor() { Id = 8, CompetitionId = 2, SponsorId = 8, Type = null, IsDeleted = false, RemovedAt = null, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00").AddDays(-6), ModifiedAt = null },
			new CompetitionsSponsor() { Id = 9, CompetitionId = 2, SponsorId = 9, Type = null, IsDeleted = false, RemovedAt = null, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00").AddDays(-6), ModifiedAt = null },

			new CompetitionsSponsor() { Id = 10, CompetitionId = 3, SponsorId = 10, Type = null, IsDeleted = false, RemovedAt = null, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00").AddDays(-4), ModifiedAt = null },
			new CompetitionsSponsor() { Id = 11, CompetitionId = 3, SponsorId = 11, Type = null, IsDeleted = false, RemovedAt = null, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00").AddDays(-4), ModifiedAt = null },

			new CompetitionsSponsor() { Id = 12, CompetitionId = 5, SponsorId = 12, Type = null, IsDeleted = false, RemovedAt = null, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00").AddDays(-2), ModifiedAt = null },
			new CompetitionsSponsor() { Id = 13, CompetitionId = 5, SponsorId = 13, Type = null, IsDeleted = false, RemovedAt = null, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00").AddDays(-2), ModifiedAt = null },
			new CompetitionsSponsor() { Id = 14, CompetitionId = 5, SponsorId = 14, Type = null, IsDeleted = false, RemovedAt = null, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00").AddDays(-2), ModifiedAt = null },
			new CompetitionsSponsor() { Id = 15, CompetitionId = 5, SponsorId = 15, Type = null, IsDeleted = false, RemovedAt = null, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00").AddDays(-2), ModifiedAt = null },
			new CompetitionsSponsor() { Id = 16, CompetitionId = 5, SponsorId = 16, Type = null, IsDeleted = false, RemovedAt = null, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00").AddDays(-2), ModifiedAt = null }

		);
		modelBuilder.Entity<CompetitionsTeam>().HasData(
			// Competition 1 (all in Group 1)
			new CompetitionsTeam { Id = 1, CompetitionId = 1, TeamId = 1, GroupId = 1, IsEliminated = false, IsDeleted = false, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00") },
			new CompetitionsTeam { Id = 2, CompetitionId = 1, TeamId = 2, GroupId = 1, IsEliminated = false, IsDeleted = false, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00") },
			new CompetitionsTeam { Id = 3, CompetitionId = 1, TeamId = 3, GroupId = 1, IsEliminated = false, IsDeleted = false, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00") },
			new CompetitionsTeam { Id = 4, CompetitionId = 1, TeamId = 4, GroupId = 1, IsEliminated = false, IsDeleted = false, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00") },
			new CompetitionsTeam { Id = 5, CompetitionId = 1, TeamId = 5, GroupId = 1, IsEliminated = false, IsDeleted = false, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00") },

			// Competition 2 (4 groups, 4 teams each)
			new CompetitionsTeam { Id = 6, CompetitionId = 2, TeamId = 1, GroupId = 2, IsEliminated = false, IsDeleted = false, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00") },
			new CompetitionsTeam { Id = 7, CompetitionId = 2, TeamId = 2, GroupId = 2, IsEliminated = false, IsDeleted = false, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00") },
			new CompetitionsTeam { Id = 8, CompetitionId = 2, TeamId = 3, GroupId = 2, IsEliminated = false, IsDeleted = false, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00") },
			new CompetitionsTeam { Id = 9, CompetitionId = 2, TeamId = 4, GroupId = 2, IsEliminated = false, IsDeleted = false, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00") },

			new CompetitionsTeam { Id = 10, CompetitionId = 2, TeamId = 5, GroupId = 3, IsEliminated = false, IsDeleted = false, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00") },
			new CompetitionsTeam { Id = 11, CompetitionId = 2, TeamId = 6, GroupId = 3, IsEliminated = false, IsDeleted = false, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00") },
			new CompetitionsTeam { Id = 12, CompetitionId = 2, TeamId = 7, GroupId = 3, IsEliminated = false, IsDeleted = false, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00") },
			new CompetitionsTeam { Id = 13, CompetitionId = 2, TeamId = 8, GroupId = 3, IsEliminated = false, IsDeleted = false, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00") },

			new CompetitionsTeam { Id = 14, CompetitionId = 2, TeamId = 9, GroupId = 4, IsEliminated = false, IsDeleted = false, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00") },
			new CompetitionsTeam { Id = 15, CompetitionId = 2, TeamId = 10, GroupId = 4, IsEliminated = false, IsDeleted = false, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00") },
			new CompetitionsTeam { Id = 16, CompetitionId = 2, TeamId = 11, GroupId = 4, IsEliminated = false, IsDeleted = false, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00") },
			new CompetitionsTeam { Id = 17, CompetitionId = 2, TeamId = 12, GroupId = 4, IsEliminated = false, IsDeleted = false, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00") },

			new CompetitionsTeam { Id = 18, CompetitionId = 2, TeamId = 13, GroupId = 5, IsEliminated = false, IsDeleted = false, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00") },
			new CompetitionsTeam { Id = 19, CompetitionId = 2, TeamId = 14, GroupId = 5, IsEliminated = false, IsDeleted = false, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00") },
			new CompetitionsTeam { Id = 20, CompetitionId = 2, TeamId = 15, GroupId = 5, IsEliminated = false, IsDeleted = false, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00") },
			new CompetitionsTeam { Id = 21, CompetitionId = 2, TeamId = 16, GroupId = 5, IsEliminated = false, IsDeleted = false, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00") },

			// Competition 3 (no groups)
			new CompetitionsTeam { Id = 22, CompetitionId = 3, TeamId = 17, GroupId = null, IsEliminated = false, IsDeleted = false, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00") },
			new CompetitionsTeam { Id = 23, CompetitionId = 3, TeamId = 18, GroupId = null, IsEliminated = false, IsDeleted = false, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00") },
			new CompetitionsTeam { Id = 24, CompetitionId = 3, TeamId = 19, GroupId = null, IsEliminated = false, IsDeleted = false, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00") },
			new CompetitionsTeam { Id = 25, CompetitionId = 3, TeamId = 20, GroupId = null, IsEliminated = false, IsDeleted = false, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00") },

			// Competition 5 (no groups)
			new CompetitionsTeam { Id = 26, CompetitionId = 5, TeamId = 1, GroupId = null, IsEliminated = false, IsDeleted = false, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00") },
			new CompetitionsTeam { Id = 27, CompetitionId = 5, TeamId = 2, GroupId = null, IsEliminated = false, IsDeleted = false, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00") },
			new CompetitionsTeam { Id = 28, CompetitionId = 5, TeamId = 3, GroupId = null, IsEliminated = false, IsDeleted = false, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00") },
			new CompetitionsTeam { Id = 29, CompetitionId = 5, TeamId = 4, GroupId = null, IsEliminated = false, IsDeleted = false, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00") },
			new CompetitionsTeam { Id = 30, CompetitionId = 5, TeamId = 5, GroupId = null, IsEliminated = false, IsDeleted = false, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00") },
			new CompetitionsTeam { Id = 31, CompetitionId = 5, TeamId = 6, GroupId = null, IsEliminated = false, IsDeleted = false, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00") },
			new CompetitionsTeam { Id = 32, CompetitionId = 5, TeamId = 7, GroupId = null, IsEliminated = false, IsDeleted = false, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00") },
			new CompetitionsTeam { Id = 33, CompetitionId = 5, TeamId = 8, GroupId = null, IsEliminated = false, IsDeleted = false, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00") }
		);

		modelBuilder.Entity<CompetitionsTeamsPlayer>().HasData(
			// Competition 1 — Team 1 (5 players)
			new CompetitionsTeamsPlayer { Id = 1, CompetitionsTeamsId = 1, PlayerId = 1, GoalsTotal = 0, IsVerified = true, IsDeleted = false, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00") },
			new CompetitionsTeamsPlayer { Id = 2, CompetitionsTeamsId = 1, PlayerId = 2, GoalsTotal = 0, IsVerified = true, IsDeleted = false, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00") },
			new CompetitionsTeamsPlayer { Id = 3, CompetitionsTeamsId = 1, PlayerId = 3, GoalsTotal = 0, IsVerified = true, IsDeleted = false, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00") },
			new CompetitionsTeamsPlayer { Id = 4, CompetitionsTeamsId = 1, PlayerId = 4, GoalsTotal = 0, IsVerified = true, IsDeleted = false, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00") },
			new CompetitionsTeamsPlayer { Id = 5, CompetitionsTeamsId = 1, PlayerId = 5, GoalsTotal = 0, IsVerified = true, IsDeleted = false, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00") },

			// Competition 1 — Team 2 (6 players)
			new CompetitionsTeamsPlayer { Id = 6, CompetitionsTeamsId = 2, PlayerId = 6, GoalsTotal = 0, IsVerified = true, IsDeleted = false, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00") },
			new CompetitionsTeamsPlayer { Id = 7, CompetitionsTeamsId = 2, PlayerId = 7, GoalsTotal = 0, IsVerified = true, IsDeleted = false, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00") },
			new CompetitionsTeamsPlayer { Id = 8, CompetitionsTeamsId = 2, PlayerId = 8, GoalsTotal = 0, IsVerified = true, IsDeleted = false, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00") },
			new CompetitionsTeamsPlayer { Id = 9, CompetitionsTeamsId = 2, PlayerId = 9, GoalsTotal = 0, IsVerified = true, IsDeleted = false, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00") },
			new CompetitionsTeamsPlayer { Id = 10, CompetitionsTeamsId = 2, PlayerId = 10, GoalsTotal = 0, IsVerified = true, IsDeleted = false, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00") },
			new CompetitionsTeamsPlayer { Id = 11, CompetitionsTeamsId = 2, PlayerId = 11, GoalsTotal = 0, IsVerified = true, IsDeleted = false, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00") },

			// Competition 1 — Team 3 (5 players)
			new CompetitionsTeamsPlayer { Id = 12, CompetitionsTeamsId = 3, PlayerId = 12, GoalsTotal = 0, IsVerified = true, IsDeleted = false, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00") },
			new CompetitionsTeamsPlayer { Id = 13, CompetitionsTeamsId = 3, PlayerId = 13, GoalsTotal = 0, IsVerified = true, IsDeleted = false, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00") },
			new CompetitionsTeamsPlayer { Id = 14, CompetitionsTeamsId = 3, PlayerId = 14, GoalsTotal = 0, IsVerified = true, IsDeleted = false, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00") },
			new CompetitionsTeamsPlayer { Id = 15, CompetitionsTeamsId = 3, PlayerId = 15, GoalsTotal = 0, IsVerified = true, IsDeleted = false, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00") },
			new CompetitionsTeamsPlayer { Id = 16, CompetitionsTeamsId = 3, PlayerId = 16, GoalsTotal = 0, IsVerified = true, IsDeleted = false, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00") },

			// Competition 1 — Team 4 (6 players)
			new CompetitionsTeamsPlayer { Id = 17, CompetitionsTeamsId = 4, PlayerId = 17, GoalsTotal = 0, IsVerified = true, IsDeleted = false, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00") },
			new CompetitionsTeamsPlayer { Id = 18, CompetitionsTeamsId = 4, PlayerId = 18, GoalsTotal = 0, IsVerified = true, IsDeleted = false, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00") },
			new CompetitionsTeamsPlayer { Id = 19, CompetitionsTeamsId = 4, PlayerId = 19, GoalsTotal = 0, IsVerified = true, IsDeleted = false, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00") },
			new CompetitionsTeamsPlayer { Id = 20, CompetitionsTeamsId = 4, PlayerId = 20, GoalsTotal = 0, IsVerified = true, IsDeleted = false, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00") },
			new CompetitionsTeamsPlayer { Id = 21, CompetitionsTeamsId = 4, PlayerId = 21, GoalsTotal = 0, IsVerified = true, IsDeleted = false, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00") },
			new CompetitionsTeamsPlayer { Id = 22, CompetitionsTeamsId = 4, PlayerId = 22, GoalsTotal = 0, IsVerified = true, IsDeleted = false, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00") },

			// Competition 1 — Team 5 (5 players)
			new CompetitionsTeamsPlayer { Id = 23, CompetitionsTeamsId = 5, PlayerId = 23, GoalsTotal = 0, IsVerified = true, IsDeleted = false, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00") },
			new CompetitionsTeamsPlayer { Id = 24, CompetitionsTeamsId = 5, PlayerId = 24, GoalsTotal = 0, IsVerified = true, IsDeleted = false, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00") },
			new CompetitionsTeamsPlayer { Id = 25, CompetitionsTeamsId = 5, PlayerId = 25, GoalsTotal = 0, IsVerified = true, IsDeleted = false, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00") },
			new CompetitionsTeamsPlayer { Id = 26, CompetitionsTeamsId = 5, PlayerId = 26, GoalsTotal = 0, IsVerified = true, IsDeleted = false, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00") },
			new CompetitionsTeamsPlayer { Id = 27, CompetitionsTeamsId = 5, PlayerId = 27, GoalsTotal = 0, IsVerified = true, IsDeleted = false, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00") },

			// Competition 2 — Team 6 (first team of competition 2, 6 players)
			new CompetitionsTeamsPlayer { Id = 28, CompetitionsTeamsId = 6, PlayerId = 28, GoalsTotal = 0, IsVerified = true, IsDeleted = false, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00") },
			new CompetitionsTeamsPlayer { Id = 29, CompetitionsTeamsId = 6, PlayerId = 29, GoalsTotal = 0, IsVerified = true, IsDeleted = false, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00") },
			new CompetitionsTeamsPlayer { Id = 30, CompetitionsTeamsId = 6, PlayerId = 30, GoalsTotal = 0, IsVerified = true, IsDeleted = false, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00") },
			new CompetitionsTeamsPlayer { Id = 31, CompetitionsTeamsId = 6, PlayerId = 31, GoalsTotal = 0, IsVerified = true, IsDeleted = false, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00") },
			new CompetitionsTeamsPlayer { Id = 32, CompetitionsTeamsId = 6, PlayerId = 32, GoalsTotal = 0, IsVerified = true, IsDeleted = false, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00") },
			new CompetitionsTeamsPlayer { Id = 33, CompetitionsTeamsId = 6, PlayerId = 33, GoalsTotal = 0, IsVerified = true, IsDeleted = false, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00") },

			// Competition 2 — Team 7 (6 players)
			new CompetitionsTeamsPlayer { Id = 34, CompetitionsTeamsId = 7, PlayerId = 34, GoalsTotal = 0, IsVerified = true, IsDeleted = false, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00") },
			new CompetitionsTeamsPlayer { Id = 35, CompetitionsTeamsId = 7, PlayerId = 35, GoalsTotal = 0, IsVerified = true, IsDeleted = false, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00") },
			new CompetitionsTeamsPlayer { Id = 36, CompetitionsTeamsId = 7, PlayerId = 36, GoalsTotal = 0, IsVerified = true, IsDeleted = false, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00") },
			new CompetitionsTeamsPlayer { Id = 37, CompetitionsTeamsId = 7, PlayerId = 37, GoalsTotal = 0, IsVerified = true, IsDeleted = false, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00") },
			new CompetitionsTeamsPlayer { Id = 38, CompetitionsTeamsId = 7, PlayerId = 38, GoalsTotal = 0, IsVerified = true, IsDeleted = false, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00") },
			new CompetitionsTeamsPlayer { Id = 39, CompetitionsTeamsId = 7, PlayerId = 39, GoalsTotal = 0, IsVerified = true, IsDeleted = false, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00") },

			// Competition 2 — Team 8 (5 players)
			new CompetitionsTeamsPlayer { Id = 40, CompetitionsTeamsId = 8, PlayerId = 40, GoalsTotal = 0, IsVerified = true, IsDeleted = false, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00") },
			new CompetitionsTeamsPlayer { Id = 41, CompetitionsTeamsId = 8, PlayerId = 41, GoalsTotal = 0, IsVerified = true, IsDeleted = false, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00") },
			new CompetitionsTeamsPlayer { Id = 42, CompetitionsTeamsId = 8, PlayerId = 42, GoalsTotal = 0, IsVerified = true, IsDeleted = false, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00") },
			new CompetitionsTeamsPlayer { Id = 43, CompetitionsTeamsId = 8, PlayerId = 43, GoalsTotal = 0, IsVerified = true, IsDeleted = false, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00") },
			new CompetitionsTeamsPlayer { Id = 44, CompetitionsTeamsId = 8, PlayerId = 44, GoalsTotal = 0, IsVerified = true, IsDeleted = false, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00") },

			// Competition 2 — Team 9 (7 players)
			new CompetitionsTeamsPlayer { Id = 45, CompetitionsTeamsId = 9, PlayerId = 45, GoalsTotal = 0, IsVerified = true, IsDeleted = false, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00") },
			new CompetitionsTeamsPlayer { Id = 46, CompetitionsTeamsId = 9, PlayerId = 46, GoalsTotal = 0, IsVerified = true, IsDeleted = false, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00") },
			new CompetitionsTeamsPlayer { Id = 47, CompetitionsTeamsId = 9, PlayerId = 47, GoalsTotal = 0, IsVerified = true, IsDeleted = false, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00") },
			new CompetitionsTeamsPlayer { Id = 48, CompetitionsTeamsId = 9, PlayerId = 48, GoalsTotal = 0, IsVerified = true, IsDeleted = false, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00") },
			new CompetitionsTeamsPlayer { Id = 49, CompetitionsTeamsId = 9, PlayerId = 49, GoalsTotal = 0, IsVerified = true, IsDeleted = false, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00") },
			new CompetitionsTeamsPlayer { Id = 50, CompetitionsTeamsId = 9, PlayerId = 50, GoalsTotal = 0, IsVerified = true, IsDeleted = false, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00") },
			new CompetitionsTeamsPlayer { Id = 51, CompetitionsTeamsId = 9, PlayerId = 51, GoalsTotal = 0, IsVerified = true, IsDeleted = false, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00") },

			// Competition 2 — Team 10 (5 players)
			new CompetitionsTeamsPlayer { Id = 52, CompetitionsTeamsId = 10, PlayerId = 52, GoalsTotal = 0, IsVerified = true, IsDeleted = false, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00") },
			new CompetitionsTeamsPlayer { Id = 53, CompetitionsTeamsId = 10, PlayerId = 53, GoalsTotal = 0, IsVerified = true, IsDeleted = false, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00") },
			new CompetitionsTeamsPlayer { Id = 54, CompetitionsTeamsId = 10, PlayerId = 54, GoalsTotal = 0, IsVerified = true, IsDeleted = false, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00") },
			new CompetitionsTeamsPlayer { Id = 55, CompetitionsTeamsId = 10, PlayerId = 55, GoalsTotal = 0, IsVerified = true, IsDeleted = false, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00") },
			new CompetitionsTeamsPlayer { Id = 56, CompetitionsTeamsId = 10, PlayerId = 56, GoalsTotal = 0, IsVerified = true, IsDeleted = false, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00") },

			// Competition 2 — Team 11 (6 players)
			new CompetitionsTeamsPlayer { Id = 57, CompetitionsTeamsId = 11, PlayerId = 57, GoalsTotal = 0, IsVerified = true, IsDeleted = false, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00") },
			new CompetitionsTeamsPlayer { Id = 58, CompetitionsTeamsId = 11, PlayerId = 58, GoalsTotal = 0, IsVerified = true, IsDeleted = false, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00") },
			new CompetitionsTeamsPlayer { Id = 59, CompetitionsTeamsId = 11, PlayerId = 59, GoalsTotal = 0, IsVerified = true, IsDeleted = false, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00") },
			new CompetitionsTeamsPlayer { Id = 60, CompetitionsTeamsId = 11, PlayerId = 60, GoalsTotal = 0, IsVerified = true, IsDeleted = false, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00") },
			new CompetitionsTeamsPlayer { Id = 61, CompetitionsTeamsId = 11, PlayerId = 61, GoalsTotal = 0, IsVerified = true, IsDeleted = false, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00") },
			new CompetitionsTeamsPlayer { Id = 62, CompetitionsTeamsId = 11, PlayerId = 62, GoalsTotal = 0, IsVerified = true, IsDeleted = false, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00") },

			// Competition 2 — Team 12 (5 players)
			new CompetitionsTeamsPlayer { Id = 63, CompetitionsTeamsId = 12, PlayerId = 63, GoalsTotal = 0, IsVerified = true, IsDeleted = false, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00") },
			new CompetitionsTeamsPlayer { Id = 64, CompetitionsTeamsId = 12, PlayerId = 64, GoalsTotal = 0, IsVerified = true, IsDeleted = false, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00") },
			new CompetitionsTeamsPlayer { Id = 65, CompetitionsTeamsId = 12, PlayerId = 65, GoalsTotal = 0, IsVerified = true, IsDeleted = false, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00") },
			new CompetitionsTeamsPlayer { Id = 66, CompetitionsTeamsId = 12, PlayerId = 66, GoalsTotal = 0, IsVerified = true, IsDeleted = false, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00") },
			new CompetitionsTeamsPlayer { Id = 67, CompetitionsTeamsId = 12, PlayerId = 67, GoalsTotal = 0, IsVerified = true, IsDeleted = false, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00") },

			// Competition 2 — Team 13 (6 players)
			new CompetitionsTeamsPlayer { Id = 68, CompetitionsTeamsId = 13, PlayerId = 68, GoalsTotal = 0, IsVerified = true, IsDeleted = false, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00") },
			new CompetitionsTeamsPlayer { Id = 69, CompetitionsTeamsId = 13, PlayerId = 69, GoalsTotal = 0, IsVerified = true, IsDeleted = false, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00") },
			new CompetitionsTeamsPlayer { Id = 70, CompetitionsTeamsId = 13, PlayerId = 70, GoalsTotal = 0, IsVerified = true, IsDeleted = false, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00") },
			new CompetitionsTeamsPlayer { Id = 71, CompetitionsTeamsId = 13, PlayerId = 71, GoalsTotal = 0, IsVerified = true, IsDeleted = false, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00") },
			new CompetitionsTeamsPlayer { Id = 72, CompetitionsTeamsId = 13, PlayerId = 72, GoalsTotal = 0, IsVerified = true, IsDeleted = false, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00") },
			new CompetitionsTeamsPlayer { Id = 73, CompetitionsTeamsId = 13, PlayerId = 73, GoalsTotal = 0, IsVerified = true, IsDeleted = false, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00") },

			// Competition 2 — Team 14 (5 players)
			new CompetitionsTeamsPlayer { Id = 74, CompetitionsTeamsId = 14, PlayerId = 74, GoalsTotal = 0, IsVerified = true, IsDeleted = false, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00") },
			new CompetitionsTeamsPlayer { Id = 75, CompetitionsTeamsId = 14, PlayerId = 75, GoalsTotal = 0, IsVerified = true, IsDeleted = false, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00") },
			new CompetitionsTeamsPlayer { Id = 76, CompetitionsTeamsId = 14, PlayerId = 76, GoalsTotal = 0, IsVerified = true, IsDeleted = false, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00") },
			new CompetitionsTeamsPlayer { Id = 77, CompetitionsTeamsId = 14, PlayerId = 77, GoalsTotal = 0, IsVerified = true, IsDeleted = false, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00") },
			new CompetitionsTeamsPlayer { Id = 78, CompetitionsTeamsId = 14, PlayerId = 78, GoalsTotal = 0, IsVerified = true, IsDeleted = false, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00") },

			// Competition 2 — Team 15 (7 players)
			new CompetitionsTeamsPlayer { Id = 79, CompetitionsTeamsId = 15, PlayerId = 79, GoalsTotal = 0, IsVerified = true, IsDeleted = false, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00") },
			new CompetitionsTeamsPlayer { Id = 80, CompetitionsTeamsId = 15, PlayerId = 80, GoalsTotal = 0, IsVerified = true, IsDeleted = false, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00") },
			new CompetitionsTeamsPlayer { Id = 81, CompetitionsTeamsId = 15, PlayerId = 81, GoalsTotal = 0, IsVerified = true, IsDeleted = false, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00") },
			new CompetitionsTeamsPlayer { Id = 82, CompetitionsTeamsId = 15, PlayerId = 82, GoalsTotal = 0, IsVerified = true, IsDeleted = false, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00") },
			new CompetitionsTeamsPlayer { Id = 83, CompetitionsTeamsId = 15, PlayerId = 83, GoalsTotal = 0, IsVerified = true, IsDeleted = false, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00") },
			new CompetitionsTeamsPlayer { Id = 84, CompetitionsTeamsId = 15, PlayerId = 84, GoalsTotal = 0, IsVerified = true, IsDeleted = false, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00") },
			new CompetitionsTeamsPlayer { Id = 85, CompetitionsTeamsId = 15, PlayerId = 85, GoalsTotal = 0, IsVerified = true, IsDeleted = false, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00") },

			// Competition 2 — Team 16 (6 players)
			new CompetitionsTeamsPlayer { Id = 86, CompetitionsTeamsId = 16, PlayerId = 86, GoalsTotal = 0, IsVerified = true, IsDeleted = false, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00") },
			new CompetitionsTeamsPlayer { Id = 87, CompetitionsTeamsId = 16, PlayerId = 87, GoalsTotal = 0, IsVerified = true, IsDeleted = false, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00") },
			new CompetitionsTeamsPlayer { Id = 88, CompetitionsTeamsId = 16, PlayerId = 88, GoalsTotal = 0, IsVerified = true, IsDeleted = false, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00") },
			new CompetitionsTeamsPlayer { Id = 89, CompetitionsTeamsId = 16, PlayerId = 89, GoalsTotal = 0, IsVerified = true, IsDeleted = false, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00") },
			new CompetitionsTeamsPlayer { Id = 90, CompetitionsTeamsId = 16, PlayerId = 90, GoalsTotal = 0, IsVerified = true, IsDeleted = false, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00") },
			new CompetitionsTeamsPlayer { Id = 91, CompetitionsTeamsId = 16, PlayerId = 91, GoalsTotal = 0, IsVerified = true, IsDeleted = false, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00") },

			// Competition 3 — Team 17 (5 players)
			new CompetitionsTeamsPlayer { Id = 92, CompetitionsTeamsId = 17, PlayerId = 92, GoalsTotal = 0, IsVerified = true, IsDeleted = false, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00") },
			new CompetitionsTeamsPlayer { Id = 93, CompetitionsTeamsId = 17, PlayerId = 93, GoalsTotal = 0, IsVerified = true, IsDeleted = false, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00") },
			new CompetitionsTeamsPlayer { Id = 94, CompetitionsTeamsId = 17, PlayerId = 94, GoalsTotal = 0, IsVerified = true, IsDeleted = false, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00") },
			new CompetitionsTeamsPlayer { Id = 95, CompetitionsTeamsId = 17, PlayerId = 95, GoalsTotal = 0, IsVerified = true, IsDeleted = false, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00") },
			new CompetitionsTeamsPlayer { Id = 96, CompetitionsTeamsId = 17, PlayerId = 96, GoalsTotal = 0, IsVerified = true, IsDeleted = false, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00") },

			// Competition 3 — Team 18 (6 players)
			new CompetitionsTeamsPlayer { Id = 97, CompetitionsTeamsId = 18, PlayerId = 97, GoalsTotal = 0, IsVerified = true, IsDeleted = false, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00") },
			new CompetitionsTeamsPlayer { Id = 98, CompetitionsTeamsId = 18, PlayerId = 98, GoalsTotal = 0, IsVerified = true, IsDeleted = false, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00") },
			new CompetitionsTeamsPlayer { Id = 99, CompetitionsTeamsId = 18, PlayerId = 99, GoalsTotal = 0, IsVerified = true, IsDeleted = false, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00") },
			new CompetitionsTeamsPlayer { Id = 100, CompetitionsTeamsId = 18, PlayerId = 100, GoalsTotal = 0, IsVerified = true, IsDeleted = false, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00") },
			new CompetitionsTeamsPlayer { Id = 101, CompetitionsTeamsId = 18, PlayerId = 1, GoalsTotal = 0, IsVerified = true, IsDeleted = false, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00") },
			new CompetitionsTeamsPlayer { Id = 102, CompetitionsTeamsId = 18, PlayerId = 2, GoalsTotal = 0, IsVerified = true, IsDeleted = false, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00") },

			// Competition 3 — Team 19 (5 players)
			new CompetitionsTeamsPlayer { Id = 103, CompetitionsTeamsId = 19, PlayerId = 3, GoalsTotal = 0, IsVerified = true, IsDeleted = false, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00") },
			new CompetitionsTeamsPlayer { Id = 104, CompetitionsTeamsId = 19, PlayerId = 4, GoalsTotal = 0, IsVerified = true, IsDeleted = false, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00") },
			new CompetitionsTeamsPlayer { Id = 105, CompetitionsTeamsId = 19, PlayerId = 5, GoalsTotal = 0, IsVerified = true, IsDeleted = false, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00") },
			new CompetitionsTeamsPlayer { Id = 106, CompetitionsTeamsId = 19, PlayerId = 6, GoalsTotal = 0, IsVerified = true, IsDeleted = false, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00") },
			new CompetitionsTeamsPlayer { Id = 107, CompetitionsTeamsId = 19, PlayerId = 7, GoalsTotal = 0, IsVerified = true, IsDeleted = false, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00") },

			// Competition 3 — Team 20 (7 players)
			new CompetitionsTeamsPlayer { Id = 108, CompetitionsTeamsId = 20, PlayerId = 8, GoalsTotal = 0, IsVerified = true, IsDeleted = false, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00") },
			new CompetitionsTeamsPlayer { Id = 109, CompetitionsTeamsId = 20, PlayerId = 9, GoalsTotal = 0, IsVerified = true, IsDeleted = false, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00") },
			new CompetitionsTeamsPlayer { Id = 110, CompetitionsTeamsId = 20, PlayerId = 10, GoalsTotal = 0, IsVerified = true, IsDeleted = false, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00") },
			new CompetitionsTeamsPlayer { Id = 111, CompetitionsTeamsId = 20, PlayerId = 11, GoalsTotal = 0, IsVerified = true, IsDeleted = false, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00") },
			new CompetitionsTeamsPlayer { Id = 112, CompetitionsTeamsId = 20, PlayerId = 12, GoalsTotal = 0, IsVerified = true, IsDeleted = false, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00") },
			new CompetitionsTeamsPlayer { Id = 113, CompetitionsTeamsId = 20, PlayerId = 13, GoalsTotal = 0, IsVerified = true, IsDeleted = false, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00") },
			new CompetitionsTeamsPlayer { Id = 114, CompetitionsTeamsId = 20, PlayerId = 14, GoalsTotal = 0, IsVerified = true, IsDeleted = false, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00") },

			// Competition 5 — Team 26 (6 players)
			new CompetitionsTeamsPlayer { Id = 115, CompetitionsTeamsId = 26, PlayerId = 15, GoalsTotal = 0, IsVerified = true, IsDeleted = false, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00") },
			new CompetitionsTeamsPlayer { Id = 116, CompetitionsTeamsId = 26, PlayerId = 16, GoalsTotal = 0, IsVerified = true, IsDeleted = false, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00") },
			new CompetitionsTeamsPlayer { Id = 117, CompetitionsTeamsId = 26, PlayerId = 17, GoalsTotal = 0, IsVerified = true, IsDeleted = false, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00") },
			new CompetitionsTeamsPlayer { Id = 118, CompetitionsTeamsId = 26, PlayerId = 18, GoalsTotal = 0, IsVerified = true, IsDeleted = false, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00") },
			new CompetitionsTeamsPlayer { Id = 119, CompetitionsTeamsId = 26, PlayerId = 19, GoalsTotal = 0, IsVerified = true, IsDeleted = false, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00") },
			new CompetitionsTeamsPlayer { Id = 120, CompetitionsTeamsId = 26, PlayerId = 20, GoalsTotal = 0, IsVerified = true, IsDeleted = false, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00") },

			// Competition 5 — Team 27 (5 players)
			new CompetitionsTeamsPlayer { Id = 121, CompetitionsTeamsId = 27, PlayerId = 21, GoalsTotal = 0, IsVerified = true, IsDeleted = false, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00") },
			new CompetitionsTeamsPlayer { Id = 122, CompetitionsTeamsId = 27, PlayerId = 22, GoalsTotal = 0, IsVerified = true, IsDeleted = false, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00") },
			new CompetitionsTeamsPlayer { Id = 123, CompetitionsTeamsId = 27, PlayerId = 23, GoalsTotal = 0, IsVerified = true, IsDeleted = false, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00") },
			new CompetitionsTeamsPlayer { Id = 124, CompetitionsTeamsId = 27, PlayerId = 24, GoalsTotal = 0, IsVerified = true, IsDeleted = false, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00") },
			new CompetitionsTeamsPlayer { Id = 125, CompetitionsTeamsId = 27, PlayerId = 25, GoalsTotal = 0, IsVerified = true, IsDeleted = false, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00") },

			// Competition 5 — Team 28 (7 players)
			new CompetitionsTeamsPlayer { Id = 126, CompetitionsTeamsId = 28, PlayerId = 26, GoalsTotal = 0, IsVerified = true, IsDeleted = false, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00") },
			new CompetitionsTeamsPlayer { Id = 127, CompetitionsTeamsId = 28, PlayerId = 27, GoalsTotal = 0, IsVerified = true, IsDeleted = false, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00") },
			new CompetitionsTeamsPlayer { Id = 128, CompetitionsTeamsId = 28, PlayerId = 28, GoalsTotal = 0, IsVerified = true, IsDeleted = false, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00") },
			new CompetitionsTeamsPlayer { Id = 129, CompetitionsTeamsId = 28, PlayerId = 29, GoalsTotal = 0, IsVerified = true, IsDeleted = false, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00") },
			new CompetitionsTeamsPlayer { Id = 130, CompetitionsTeamsId = 28, PlayerId = 30, GoalsTotal = 0, IsVerified = true, IsDeleted = false, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00") },
			new CompetitionsTeamsPlayer { Id = 131, CompetitionsTeamsId = 28, PlayerId = 31, GoalsTotal = 0, IsVerified = true, IsDeleted = false, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00") },
			new CompetitionsTeamsPlayer { Id = 132, CompetitionsTeamsId = 28, PlayerId = 32, GoalsTotal = 0, IsVerified = true, IsDeleted = false, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00") },

			// Competition 5 — Team 29 (6 players)
			new CompetitionsTeamsPlayer { Id = 133, CompetitionsTeamsId = 29, PlayerId = 33, GoalsTotal = 0, IsVerified = true, IsDeleted = false, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00") },
			new CompetitionsTeamsPlayer { Id = 134, CompetitionsTeamsId = 29, PlayerId = 34, GoalsTotal = 0, IsVerified = true, IsDeleted = false, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00") },
			new CompetitionsTeamsPlayer { Id = 135, CompetitionsTeamsId = 29, PlayerId = 35, GoalsTotal = 0, IsVerified = true, IsDeleted = false, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00") },
			new CompetitionsTeamsPlayer { Id = 136, CompetitionsTeamsId = 29, PlayerId = 36, GoalsTotal = 0, IsVerified = true, IsDeleted = false, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00") },
			new CompetitionsTeamsPlayer { Id = 137, CompetitionsTeamsId = 29, PlayerId = 37, GoalsTotal = 0, IsVerified = true, IsDeleted = false, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00") },
			new CompetitionsTeamsPlayer { Id = 138, CompetitionsTeamsId = 29, PlayerId = 38, GoalsTotal = 0, IsVerified = true, IsDeleted = false, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00") },

			// Competition 5 — Team 30 (5 players)
			new CompetitionsTeamsPlayer { Id = 139, CompetitionsTeamsId = 30, PlayerId = 39, GoalsTotal = 0, IsVerified = true, IsDeleted = false, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00") },
			new CompetitionsTeamsPlayer { Id = 140, CompetitionsTeamsId = 30, PlayerId = 40, GoalsTotal = 0, IsVerified = true, IsDeleted = false, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00") },
			new CompetitionsTeamsPlayer { Id = 141, CompetitionsTeamsId = 30, PlayerId = 41, GoalsTotal = 0, IsVerified = true, IsDeleted = false, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00") },
			new CompetitionsTeamsPlayer { Id = 142, CompetitionsTeamsId = 30, PlayerId = 42, GoalsTotal = 0, IsVerified = true, IsDeleted = false, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00") },
			new CompetitionsTeamsPlayer { Id = 143, CompetitionsTeamsId = 30, PlayerId = 43, GoalsTotal = 0, IsVerified = true, IsDeleted = false, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00") },

			// Competition 5 — Team 31 (6 players)
			new CompetitionsTeamsPlayer { Id = 144, CompetitionsTeamsId = 31, PlayerId = 44, GoalsTotal = 0, IsVerified = true, IsDeleted = false, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00") },
			new CompetitionsTeamsPlayer { Id = 145, CompetitionsTeamsId = 31, PlayerId = 45, GoalsTotal = 0, IsVerified = true, IsDeleted = false, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00") },
			new CompetitionsTeamsPlayer { Id = 146, CompetitionsTeamsId = 31, PlayerId = 46, GoalsTotal = 0, IsVerified = true, IsDeleted = false, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00") },
			new CompetitionsTeamsPlayer { Id = 147, CompetitionsTeamsId = 31, PlayerId = 47, GoalsTotal = 0, IsVerified = true, IsDeleted = false, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00") },
			new CompetitionsTeamsPlayer { Id = 148, CompetitionsTeamsId = 31, PlayerId = 48, GoalsTotal = 0, IsVerified = true, IsDeleted = false, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00") },
			new CompetitionsTeamsPlayer { Id = 149, CompetitionsTeamsId = 31, PlayerId = 49, GoalsTotal = 0, IsVerified = true, IsDeleted = false, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00") },

			// Competition 5 — Team 32 (5 players)
			new CompetitionsTeamsPlayer { Id = 150, CompetitionsTeamsId = 32, PlayerId = 50, GoalsTotal = 0, IsVerified = true, IsDeleted = false, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00") },
			new CompetitionsTeamsPlayer { Id = 151, CompetitionsTeamsId = 32, PlayerId = 51, GoalsTotal = 0, IsVerified = true, IsDeleted = false, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00") },
			new CompetitionsTeamsPlayer { Id = 152, CompetitionsTeamsId = 32, PlayerId = 52, GoalsTotal = 0, IsVerified = true, IsDeleted = false, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00") },
			new CompetitionsTeamsPlayer { Id = 153, CompetitionsTeamsId = 32, PlayerId = 53, GoalsTotal = 0, IsVerified = true, IsDeleted = false, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00") },
			new CompetitionsTeamsPlayer { Id = 154, CompetitionsTeamsId = 32, PlayerId = 54, GoalsTotal = 0, IsVerified = true, IsDeleted = false, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00") },

			// Competition 5 — Team 33 (7 players)
			new CompetitionsTeamsPlayer { Id = 155, CompetitionsTeamsId = 33, PlayerId = 55, GoalsTotal = 0, IsVerified = true, IsDeleted = false, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00") },
			new CompetitionsTeamsPlayer { Id = 156, CompetitionsTeamsId = 33, PlayerId = 56, GoalsTotal = 0, IsVerified = true, IsDeleted = false, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00") },
			new CompetitionsTeamsPlayer { Id = 157, CompetitionsTeamsId = 33, PlayerId = 57, GoalsTotal = 0, IsVerified = true, IsDeleted = false, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00") },
			new CompetitionsTeamsPlayer { Id = 158, CompetitionsTeamsId = 33, PlayerId = 58, GoalsTotal = 0, IsVerified = true, IsDeleted = false, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00") },
			new CompetitionsTeamsPlayer { Id = 159, CompetitionsTeamsId = 33, PlayerId = 59, GoalsTotal = 0, IsVerified = true, IsDeleted = false, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00") },
			new CompetitionsTeamsPlayer { Id = 160, CompetitionsTeamsId = 33, PlayerId = 60, GoalsTotal = 0, IsVerified = true, IsDeleted = false, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00") },
			new CompetitionsTeamsPlayer { Id = 161, CompetitionsTeamsId = 33, PlayerId = 61, GoalsTotal = 0, IsVerified = true, IsDeleted = false, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00") }
		);

		modelBuilder.Entity<Database.FavoriteCompetition>().HasData(
			new FavoriteCompetition() { Id = 1, UserId = 4, CompetitionId = 1, IsDeleted = false, RemovedAt = null, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00").AddDays(-5), ModifiedAt = null },
			new FavoriteCompetition() { Id = 2, UserId = 4, CompetitionId = 2, IsDeleted = false, RemovedAt = null, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00").AddDays(-5), ModifiedAt = null },
			new FavoriteCompetition() { Id = 3, UserId = 5, CompetitionId = 3, IsDeleted = false, RemovedAt = null, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00").AddDays(-5), ModifiedAt = null },
			new FavoriteCompetition() { Id = 4, UserId = 6, CompetitionId = 5, IsDeleted = false, RemovedAt = null, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00").AddDays(-5), ModifiedAt = null }

		);
		modelBuilder.Entity<Database.Fixture>().HasData(
			// Competition 2 — 1 fixture, group stage, not completed, not active, 15 mins
			new Fixture { Id = 1, CompetitionId = 2, SequenceNumber = 0, MatchLength = 15, GameStage = GameStage.GroupPhase, IsCurrentlyActive = false, IsCompleted = false, IsDeleted = false, RemovedAt = null, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00") },

			// Competition 5 — 3 fixtures, all completed, match length 20 mins
			new Fixture { Id = 2, CompetitionId = 5, SequenceNumber = 0, MatchLength = 20, GameStage = GameStage.QuarterFinals, IsCurrentlyActive = false, IsCompleted = true, IsDeleted = false, RemovedAt = null, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00") },
			new Fixture { Id = 3, CompetitionId = 5, SequenceNumber = 0, MatchLength = 20, GameStage = GameStage.SemiFinals, IsCurrentlyActive = false, IsCompleted = true, IsDeleted = false, RemovedAt = null, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00") },
			new Fixture { Id = 4, CompetitionId = 5, SequenceNumber = 0, MatchLength = 20, GameStage = GameStage.Finals, IsCurrentlyActive = false, IsCompleted = true, IsDeleted = false, RemovedAt = null, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00") }
		);
		modelBuilder.Entity<Database.Goal>().HasData(
		// Match 3 — Quarterfinal 1 (Team 26 vs Team 27)
		new Goal { Id = 1, MatchId = 3, CompetitionTeamPlayerId = 115, SequenceNumber = 1, ScoredAtMinute = 2, IsHomeGoal = true, IsDeleted = false, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00") },
		new Goal { Id = 2, MatchId = 3, CompetitionTeamPlayerId = 116, SequenceNumber = 2, ScoredAtMinute = 7, IsHomeGoal = true, IsDeleted = false, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00") },
		new Goal { Id = 3, MatchId = 3, CompetitionTeamPlayerId = 117, SequenceNumber = 3, ScoredAtMinute = 12, IsHomeGoal = true, IsDeleted = false, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00") },
		new Goal { Id = 4, MatchId = 3, CompetitionTeamPlayerId = 121, SequenceNumber = 4, ScoredAtMinute = 15, IsHomeGoal = false, IsDeleted = false, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00") },

		// Match 4 — Quarterfinal 2 (Team 28 vs Team 29)
		new Goal { Id = 5, MatchId = 4, CompetitionTeamPlayerId = 126, SequenceNumber = 1, ScoredAtMinute = 1, IsHomeGoal = true, IsDeleted = false, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00") },
		new Goal { Id = 6, MatchId = 4, CompetitionTeamPlayerId = 127, SequenceNumber = 2, ScoredAtMinute = 6, IsHomeGoal = true, IsDeleted = false, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00") },
		new Goal { Id = 7, MatchId = 4, CompetitionTeamPlayerId = 128, SequenceNumber = 3, ScoredAtMinute = 11, IsHomeGoal = true, IsDeleted = false, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00") },
		new Goal { Id = 8, MatchId = 4, CompetitionTeamPlayerId = 133, SequenceNumber = 4, ScoredAtMinute = 17, IsHomeGoal = false, IsDeleted = false, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00") },

		// Match 5 — Quarterfinal 3 (Team 30 vs Team 31)
		new Goal { Id = 9, MatchId = 5, CompetitionTeamPlayerId = 139, SequenceNumber = 1, ScoredAtMinute = 3, IsHomeGoal = true, IsDeleted = false, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00") },
		new Goal { Id = 10, MatchId = 5, CompetitionTeamPlayerId = 140, SequenceNumber = 2, ScoredAtMinute = 8, IsHomeGoal = true, IsDeleted = false, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00") },
		new Goal { Id = 11, MatchId = 5, CompetitionTeamPlayerId = 144, SequenceNumber = 3, ScoredAtMinute = 14, IsHomeGoal = false, IsDeleted = false, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00") },

		// Match 6 — Quarterfinal 4 (Team 32 vs Team 33)
		new Goal { Id = 12, MatchId = 6, CompetitionTeamPlayerId = 150, SequenceNumber = 1, ScoredAtMinute = 2, IsHomeGoal = true, IsDeleted = false, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00") },
		new Goal { Id = 13, MatchId = 6, CompetitionTeamPlayerId = 151, SequenceNumber = 2, ScoredAtMinute = 9, IsHomeGoal = true, IsDeleted = false, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00") },
		new Goal { Id = 14, MatchId = 6, CompetitionTeamPlayerId = 155, SequenceNumber = 3, ScoredAtMinute = 16, IsHomeGoal = false, IsDeleted = false, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00") },

		// Match 7 — SemiFinal 1 (Winner Match3: Team26 vs Winner Match4: Team28)
		new Goal { Id = 15, MatchId = 7, CompetitionTeamPlayerId = 115, SequenceNumber = 1, ScoredAtMinute = 4, IsHomeGoal = true, IsDeleted = false, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00") },
		new Goal { Id = 16, MatchId = 7, CompetitionTeamPlayerId = 115, SequenceNumber = 2, ScoredAtMinute = 10, IsHomeGoal = true, IsDeleted = false, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00") },

		// Match 8 — SemiFinal 2 (Winner Match5: Team30 vs Winner Match6: Team32)
		new Goal { Id = 17, MatchId = 8, CompetitionTeamPlayerId = 139, SequenceNumber = 1, ScoredAtMinute = 5, IsHomeGoal = true, IsDeleted = false, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00") },
		new Goal { Id = 18, MatchId = 8, CompetitionTeamPlayerId = 139, SequenceNumber = 2, ScoredAtMinute = 12, IsHomeGoal = true, IsDeleted = false, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00") },

		// Match 9 — Final (Winner Match7: Team26 vs Winner Match8: Team30)
		new Goal { Id = 19, MatchId = 9, CompetitionTeamPlayerId = 115, SequenceNumber = 1, ScoredAtMinute = 3, IsHomeGoal = true, IsDeleted = false, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00") },
		new Goal { Id = 20, MatchId = 9, CompetitionTeamPlayerId = 115, SequenceNumber = 2, ScoredAtMinute = 15, IsHomeGoal = true, IsDeleted = false, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00") }
	);


		modelBuilder.Entity<Database.Group>().HasData(
			new Group { Id = 1, CompetitionId = 1, Name = "Zimska Liga Sarajevo", IsDeleted = false, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00"), RemovedAt = null, ModifiedAt = null },
			new Group { Id = 2, CompetitionId = 2, Name = "Group A", IsDeleted = false, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00"), RemovedAt = null, ModifiedAt = null },
			new Group { Id = 3, CompetitionId = 2, Name = "Group B", IsDeleted = false, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00"), RemovedAt = null, ModifiedAt = null },
			new Group { Id = 4, CompetitionId = 2, Name = "Group C", IsDeleted = false, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00"), RemovedAt = null, ModifiedAt = null },
			new Group { Id = 5, CompetitionId = 2, Name = "Group D", IsDeleted = false, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00"), RemovedAt = null, ModifiedAt = null }

		);
		modelBuilder.Entity<Database.Match>().HasData(
			new Match
			{
				Id = 1,
				FixtureId = 1,
				HomeTeamId = 1,
				AwayTeamId = 2,
				StadiumId = 1,
				WinnerId = 1,
				DateAndTime = DateTime.Parse("2025-10-10 20:30:00"),
				IsCompleted = false,
				IsCompletedInRegullarTime = true,
				IsCurrentlyActive = false,
				IsDeleted = false,
				IsUnderway = false,
				IsActive = true,
				CreatedAt = DateTime.Parse("2025-10-04 14:30:00")
			},
			new Match
			{
				Id = 2,
				FixtureId = 1,
				HomeTeamId = 3,
				AwayTeamId = 4,
				StadiumId = 2,
				WinnerId = 3,
				DateAndTime = DateTime.Parse("2025-10-10 21:30:00"),
				IsCompleted = false,
				IsCompletedInRegullarTime = true,
				IsCurrentlyActive = false,
				IsDeleted = false,
				IsUnderway = false,
				IsActive = true,
				CreatedAt = DateTime.Parse("2025-10-04 14:30:00")
			},

			// Quarterfinals
			new Match
			{
				Id = 3,
				FixtureId = 2,
				HomeTeamId = 26,
				AwayTeamId = 27,
				StadiumId = 1,
				WinnerId = 26,
				DateAndTime = DateTime.Parse("2025-8-12 20:30:00"),
				IsCompleted = true,
				IsCompletedInRegullarTime = true,
				IsCurrentlyActive = false,
				IsDeleted = false,
				IsUnderway = false,
				IsActive = true,
				CreatedAt = DateTime.Parse("2025-10-04 14:30:00")
			},
			new Match
			{
				Id = 4,
				FixtureId = 2,
				HomeTeamId = 28,
				AwayTeamId = 29,
				StadiumId = 2,
				WinnerId = 28,
				DateAndTime = DateTime.Parse("2025-8-12 21:30:00"),
				IsCompleted = true,
				IsCompletedInRegullarTime = true,
				IsCurrentlyActive = false,
				IsDeleted = false,
				IsUnderway = false,
				IsActive = true,
				CreatedAt = DateTime.Parse("2025-10-04 14:30:00")
			},
			new Match
			{
				Id = 5,
				FixtureId = 2,
				HomeTeamId = 30,
				AwayTeamId = 31,
				StadiumId = 3,
				WinnerId = 30,
				DateAndTime = DateTime.Parse("2025-8-13 20:30:00"),
				IsCompleted = true,
				IsCompletedInRegullarTime = true,
				IsCurrentlyActive = false,
				IsDeleted = false,
				IsUnderway = false,
				IsActive = true,
				CreatedAt = DateTime.Parse("2025-10-04 14:30:00")
			},
			new Match
			{
				Id = 6,
				FixtureId = 2,
				HomeTeamId = 32,
				AwayTeamId = 33,
				StadiumId = 4,
				WinnerId = 32,
				DateAndTime = DateTime.Parse("2025-8-13 20:30:00"),
				IsCompleted = true,
				IsCompletedInRegullarTime = true,
				IsCurrentlyActive = false,
				IsDeleted = false,
				IsUnderway = false,
				IsActive = true,
				CreatedAt = DateTime.Parse("2025-10-04 14:30:00")
			},
			// Semifinals
			new Match
			{
				Id = 7,
				FixtureId = 3,
				HomeTeamId = 26,
				AwayTeamId = 28,
				StadiumId = 1,
				WinnerId = 26,
				DateAndTime = DateTime.Parse("2025-8-13 20:30:00"),
				IsCompleted = true,
				IsCompletedInRegullarTime = true,
				IsCurrentlyActive = false,
				IsDeleted = false,
				IsUnderway = false,
				IsActive = true,
				CreatedAt = DateTime.Parse("2025-10-04 14:30:00")
			},
			new Match
			{
				Id = 8,
				FixtureId = 3,
				HomeTeamId = 30,
				AwayTeamId = 32,
				StadiumId = 2,
				WinnerId = 30,
				DateAndTime = DateTime.Parse("2025-8-13 20:30:00"),
				IsCompleted = true,
				IsCompletedInRegullarTime = true,
				IsCurrentlyActive = false,
				IsDeleted = false,
				IsUnderway = false,
				IsActive = true,
				CreatedAt = DateTime.Parse("2025-10-04 14:30:00")
			},
			// Final
			new Match
			{
				Id = 9,
				FixtureId = 4,
				HomeTeamId = 26,
				AwayTeamId = 30,
				StadiumId = 1,
				WinnerId = 26,
				DateAndTime = DateTime.Parse("2025-8-13 20:30:00"),
				IsCompleted = true,
				IsCompletedInRegullarTime = true,
				IsCurrentlyActive = false,
				IsDeleted = false,
				IsUnderway = false,
				IsActive = true,
				CreatedAt = DateTime.Parse("2025-10-04 14:30:00")
			}
		);
		modelBuilder.Entity<Player>().HasData(
	        new Player { Id = 1, FirstName = "Amir", LastName = "Hadžić", Picture = null, BirthDate = new DateTime(1979, 5, 12), IsDeleted = false, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00") },
	        new Player { Id = 2, FirstName = "Senad", LastName = "Suljić", Picture = null, BirthDate = new DateTime(1981, 2, 28), IsDeleted = false, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00") },
	        new Player { Id = 3, FirstName = "Nermin", LastName = "Delić", Picture = null, BirthDate = new DateTime(1983, 8, 3), IsDeleted = false, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00") },
	        new Player { Id = 4, FirstName = "Samir", LastName = "Hodžić", Picture = null, BirthDate = new DateTime(1976, 11, 17), IsDeleted = false, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00") },
	        new Player { Id = 5, FirstName = "Almir", LastName = "Mujić", Picture = null, BirthDate = new DateTime(1982, 4, 9), IsDeleted = false, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00") },
	        new Player { Id = 6, FirstName = "Mirsad", LastName = "Karić", Picture = null, BirthDate = new DateTime(1978, 1, 30), IsDeleted = false, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00") },
	        new Player { Id = 7, FirstName = "Ismet", LastName = "Begović", Picture = null, BirthDate = new DateTime(1974, 10, 25), IsDeleted = false, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00") },
	        new Player { Id = 8, FirstName = "Sanel", LastName = "Osmanović", Picture = null, BirthDate = new DateTime(1984, 6, 19), IsDeleted = false, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00") },
	        new Player { Id = 9, FirstName = "Zlatan", LastName = "Džafić", Picture = null, BirthDate = new DateTime(1980, 7, 11), IsDeleted = false, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00") },
	        new Player { Id = 10, FirstName = "Faruk", LastName = "Halilović", Picture = null, BirthDate = new DateTime(1975, 3, 8), IsDeleted = false, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00") },
	        new Player { Id = 11, FirstName = "Jasmin", LastName = "Bajrić", Picture = null, BirthDate = new DateTime(1985, 12, 21), IsDeleted = false, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00") },
	        new Player { Id = 12, FirstName = "Mirza", LastName = "Bešić", Picture = null, BirthDate = new DateTime(1977, 5, 10), IsDeleted = false, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00") },
	        new Player { Id = 13, FirstName = "Enes", LastName = "Alihodžić", Picture = null, BirthDate = new DateTime(1983, 2, 17), IsDeleted = false, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00") },
	        new Player { Id = 14, FirstName = "Haris", LastName = "Smajić", Picture = null, BirthDate = new DateTime(1980, 6, 23), IsDeleted = false, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00") },
	        new Player { Id = 15, FirstName = "Adnan", LastName = "Šabanović", Picture = null, BirthDate = new DateTime(1979, 9, 29), IsDeleted = false, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00") },
	        new Player { Id = 16, FirstName = "Dino", LastName = "Kurtović", Picture = null, BirthDate = new DateTime(1982, 11, 2), IsDeleted = false, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00") },
	        new Player { Id = 17, FirstName = "Elvir", LastName = "Hasić", Picture = null, BirthDate = new DateTime(1984, 4, 4), IsDeleted = false, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00") },
	        new Player { Id = 18, FirstName = "Sabahudin", LastName = "Mehić", Picture = null, BirthDate = new DateTime(1976, 12, 13), IsDeleted = false, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00") },
	        new Player { Id = 19, FirstName = "Armin", LastName = "Mustafić", Picture = null, BirthDate = new DateTime(1978, 8, 15), IsDeleted = false, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00") },
	        new Player { Id = 20, FirstName = "Ermin", LastName = "Hadžiomerović", Picture = null, BirthDate = new DateTime(1983, 1, 27), IsDeleted = false, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00") },

	        // Under 21
	        new Player { Id = 21, FirstName = "Tarik", LastName = "Zukić", Picture = null, BirthDate = new DateTime(2006, 3, 14), IsDeleted = false, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00") },
	        new Player { Id = 22, FirstName = "Kenan", LastName = "Musić", Picture = null, BirthDate = new DateTime(2005, 7, 9), IsDeleted = false, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00") },
	        new Player { Id = 23, FirstName = "Emin", LastName = "Alić", Picture = null, BirthDate = new DateTime(2007, 11, 30), IsDeleted = false, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00") },
	        new Player { Id = 24, FirstName = "Ajdin", LastName = "Hasić", Picture = null, BirthDate = new DateTime(2004, 5, 3), IsDeleted = false, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00") },
	        new Player { Id = 25, FirstName = "Arman", LastName = "Hadžović", Picture = null, BirthDate = new DateTime(2006, 1, 12), IsDeleted = false, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00") },
	        new Player { Id = 26, FirstName = "Ismail", LastName = "Topić", Picture = null, BirthDate = new DateTime(2008, 4, 6), IsDeleted = false, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00") },
	        new Player { Id = 27, FirstName = "Edin", LastName = "Memić", Picture = null, BirthDate = new DateTime(2005, 9, 17), IsDeleted = false, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00") },
	        new Player { Id = 28, FirstName = "Faris", LastName = "Omerović", Picture = null, BirthDate = new DateTime(2007, 12, 22), IsDeleted = false, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00") },
	        new Player { Id = 29, FirstName = "Nedim", LastName = "Zulić", Picture = null, BirthDate = new DateTime(2006, 8, 10), IsDeleted = false, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00") },
	        new Player { Id = 30, FirstName = "Haris", LastName = "Mušanović", Picture = null, BirthDate = new DateTime(2005, 2, 8), IsDeleted = false, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00") },
	        new Player { Id = 31, FirstName = "Omar", LastName = "Beglerović", Picture = null, BirthDate = new DateTime(2008, 7, 19), IsDeleted = false, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00") },
	        new Player { Id = 32, FirstName = "Amar", LastName = "Delić", Picture = null, BirthDate = new DateTime(2007, 9, 5), IsDeleted = false, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00") },
	        new Player { Id = 33, FirstName = "Emir", LastName = "Kozlica", Picture = null, BirthDate = new DateTime(2006, 3, 21), IsDeleted = false, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00") },
	        new Player { Id = 34, FirstName = "Adin", LastName = "Šehić", Picture = null, BirthDate = new DateTime(2004, 11, 13), IsDeleted = false, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00") },
	        new Player { Id = 35, FirstName = "Riad", LastName = "Karić", Picture = null, BirthDate = new DateTime(2007, 5, 28), IsDeleted = false, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00") },
	        new Player { Id = 36, FirstName = "Benjamin", LastName = "Hasanović", Picture = null, BirthDate = new DateTime(2005, 6, 30), IsDeleted = false, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00") },
	        new Player { Id = 37, FirstName = "Eldar", LastName = "Bećirović", Picture = null, BirthDate = new DateTime(2006, 9, 9), IsDeleted = false, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00") },
	        new Player { Id = 38, FirstName = "Tarik", LastName = "Selimović", Picture = null, BirthDate = new DateTime(2008, 10, 18), IsDeleted = false, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00") },
	        new Player { Id = 39, FirstName = "Arnel", LastName = "Muratović", Picture = null, BirthDate = new DateTime(2004, 12, 3), IsDeleted = false, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00") },
	        new Player { Id = 40, FirstName = "Kenan", LastName = "Bešlagić", Picture = null, BirthDate = new DateTime(2007, 1, 25), IsDeleted = false, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00") },

	        // Ages 21–40 (60 players)
	        new Player { Id = 41, FirstName = "Haris", LastName = "Kovačević", Picture = null, BirthDate = new DateTime(1993, 5, 12), IsDeleted = false, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00") },
	        new Player { Id = 42, FirstName = "Dino", LastName = "Babić", Picture = null, BirthDate = new DateTime(1997, 9, 2), IsDeleted = false, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00") },
	        new Player { Id = 43, FirstName = "Alen", LastName = "Mujić", Picture = null, BirthDate = new DateTime(1999, 3, 20), IsDeleted = false, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00") },
	        new Player { Id = 44, FirstName = "Adis", LastName = "Halilović", Picture = null, BirthDate = new DateTime(1990, 1, 9), IsDeleted = false, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00") },
	        new Player { Id = 45, FirstName = "Nedžad", LastName = "Kapić", Picture = null, BirthDate = new DateTime(1995, 11, 15), IsDeleted = false, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00") },
	        new Player { Id = 46, FirstName = "Mirza", LastName = "Begović", Picture = null, BirthDate = new DateTime(1998, 2, 22), IsDeleted = false, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00") },
	        new Player { Id = 47, FirstName = "Elvis", LastName = "Mehić", Picture = null, BirthDate = new DateTime(1992, 7, 3), IsDeleted = false, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00") },
	        new Player { Id = 48, FirstName = "Adnan", LastName = "Salihović", Picture = null, BirthDate = new DateTime(1990, 10, 14), IsDeleted = false, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00") },
	        new Player { Id = 49, FirstName = "Amar", LastName = "Ćosić", Picture = null, BirthDate = new DateTime(1996, 9, 9), IsDeleted = false, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00") },
	        new Player { Id = 50, FirstName = "Faruk", LastName = "Hadžialić", Picture = null, BirthDate = new DateTime(1994, 6, 1), IsDeleted = false, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00") },
			new Player { Id = 51, FirstName = "Emir", LastName = "Alić", Picture = null, BirthDate = new DateTime(1991, 3, 27), IsDeleted = false, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00") },
	        new Player { Id = 52, FirstName = "Jasmin", LastName = "Suljić", Picture = null, BirthDate = new DateTime(1999, 7, 19), IsDeleted = false, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00") },
	        new Player { Id = 53, FirstName = "Almir", LastName = "Husić", Picture = null, BirthDate = new DateTime(1993, 8, 8), IsDeleted = false, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00") },
	        new Player { Id = 54, FirstName = "Eldin", LastName = "Zulić", Picture = null, BirthDate = new DateTime(1998, 10, 2), IsDeleted = false, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00") },
	        new Player { Id = 55, FirstName = "Armin", LastName = "Bajrić", Picture = null, BirthDate = new DateTime(1990, 12, 15), IsDeleted = false, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00") },
	        new Player { Id = 56, FirstName = "Edin", LastName = "Karić", Picture = null, BirthDate = new DateTime(1995, 1, 11), IsDeleted = false, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00") },
	        new Player { Id = 57, FirstName = "Nermin", LastName = "Smajlović", Picture = null, BirthDate = new DateTime(1992, 4, 22), IsDeleted = false, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00") },
	        new Player { Id = 58, FirstName = "Dženan", LastName = "Hadžiabdić", Picture = null, BirthDate = new DateTime(1993, 11, 30), IsDeleted = false, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00") },
	        new Player { Id = 59, FirstName = "Saša", LastName = "Kovačević", Picture = null, BirthDate = new DateTime(1989, 9, 17), IsDeleted = false, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00") },
	        new Player { Id = 60, FirstName = "Arnel", LastName = "Subašić", Picture = null, BirthDate = new DateTime(1994, 5, 9), IsDeleted = false, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00") },
	        new Player { Id = 61, FirstName = "Selmir", LastName = "Bešić", Picture = null, BirthDate = new DateTime(1997, 2, 4), IsDeleted = false, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00") },
	        new Player { Id = 62, FirstName = "Tarik", LastName = "Hadžiselimović", Picture = null, BirthDate = new DateTime(1996, 6, 21), IsDeleted = false, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00") },
	        new Player { Id = 63, FirstName = "Kenan", LastName = "Karišik", Picture = null, BirthDate = new DateTime(1999, 9, 12), IsDeleted = false, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00") },
	        new Player { Id = 64, FirstName = "Edis", LastName = "Ramić", Picture = null, BirthDate = new DateTime(1993, 7, 18), IsDeleted = false, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00") },
	        new Player { Id = 65, FirstName = "Dževad", LastName = "Ćosić", Picture = null, BirthDate = new DateTime(1991, 3, 30), IsDeleted = false, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00") },
	        new Player { Id = 66, FirstName = "Adis", LastName = "Šehić", Picture = null, BirthDate = new DateTime(1994, 8, 14), IsDeleted = false, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00") },
	        new Player { Id = 67, FirstName = "Eldar", LastName = "Omeragić", Picture = null, BirthDate = new DateTime(1992, 10, 19), IsDeleted = false, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00") },
	        new Player { Id = 68, FirstName = "Armin", LastName = "Begić", Picture = null, BirthDate = new DateTime(1998, 1, 26), IsDeleted = false, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00") },
	        new Player { Id = 69, FirstName = "Amar", LastName = "Hodžić", Picture = null, BirthDate = new DateTime(1996, 12, 7), IsDeleted = false, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00") },
	        new Player { Id = 70, FirstName = "Benjamin", LastName = "Delić", Picture = null, BirthDate = new DateTime(1990, 11, 25), IsDeleted = false, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00") },
	        new Player { Id = 71, FirstName = "Elmin", LastName = "Šabanović", Picture = null, BirthDate = new DateTime(1995, 5, 5), IsDeleted = false, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00") },
	        new Player { Id = 72, FirstName = "Tarik", LastName = "Hasanović", Picture = null, BirthDate = new DateTime(1992, 3, 10), IsDeleted = false, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00") },
	        new Player { Id = 73, FirstName = "Haris", LastName = "Mešić", Picture = null, BirthDate = new DateTime(1991, 1, 29), IsDeleted = false, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00") },
	        new Player { Id = 74, FirstName = "Selver", LastName = "Kurtović", Picture = null, BirthDate = new DateTime(1994, 7, 16), IsDeleted = false, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00") },
	        new Player { Id = 75, FirstName = "Adnan", LastName = "Bećiragić", Picture = null, BirthDate = new DateTime(1998, 4, 23), IsDeleted = false, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00") },
	        new Player { Id = 76, FirstName = "Edin", LastName = "Selimović", Picture = null, BirthDate = new DateTime(1990, 9, 28), IsDeleted = false, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00") },
	        new Player { Id = 77, FirstName = "Nedim", LastName = "Hadžihasanović", Picture = null, BirthDate = new DateTime(1996, 5, 2), IsDeleted = false, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00") },
	        new Player { Id = 78, FirstName = "Alen", LastName = "Ćehajić", Picture = null, BirthDate = new DateTime(1993, 8, 11), IsDeleted = false, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00") },
	        new Player { Id = 79, FirstName = "Haris", LastName = "Beširović", Picture = null, BirthDate = new DateTime(1992, 2, 20), IsDeleted = false, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00") },
	        new Player { Id = 80, FirstName = "Eldin", LastName = "Muratović", Picture = null, BirthDate = new DateTime(1995, 12, 4), IsDeleted = false, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00") },
	        new Player { Id = 81, FirstName = "Emin", LastName = "Mujanović", Picture = null, BirthDate = new DateTime(1999, 3, 9), IsDeleted = false, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00") },
	        new Player { Id = 82, FirstName = "Dino", LastName = "Avdić", Picture = null, BirthDate = new DateTime(1993, 10, 27), IsDeleted = false, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00") },
	        new Player { Id = 83, FirstName = "Sanel", LastName = "Hadžibegić", Picture = null, BirthDate = new DateTime(1997, 11, 30), IsDeleted = false, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00") },
	        new Player { Id = 84, FirstName = "Kenan", LastName = "Mušanović", Picture = null, BirthDate = new DateTime(1996, 1, 19), IsDeleted = false, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00") },
	        new Player { Id = 85, FirstName = "Aldin", LastName = "Smajlović", Picture = null, BirthDate = new DateTime(1994, 4, 1), IsDeleted = false, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00") },
	        new Player { Id = 86, FirstName = "Adis", LastName = "Burić", Picture = null, BirthDate = new DateTime(1998, 9, 22), IsDeleted = false, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00") },
	        new Player { Id = 87, FirstName = "Faris", LastName = "Karić", Picture = null, BirthDate = new DateTime(1995, 6, 13), IsDeleted = false, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00") },
	        new Player { Id = 88, FirstName = "Emir", LastName = "Hasić", Picture = null, BirthDate = new DateTime(1991, 10, 9), IsDeleted = false, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00") },
	        new Player { Id = 89, FirstName = "Jasmin", LastName = "Bečić", Picture = null, BirthDate = new DateTime(1997, 12, 15), IsDeleted = false, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00") },
	        new Player { Id = 90, FirstName = "Ermin", LastName = "Alihodžić", Picture = null, BirthDate = new DateTime(1994, 8, 7), IsDeleted = false, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00") },
	        new Player { Id = 91, FirstName = "Mirza", LastName = "Šabanagić", Picture = null, BirthDate = new DateTime(1993, 9, 1), IsDeleted = false, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00") },
	        new Player { Id = 92, FirstName = "Edis", LastName = "Mujić", Picture = null, BirthDate = new DateTime(1995, 5, 11), IsDeleted = false, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00") },
	        new Player { Id = 93, FirstName = "Dženis", LastName = "Hadžimuratović", Picture = null, BirthDate = new DateTime(1990, 1, 23), IsDeleted = false, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00") },
	        new Player { Id = 94, FirstName = "Almin", LastName = "Kapo", Picture = null, BirthDate = new DateTime(1999, 10, 30), IsDeleted = false, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00") },
	        new Player { Id = 95, FirstName = "Tarik", LastName = "Zulić", Picture = null, BirthDate = new DateTime(1996, 7, 26), IsDeleted = false, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00") },
	        new Player { Id = 96, FirstName = "Eldar", LastName = "Šehić", Picture = null, BirthDate = new DateTime(1997, 3, 5), IsDeleted = false, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00") },
	        new Player { Id = 97, FirstName = "Adnan", LastName = "Begović", Picture = null, BirthDate = new DateTime(1991, 8, 13), IsDeleted = false, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00") },
	        new Player { Id = 98, FirstName = "Haris", LastName = "Halilović", Picture = null, BirthDate = new DateTime(1999, 12, 29), IsDeleted = false, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00") },
	        new Player { Id = 99, FirstName = "Nermin", LastName = "Osmanović", Picture = null, BirthDate = new DateTime(1992, 6, 24), IsDeleted = false, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00") },
	        new Player { Id = 100, FirstName = "Dino", LastName = "Ramić", Picture = null, BirthDate = new DateTime(1994, 2, 17), IsDeleted = false, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00") }
		);
		modelBuilder.Entity<Referee>().HasData(
	        new Referee { Id = 1, FirstName = "Adnan", LastName = "Karić", Picture = null, IsDeleted = false, RemovedAt = null, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00"), ModifiedAt = null },
	        new Referee { Id = 2, FirstName = "Emir", LastName = "Husić", Picture = null, IsDeleted = false, RemovedAt = null, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00"), ModifiedAt = null },
	        new Referee { Id = 3, FirstName = "Nermin", LastName = "Zukić", Picture = null, IsDeleted = false, RemovedAt = null, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00"), ModifiedAt = null },
	        new Referee { Id = 4, FirstName = "Haris", LastName = "Šehić", Picture = null, IsDeleted = false, RemovedAt = null, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00"), ModifiedAt = null },
	        new Referee { Id = 5, FirstName = "Almir", LastName = "Begić", Picture = null, IsDeleted = false, RemovedAt = null, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00"), ModifiedAt = null },
	        new Referee { Id = 6, FirstName = "Senad", LastName = "Jahić", Picture = null, IsDeleted = false, RemovedAt = null, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00"), ModifiedAt = null },
	        new Referee { Id = 7, FirstName = "Mirza", LastName = "Dedić", Picture = null, IsDeleted = false, RemovedAt = null, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00"), ModifiedAt = null },
	        new Referee { Id = 8, FirstName = "Edin", LastName = "Mujić", Picture = null, IsDeleted = false, RemovedAt = null, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00"), ModifiedAt = null },
	        new Referee { Id = 9, FirstName = "Sead", LastName = "Halilović", Picture = null, IsDeleted = false, RemovedAt = null, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00"), ModifiedAt = null },
	        new Referee { Id = 10, FirstName = "Damir", LastName = "Salihović", Picture = null, IsDeleted = false, RemovedAt = null, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00"), ModifiedAt = null },
	        new Referee { Id = 11, FirstName = "Mirsad", LastName = "Brkić", Picture = null, IsDeleted = false, RemovedAt = null, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00"), ModifiedAt = null },
	        new Referee { Id = 12, FirstName = "Ermin", LastName = "Ibrahimović", Picture = null, IsDeleted = false, RemovedAt = null, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00"), ModifiedAt = null },
	        new Referee { Id = 13, FirstName = "Faruk", LastName = "Hadžiosmanović", Picture = null, IsDeleted = false, RemovedAt = null, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00"), ModifiedAt = null },
	        new Referee { Id = 14, FirstName = "Armin", LastName = "Hodžić", Picture = null, IsDeleted = false, RemovedAt = null, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00"), ModifiedAt = null },
	        new Referee { Id = 15, FirstName = "Tarik", LastName = "Softić", Picture = null, IsDeleted = false, RemovedAt = null, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00"), ModifiedAt = null },
	        new Referee { Id = 16, FirstName = "Samir", LastName = "Bubalo", Picture = null, IsDeleted = false, RemovedAt = null, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00"), ModifiedAt = null },
	        new Referee { Id = 17, FirstName = "Muamer", LastName = "Topić", Picture = null, IsDeleted = false, RemovedAt = null, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00"), ModifiedAt = null },
	        new Referee { Id = 18, FirstName = "Nedim", LastName = "Alihodžić", Picture = null, IsDeleted = false, RemovedAt = null, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00"), ModifiedAt = null },
	        new Referee { Id = 19, FirstName = "Elvis", LastName = "Selimović", Picture = null, IsDeleted = false, RemovedAt = null, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00"), ModifiedAt = null },
	        new Referee { Id = 20, FirstName = "Jasmin", LastName = "Bešlija", Picture = null, IsDeleted = false, RemovedAt = null, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00"), ModifiedAt = null }
        );
		modelBuilder.Entity<Review>().HasData(
			new() { Id = 1, UserId = 4, CompetitionId = 5, Rating = 4.5f, IsDeleted = false, RemovedAt = null, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00").AddDays(-1), ModifiedAt = null },
			new() { Id = 2, UserId = 5, CompetitionId = 5, Rating = 3.8f, IsDeleted = false, RemovedAt = null, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00").AddDays(-1), ModifiedAt = null },
			new() { Id = 3, UserId = 6, CompetitionId = 5, Rating = 5.0f, IsDeleted = false, RemovedAt = null, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00").AddDays(-1), ModifiedAt = null }
		);
		modelBuilder.Entity<Reward>().HasData(
			// Competition 1
			new Reward() { Id = 1, CompetitionId = 1, Name = "Prvo mjesto", RankingPosition = 1, Amount = 500, Description = "Nagrada za prvo mjesto", IsDeleted = false, RemovedAt = null, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00").AddDays(-7), ModifiedAt = null },
			new Reward() { Id = 2, CompetitionId = 1, Name = "Drugo mjesto", RankingPosition = 2, Amount = 300, Description = "Nagrada za drugo mjesto", IsDeleted = false, RemovedAt = null, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00").AddDays(-7), ModifiedAt = null },
			new Reward() { Id = 3, CompetitionId = 1, Name = "Treće mjesto", RankingPosition = 3, Amount = 150, Description = "Nagrada za treće mjesto", IsDeleted = false, RemovedAt = null, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00").AddDays(-7), ModifiedAt = null },

			// Competition 2
			new Reward() { Id = 4, CompetitionId = 2, Name = "Prvo mjesto", RankingPosition = 1, Amount = 600, Description = "Nagrada za prvo mjesto", IsDeleted = false, RemovedAt = null, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00").AddDays(-6), ModifiedAt = null },
			new Reward() { Id = 5, CompetitionId = 2, Name = "Drugo mjesto", RankingPosition = 2, Amount = 350, Description = "Nagrada za drugo mjesto", IsDeleted = false, RemovedAt = null, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00").AddDays(-6), ModifiedAt = null },
			new Reward() { Id = 6, CompetitionId = 2, Name = "Treće mjesto", RankingPosition = 3, Amount = 200, Description = "Nagrada za treće mjesto", IsDeleted = false, RemovedAt = null, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00").AddDays(-6), ModifiedAt = null },

			// Competition 3
			new Reward() { Id = 7, CompetitionId = 3, Name = "Prvo mjesto", RankingPosition = 1, Amount = 700, Description = "Nagrada za prvo mjesto", IsDeleted = false, RemovedAt = null, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00").AddDays(-5), ModifiedAt = null },
			new Reward() { Id = 8, CompetitionId = 3, Name = "Drugo mjesto", RankingPosition = 2, Amount = 400, Description = "Nagrada za drugo mjesto", IsDeleted = false, RemovedAt = null, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00").AddDays(-5), ModifiedAt = null },
			new Reward() { Id = 9, CompetitionId = 3, Name = "Treće mjesto", RankingPosition = 3, Amount = 250, Description = "Nagrada za treće mjesto", IsDeleted = false, RemovedAt = null, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00").AddDays(-5), ModifiedAt = null },

			// Competition 5
			new Reward() { Id = 10, CompetitionId = 5, Name = "Prvo mjesto", RankingPosition = 1, Amount = 800, Description = "Nagrada za prvo mjesto", IsDeleted = false, RemovedAt = null, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00").AddDays(-2), ModifiedAt = null },
			new Reward() { Id = 11, CompetitionId = 5, Name = "Drugo mjesto", RankingPosition = 2, Amount = 450, Description = "Nagrada za drugo mjesto", IsDeleted = false, RemovedAt = null, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00").AddDays(-2), ModifiedAt = null },
			new Reward() { Id = 12, CompetitionId = 5, Name = "Treće mjesto", RankingPosition = 3, Amount = 300, Description = "Nagrada za treće mjesto", IsDeleted = false, RemovedAt = null, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00").AddDays(-2), ModifiedAt = null }
		);
		modelBuilder.Entity<Role>().HasData(
            new Role { Id = 1, Name = "Organizer", Description = "Creating tournaments and managing", IsActive = true, IsDeleted = false, CreatedAt = DateTime.Parse("2025-10-04 14:30:00")},
            new Role { Id = 2, Name = "Manager", Description = "Managing teams and participating on competitions", IsActive = true, IsDeleted = false, CreatedAt = DateTime.Parse("2025-10-04 14:30:00")},
            new Role { Id = 3, Name = "Admin", Description = "System administrator, has all privileges in the system", IsActive = true, IsDeleted = false, CreatedAt = DateTime.Parse("2025-10-04 14:30:00")},
			new Role { Id = 4, Name = "Spectator", Description = "Spectates competitions, rates and reviews them", IsActive = true, IsDeleted = false, CreatedAt = DateTime.Parse("2025-10-04 14:30:00") }
		);
		modelBuilder.Entity<Selection>().HasData(
	        new Selection { Id = 10, Name = "Veterani", AgeMax = null, IsDeleted = false, RemovedAt = null, IsActive = true, CreatedAt = new DateTime(2025, 3, 7, 1, 13, 40), ModifiedAt = null },
	        new Selection { Id = 2, Name = "Seniori", AgeMax = null, IsDeleted = false, RemovedAt = null, IsActive = true, CreatedAt = DateTime.MinValue, ModifiedAt = new DateTime(2025, 3, 7, 0, 54, 51) },
	        new Selection { Id = 12, Name = "U-23", AgeMax = 23, IsDeleted = false, RemovedAt = null, IsActive = true, CreatedAt = new DateTime(2025, 4, 28, 23, 5, 32), ModifiedAt = null },
	        new Selection { Id = 1, Name = "U-21", AgeMax = 21, IsDeleted = false, RemovedAt = null, IsActive = true, CreatedAt = new DateTime(2025, 2, 2, 0, 0, 0), ModifiedAt = new DateTime(2025, 4, 28, 23, 5, 21) },
	        new Selection { Id = 3, Name = "U-19", AgeMax = 19, IsDeleted = false, RemovedAt = null, IsActive = true, CreatedAt = DateTime.MinValue, ModifiedAt = null },
	        new Selection { Id = 4, Name = "U-17", AgeMax = 17, IsDeleted = false, RemovedAt = null, IsActive = true, CreatedAt = DateTime.MinValue, ModifiedAt = null },
	        new Selection { Id = 5, Name = "U-15", AgeMax = 15, IsDeleted = false, RemovedAt = null, IsActive = true, CreatedAt = DateTime.MinValue, ModifiedAt = null },
	        new Selection { Id = 6, Name = "U-13", AgeMax = 13, IsDeleted = false, RemovedAt = null, IsActive = true, CreatedAt = DateTime.MinValue, ModifiedAt = null },
	        new Selection { Id = 7, Name = "U-11", AgeMax = 11, IsDeleted = false, RemovedAt = null, IsActive = true, CreatedAt = DateTime.MinValue, ModifiedAt = null },
	        new Selection { Id = 8, Name = "U-9", AgeMax = 9, IsDeleted = false, RemovedAt = null, IsActive = true, CreatedAt = DateTime.MinValue, ModifiedAt = null },
	        new Selection { Id = 9, Name = "U-7", AgeMax = 7, IsDeleted = false, RemovedAt = null, IsActive = true, CreatedAt = DateTime.MinValue, ModifiedAt = null },
	        new Selection { Id = 11, Name = "U-5", AgeMax = 5, IsDeleted = false, RemovedAt = null, IsActive = true, CreatedAt = new DateTime(2025, 4, 28, 23, 1, 34), ModifiedAt = null }
        );
		modelBuilder.Entity<Sponsor>().HasData(
	        new Sponsor { Id = 1, Name = "BH Telecom", Picture = null, IsDeleted = false, RemovedAt = null, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00"), ModifiedAt = null },
	        new Sponsor { Id = 2, Name = "HT Eronet", Picture = null, IsDeleted = false, RemovedAt = null, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00"), ModifiedAt = null },
	        new Sponsor { Id = 3, Name = "Vijeće Grada Mostara", Picture = null, IsDeleted = false, RemovedAt = null, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00"), ModifiedAt = null },
	        new Sponsor { Id = 4, Name = "ASA Banka", Picture = null, IsDeleted = false, RemovedAt = null, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00"), ModifiedAt = null },
	        new Sponsor { Id = 5, Name = "Sparkasse Bank BiH", Picture = null, IsDeleted = false, RemovedAt = null, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00"), ModifiedAt = null },
	        new Sponsor { Id = 6, Name = "Addiko Bank", Picture = null, IsDeleted = false, RemovedAt = null, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00"), ModifiedAt = null },
	        new Sponsor { Id = 7, Name = "UniCredit Bank", Picture = null, IsDeleted = false, RemovedAt = null, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00"), ModifiedAt = null },
	        new Sponsor { Id = 8, Name = "Raiffeisen Bank", Picture = null, IsDeleted = false, RemovedAt = null, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00"), ModifiedAt = null },
	        new Sponsor { Id = 9, Name = "Sarajevski Kiseljak", Picture = null, IsDeleted = false, RemovedAt = null, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00"), ModifiedAt = null },
	        new Sponsor { Id = 10, Name = "Oaza Natural Water", Picture = null, IsDeleted = false, RemovedAt = null, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00"), ModifiedAt = null },
	        new Sponsor { Id = 11, Name = "Sarajevska Pivara", Picture = null, IsDeleted = false, RemovedAt = null, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00"), ModifiedAt = null },
	        new Sponsor { Id = 12, Name = "Bingo d.o.o.", Picture = null, IsDeleted = false, RemovedAt = null, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00"), ModifiedAt = null },
	        new Sponsor { Id = 13, Name = "DM Drogerie Markt", Picture = null, IsDeleted = false, RemovedAt = null, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00"), ModifiedAt = null },
	        new Sponsor { Id = 14, Name = "Mercator BH", Picture = null, IsDeleted = false, RemovedAt = null, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00"), ModifiedAt = null },
	        new Sponsor { Id = 15, Name = "Konzum BiH", Picture = null, IsDeleted = false, RemovedAt = null, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00"), ModifiedAt = null },
	        new Sponsor { Id = 16, Name = "Elektroprivreda BiH", Picture = null, IsDeleted = false, RemovedAt = null, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00"), ModifiedAt = null },
	        new Sponsor { Id = 17, Name = "NLB Banka", Picture = null, IsDeleted = false, RemovedAt = null, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00"), ModifiedAt = null },
	        new Sponsor { Id = 18, Name = "Centrotrans", Picture = null, IsDeleted = false, RemovedAt = null, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00"), ModifiedAt = null },
	        new Sponsor { Id = 19, Name = "Bosnalijek", Picture = null, IsDeleted = false, RemovedAt = null, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00"), ModifiedAt = null },
	        new Sponsor { Id = 20, Name = "Prevent Group", Picture = null, IsDeleted = false, RemovedAt = null, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00"), ModifiedAt = null }
        );
		modelBuilder.Entity<Stadium>().HasData(
			new Stadium { Id = 1, Name = "Sportska dvorana Skenderija", Picture = null, IsDeleted = false, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00") },
			new Stadium { Id = 2, Name = "Dvorana Mirza Delibašić Sarajevo", Picture = null, IsDeleted = false, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00") },
			new Stadium { Id = 3, Name = "Gradska dvorana Tuzla", Picture = null, IsDeleted = false, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00") },
			new Stadium { Id = 4, Name = "Dvorana Mejdan Tuzla", Picture = null, IsDeleted = false, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00") },
			new Stadium { Id = 5, Name = "Sportska dvorana Pecara Široki Brijeg", Picture = null, IsDeleted = false, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00") },
			new Stadium { Id = 6, Name = "Dvorana Mladost Zenica", Picture = null, IsDeleted = false, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00") },
			new Stadium { Id = 7, Name = "Gradska arena Zenica", Picture = null, IsDeleted = false, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00") },
			new Stadium { Id = 8, Name = "Dvorana Borik Banja Luka", Picture = null, IsDeleted = false, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00") },
			new Stadium { Id = 9, Name = "Dvorana Obilićevo Banja Luka", Picture = null, IsDeleted = false, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00") },
			new Stadium { Id = 10, Name = "Sportska dvorana Mostar", Picture = null, IsDeleted = false, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00") },
			new Stadium { Id = 11, Name = "Dvorana Bijeli Brijeg Mostar", Picture = null, IsDeleted = false, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00") },
			new Stadium { Id = 12, Name = "Gradska dvorana Trebinje", Picture = null, IsDeleted = false, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00") },
			new Stadium { Id = 13, Name = "Dvorana Luke Bihać", Picture = null, IsDeleted = false, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00") },
			new Stadium { Id = 14, Name = "Sportska dvorana Livno", Picture = null, IsDeleted = false, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00") },
			new Stadium { Id = 15, Name = "Sportska dvorana Gornji Vakuf-Uskoplje", Picture = null, IsDeleted = false, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00") },
			new Stadium { Id = 16, Name = "Dvorana Kakanj", Picture = null, IsDeleted = false, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00") },
			new Stadium { Id = 17, Name = "Sportska dvorana Jablanica", Picture = null, IsDeleted = false, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00") },
			new Stadium { Id = 18, Name = "Dvorana Novo Sarajevo", Picture = null, IsDeleted = false, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00") },
			new Stadium { Id = 19, Name = "Dvorana Čapljina", Picture = null, IsDeleted = false, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00") },
			new Stadium { Id = 20, Name = "Sportska dvorana Živinice", Picture = null, IsDeleted = false, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00") }
		);

		modelBuilder.Entity<Team>().HasData(
			new Team { Id = 1, UserId = 4, SelectionId = 1, Name = "MNK Lavovi Sarajevo", Picture = null, IsDeleted = false, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00") },
			new Team { Id = 2, UserId = 4, SelectionId = 2, Name = "MNK Vitezovi Zenica", Picture = null, IsDeleted = false, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00") },
			new Team { Id = 3, UserId = 4, SelectionId = 3, Name = "MNK Borci Mostar", Picture = null, IsDeleted = false, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00") },
			new Team { Id = 4, UserId = 4, SelectionId = 4, Name = "MNK Pobjeda Tuzla", Picture = null, IsDeleted = false, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00") },
			new Team { Id = 5, UserId = 4, SelectionId = 5, Name = "MNK Sloga Banja Luka", Picture = null, IsDeleted = false, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00") },
			new Team { Id = 6, UserId = 4, SelectionId = 6, Name = "MNK Olimp Ilidža", Picture = null, IsDeleted = false, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00") },
			new Team { Id = 7, UserId = 4, SelectionId = 7, Name = "MNK Tempo Bihać", Picture = null, IsDeleted = false, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00") },
			new Team { Id = 8, UserId = 4, SelectionId = 8, Name = "MNK Stijena Livno", Picture = null, IsDeleted = false, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00") },
			new Team { Id = 9, UserId = 4, SelectionId = 9, Name = "MNK Energija Kakanj", Picture = null, IsDeleted = false, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00") },
			new Team { Id = 10, UserId = 4, SelectionId = 10, Name = "MNK Fortuna Goražde", Picture = null, IsDeleted = false, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00") },

			new Team { Id = 11, UserId = 5, SelectionId = 11, Name = "MNK Korner Trebinje", Picture = null, IsDeleted = false, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00") },
			new Team { Id = 12, UserId = 5, SelectionId = 12, Name = "MNK Delta Čapljina", Picture = null, IsDeleted = false, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00") },
			new Team { Id = 13, UserId = 5, SelectionId = 1, Name = "MNK Željezno Srce Živinice", Picture = null, IsDeleted = false, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00") },
			new Team { Id = 14, UserId = 5, SelectionId = 2, Name = "MNK Horizont Gradačac", Picture = null, IsDeleted = false, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00") },
			new Team { Id = 15, UserId = 5, SelectionId = 3, Name = "MNK Bljesak Sanski Most", Picture = null, IsDeleted = false, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00") },
			new Team { Id = 16, UserId = 5, SelectionId = 4, Name = "MNK Olimpik Jablanica", Picture = null, IsDeleted = false, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00") },
			new Team { Id = 17, UserId = 5, SelectionId = 5, Name = "MNK Tornado Visoko", Picture = null, IsDeleted = false, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00") },
			new Team { Id = 18, UserId = 5, SelectionId = 6, Name = "MNK Bosna Uskoplje", Picture = null, IsDeleted = false, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00") },
			new Team { Id = 19, UserId = 5, SelectionId = 7, Name = "MNK Mladost Lukavac", Picture = null, IsDeleted = false, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00") },
			new Team { Id = 20, UserId = 5, SelectionId = 8, Name = "MNK Union Travnik", Picture = null, IsDeleted = false, IsActive = true, CreatedAt = DateTime.Parse("2025-10-04 14:30:00") }
		);
		modelBuilder.Entity<User>().HasData(
	        new User
	        {
		        Id = 1,
		        RoleId = 3, // Admin
		        FirstName = "Ensar",
		        LastName = "Čevra",
		        UserName = "cevraensar",
		        Email = "cevraensar@ezscores.ba",
		        PhoneNumber = "+38761000111",
		        PasswordSalt = "WCS1p9TJ0W0jWUR1KP0JaA==",
		        PasswordHash = "ODpOqZ0oalk6+z/9ed/n+FAFGeE=",
		        IsActive = true,
		        IsDeleted = false,
		        CreatedAt = DateTime.Parse("2025-10-04 14:30:00")
	        },
	        new User
	        {
		        Id = 2,
		        RoleId = 1, // Organizer
		        FirstName = "Mirza",
		        LastName = "Kovačević",
		        UserName = "mirzakovacevic",
		        Email = "mirza.kovacevic@ezscores.ba",
		        PhoneNumber = "+38761000222",
				PasswordSalt = "WCS1p9TJ0W0jWUR1KP0JaA==",
				PasswordHash = "ODpOqZ0oalk6+z/9ed/n+FAFGeE=",
				IsActive = true,
		        IsDeleted = false,
		        CreatedAt = DateTime.Parse("2025-10-04 14:30:00")
	        },
			new User
			{
				Id = 3,
				RoleId = 1, // Organizer
				FirstName = "Ensar",
				LastName = "Čevra",
				UserName = "ensarcevra",
				Email = "ensar.cevra@ezscores.ba",
				PhoneNumber = "+38761000222",
				PasswordSalt = "WCS1p9TJ0W0jWUR1KP0JaA==",
				PasswordHash = "ODpOqZ0oalk6+z/9ed/n+FAFGeE=",
				IsActive = true,
				IsDeleted = false,
				CreatedAt = DateTime.Parse("2025-10-04 14:30:00")
			},
			new User
	        {
		        Id = 4,
		        RoleId = 2, // Manager
		        FirstName = "Elmin",
		        LastName = "Hadžiosmanović",
		        UserName = "elminhadziosmanovic",
		        Email = "elmin.hadziosmanovic@ezscores.ba",
		        PhoneNumber = "+38761000333",
				PasswordSalt = "WCS1p9TJ0W0jWUR1KP0JaA==",
				PasswordHash = "ODpOqZ0oalk6+z/9ed/n+FAFGeE=",
				IsActive = true,
		        IsDeleted = false,
		        CreatedAt = DateTime.Parse("2025-10-04 14:30:00")
	        },
	        new User
	        {
		        Id = 5,
		        RoleId = 2, // Manager
		        FirstName = "Nermin",
		        LastName = "Karić",
		        UserName = "nerminkaric",
		        Email = "nermin.karic@ezscores.ba",
		        PhoneNumber = "+38761000444",
				PasswordSalt = "WCS1p9TJ0W0jWUR1KP0JaA==",
				PasswordHash = "ODpOqZ0oalk6+z/9ed/n+FAFGeE=",
				IsActive = true,
		        IsDeleted = false,
		        CreatedAt = DateTime.Parse("2025-10-04 14:30:00")
	        },
	        new User
	        {
		        Id = 6,
		        RoleId = 4, // Spectator
		        FirstName = "Selma",
		        LastName = "Muratović",
		        UserName = "selmamuratovic",
		        Email = "selma.muratovic@ezscores.ba",
		        PhoneNumber = "+38761000555",
				PasswordSalt = "WCS1p9TJ0W0jWUR1KP0JaA==",
				PasswordHash = "ODpOqZ0oalk6+z/9ed/n+FAFGeE=",
				IsActive = true,
		        IsDeleted = false,
		        CreatedAt = DateTime.Parse("2025-10-04 14:30:00")
	        }
        );


	}
}
