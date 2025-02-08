using ezSCORES.Model;
using ezSCORES.Model.Requests;
using ezSCORES.Services.Database;
using MapsterMapper;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ezSCORES.Services
{
	public class CompetitionsService : ICompetitionsService
	{
		public EzScoresdbRsiiContext Context { get; set; }
		public IMapper Mapper;
		public CompetitionsService(EzScoresdbRsiiContext context, IMapper mapper)
		{
			Context = context;
			Mapper = mapper;
		}
		public Competitions Insert(CompetitionsInsertRequest request)
		{
			Database.Competition entity = new Database.Competition();
			Mapper.Map(request, entity);
			entity.CreatedAt = DateTime.Now;
			Context.Add(entity);
			Context.SaveChanges();

			return Mapper.Map<Competitions>(entity);
		}
	}
}
