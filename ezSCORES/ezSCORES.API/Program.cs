using ezSCORES.API.Authentication;
using ezSCORES.API.Filters;
using ezSCORES.Services;
using ezSCORES.Services.Auth;
using ezSCORES.Services.Database;
using Mapster;
using Microsoft.AspNetCore.Authentication;
using Microsoft.EntityFrameworkCore;
using Microsoft.OpenApi.Models;

var builder = WebApplication.CreateBuilder(args);

// Add services to the container.
builder.Services.AddTransient<IApplicationService, ApplicationService>();
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
builder.Services.AddTransient<IReviewsService, ReviewsService>();
builder.Services.AddTransient<IGoalsService, GoalsService>();
builder.Services.AddTransient<IFixturesService, FixturesService>();
builder.Services.AddTransient<ICompetitionTeamsService, CompetitionTeamsService>();


builder.Services.AddTransient<IActiveUserService, ActiveUserService>();

builder.Services.AddControllers( x =>
{
	x.Filters.Add<ExceptionFilter>();
});
builder.Services.AddMapster();
builder.Services.AddAuthentication("BasicAuthentication")
	.AddScheme<AuthenticationSchemeOptions, BasicAuthenticationHandler>("BasicAuthentication", null);
// Learn more about configuring Swagger/OpenAPI at https://aka.ms/aspnetcore/swashbuckle
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen(c =>
{
	c.AddSecurityDefinition("basicAuth", new Microsoft.OpenApi.Models.OpenApiSecurityScheme()
	{
		Type = Microsoft.OpenApi.Models.SecuritySchemeType.Http,
		Scheme = "basic"
	});

	c.AddSecurityRequirement(new Microsoft.OpenApi.Models.OpenApiSecurityRequirement()
	{
		{
			new OpenApiSecurityScheme
			{
				Reference = new OpenApiReference{Type = ReferenceType.SecurityScheme, Id = "basicAuth"}
			},
			new string[]{}
	} });

});

var connectionString = builder.Configuration.GetConnectionString("ezSCORES_Connection");
builder.Services.AddDbContext<EzScoresdbRsiiContext>(options => options.UseSqlServer(connectionString));
builder.Services.AddHttpContextAccessor();

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
