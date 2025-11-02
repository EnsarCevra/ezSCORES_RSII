using System.Net;
using System.Net.Mail;

namespace ezSCORESSubscriber
{
	public class EmailService : IEmailService
	{
		public async Task SendEmail(ezSCORES.Model.Messages.ApplicationStatusChanged msg)
		{
			try
			{
				var host = Environment.GetEnvironmentVariable("SMTP_HOST");
				var port = int.Parse(Environment.GetEnvironmentVariable("SMTP_PORT") ?? "587");
				var user = Environment.GetEnvironmentVariable("SMTP_USER");
				var pass = Environment.GetEnvironmentVariable("SMTP_EZ_PASS");
				var from = Environment.GetEnvironmentVariable("SMTP_FROM");
				using var smtp = new SmtpClient(host)
				{
					Port = port,
					Credentials = new NetworkCredential(user, pass),
					EnableSsl = true
				};
				//create body based on application status and wethere application fee should be paid or not
				var body = $"Poštovani/poštovana {msg.UserFirstName},\n\nVaša prijava na {msg.CompetitionName} " +
					$"takmičenje sa ekipom {msg.TeamName} je {(msg.ApplicationStatus ? "prihvaćena" : "odbijena")}.\n\n" +
					$"{(msg.IsFeeRequired == true ? "Molimo izvršite uplatu putem mobilne aplikacije." : "")}" +
					$"\n\n Lijep pozdrav, \nEZ Tim";

				var email = new MailMessage(from, msg.UserEmail)
				{
					Subject = "Obavijest o izmjeni statusa prijave",
					Body = body
				};
				await smtp.SendMailAsync(email);
				Console.WriteLine($"Email successfully sent to {msg.UserEmail}");
			}
			catch (Exception err)
			{

				Console.WriteLine($"Error sending email: {err.Message}");
			}
		}
	}
}