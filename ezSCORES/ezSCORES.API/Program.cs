using ezSCORES.Services;
using ezSCORES.Services.Database;
using Mapster;
using Microsoft.EntityFrameworkCore;

var builder = WebApplication.CreateBuilder(args);

// Add services to the container.
builder.Services.AddTransient<ITeamsService, TeamsService>();
builder.Services.AddTransient<IUsersService, UsersService>();
builder.Services.AddTransient<ICompetitionsService, CompetitionsService>();
builder.Services.AddTransient<IPlayersService, PlayersService>();
builder.Services.AddTransient<ICitiesService, CitiesService>();
builder.Services.AddTransient<IRefereesService, RefereesService>();
builder.Services.AddTransient<IRolesService, RolesService>();
builder.Services.AddTransient<ISelectionsService, SelectionsService>();
builder.Services.AddTransient<ICompetitionsRefereesService, CompetitionsRefereesService>();
builder.Services.AddTransient<ICompetitionsSponsorsService, CompetitionsSponsorsService>();
builder.Services.AddTransient<IFavoriteCompetitionsService, FavoriteCompetitionsService>();
builder.Services.AddTransient<IGroupsService, GroupesService>();
builder.Services.AddTransient<IMatchesService, MatchesService>();
builder.Services.AddTransient<IRewardsService, RewardsService>();
builder.Services.AddTransient<IStadiumsService, StadiumsService>();
builder.Services.AddTransient<ISponsorsService, SponsorsService>();
//builder.Services.AddTransient<IStadiumsService, StadiumsService>();
//builder.Services.AddTransient<IStadiumsService, StadiumsService>();

builder.Services.AddControllers();
builder.Services.AddMapster();
// Learn more about configuring Swagger/OpenAPI at https://aka.ms/aspnetcore/swashbuckle
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen();

var connectionString = builder.Configuration.GetConnectionString("ezSCORES_Connection");
builder.Services.AddDbContext<EzScoresdbRsiiContext>(options => options.UseSqlServer(connectionString));

var app = builder.Build();

// Configure the HTTP request pipeline.
if (app.Environment.IsDevelopment())
{
	app.UseSwagger();
	app.UseSwaggerUI();
}

app.UseHttpsRedirection();

app.UseAuthorization();

app.MapControllers();

app.Run();
