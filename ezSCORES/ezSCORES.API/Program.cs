using ezSCORES.Services;
using ezSCORES.Services.Database;
using Mapster;
using Microsoft.EntityFrameworkCore;

var builder = WebApplication.CreateBuilder(args);

// Add services to the container.
builder.Services.AddTransient<ITeamsService, TeamsService>();
builder.Services.AddTransient<IUsersService, UsersService>();
builder.Services.AddTransient<ICompetitionsService, CompetitionsService>();
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
