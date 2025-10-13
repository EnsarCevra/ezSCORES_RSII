namespace ezSCORES.Subscriber
{
	public class ApplicationStatusChanged
	{
		public int ApplicationId { get; set; }
		public string TeamName { get; set; }
		public string CompetitionName { get; set; }
		public string Message { get; set; }
		public string UserEmail { get; set; }
		public string UserFirstName { get; set; }
		public bool ApplicationStatus { get; set; }
		public bool IsFeeRequired { get; set; }
	}
}