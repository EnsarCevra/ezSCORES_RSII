using System;
using System.Collections.Generic;
using System.Text;

namespace ezSCORES.Model.SearchObjects
{
	public class BaseSearchObject
	{
		public string? Name { get; set; }
		public int? Page { get; set; }
		public int? PageSize { get; set; }
	}
}
