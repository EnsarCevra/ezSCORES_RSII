﻿using System;
using System.Collections.Generic;
using System.Text;

namespace ezSCORES.Model.Requests.TeamsRequests
{
    public class TeamsInsertRequest
    {
        public string Name { get; set; }
        public int SelectionId { get; set; }
        public byte[]? Picture { get; set; }
    }
}
