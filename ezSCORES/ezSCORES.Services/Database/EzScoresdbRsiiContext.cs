using System;
using System.Collections.Generic;
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

    public virtual DbSet<Stadium> Stadia { get; set; }

    public virtual DbSet<Team> Teams { get; set; }

    public virtual DbSet<User> Users { get; set; }

    protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
#warning To protect potentially sensitive information in your connection string, you should move it out of source code. You can avoid scaffolding the connection string by using the Name= syntax to read it from configuration - see https://go.microsoft.com/fwlink/?linkid=2131148. For more guidance on storing connection strings, see https://go.microsoft.com/fwlink/?LinkId=723263.
        => optionsBuilder.UseSqlServer("Data Source=DESKTOP-78JFTTM;Initial Catalog=ezSCORESdb_RSII;Integrated Security=True;Trust Server Certificate=True");

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
        });

        OnModelCreatingPartial(modelBuilder);
    }

    partial void OnModelCreatingPartial(ModelBuilder modelBuilder);
}
