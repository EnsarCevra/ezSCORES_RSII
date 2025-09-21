using DotNetEnv;
using EasyNetQ;
using ezSCORES.Model.Messages;

namespace ezSCORESSubscriber
{
	internal class Program
	{
		static async Task Main(string[] args)
		{
			Env.Load();
			var emailService = new EmailService();
			Console.WriteLine("Starting RabbitMQ subscriber...");
			var bus = RabbitHutch.CreateBus("host=localhost; username=guest;password=guest");
			await bus.PubSub.SubscribeAsync<ApplicationStatusChanged>("application-accepted-group", async msg =>
			{
				Console.WriteLine($"Received application accepted for {msg.UserEmail}.");
				await emailService.SendEmail(msg);
			});

			Console.WriteLine("Listening for messages, press <return> key to close");
			Console.ReadLine();
		}
	}
}
