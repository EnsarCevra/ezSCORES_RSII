using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Design;
using Microsoft.Extensions.Configuration;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ezSCORES.Services.Database
{
	public class EzScoresRsiiContextFactory : IDesignTimeDbContextFactory<EzScoresdbRsiiContext>
	{
		public EzScoresdbRsiiContext CreateDbContext(string[] args)
		{
			var environment = Environment.GetEnvironmentVariable("ASPNETCORE_ENVIRONMENT") ?? "Development";

			var basePath = Path.GetFullPath(Path.Combine(
				Directory.GetCurrentDirectory(),
				"..",
				"ezSCORES.API"
			));

			var configuration = new ConfigurationBuilder()
				.SetBasePath(basePath)
				.AddJsonFile("appsettings.json", optional: false, reloadOnChange: false)
				.AddJsonFile($"appsettings.{environment}.json", optional: true)
				.AddEnvironmentVariables()
				.Build();

			var connectionString = configuration.GetConnectionString("ezSCORES_Connection");

			var optionsBuilder = new DbContextOptionsBuilder<EzScoresdbRsiiContext>();
			optionsBuilder.UseSqlServer(connectionString);

			return new EzScoresdbRsiiContext(optionsBuilder.Options);
		}
	}
}
