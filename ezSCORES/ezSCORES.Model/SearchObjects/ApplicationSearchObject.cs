﻿using System;
using System.Collections.Generic;
using System.Text;

namespace ezSCORES.Model.SearchObjects
{
	public class ApplicationSearchObject : BaseCompetitionSearchObject
	{
		public int? TeamId { get; set; }

		public bool? IsPaId { get; set; }

		public bool? IsAccepted { get; set; }
	}
}
