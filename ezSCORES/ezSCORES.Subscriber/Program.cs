using DotNetEnv;

using EasyNetQ;

using ezSCORES.Subscriber;

Env.Load();

var emailService = new ezSCORESSubscriber.EmailService();

Task.Delay(10000).Wait();

Task.Delay(1000).Wait();

Console.WriteLine("Starting RabbitMQ subscriber...");

var rabbitHost = Environment.GetEnvironmentVariable("RABBIT_MQ_HOST") ?? "localhost";

var rabbitUser = Environment.GetEnvironmentVariable("RABBITMQ_DEFAULT_USER") ?? "guest";

var rabbitPass = Environment.GetEnvironmentVariable("RABBITMQ_DEFAULT_PASS") ?? "guest";

var rabbitPort = Environment.GetEnvironmentVariable("RABBIT_MQ_PORT") ?? "5672";

var connectionString = $"host={rabbitHost};username={rabbitUser};password={rabbitPass};port={rabbitPort}";

var bus = RabbitHutch.CreateBus(connectionString); 
bus.PubSub.SubscribeAsync<ezSCORES.Model.Messages.ApplicationStatusChanged>("application-accepted-group", async msg =>

{

	Console.WriteLine($"Received application accepted for {msg.UserEmail}.");

	emailService.SendEmail(msg);

});

Console.WriteLine("Listening for messages, press <return> key to close");

Console.ReadLine();
Thread.Sleep(Timeout.Infinite);