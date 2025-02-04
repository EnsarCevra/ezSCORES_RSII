using ezSCORES.Model;
using ezSCORES.Model.Requests;
using ezSCORES.Services.Database;
using MapsterMapper;
using Microsoft.EntityFrameworkCore.ChangeTracking.Internal;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Cryptography;
using System.Text;
using System.Threading.Tasks;

namespace ezSCORES.Services
{
	public class UsersService : IUsersService
	{
		public EzScoresdbRsiiContext Context { get; set; }
		public IMapper Mapper;
		public UsersService(EzScoresdbRsiiContext context, IMapper mapper)
		{
			Context = context;
			Mapper = mapper;
		}

		public List<Users> GetList()
		{
			var result = new List<Users>();
			var list = Context.Users.ToList();
			//list.ForEach(item =>
			//{
			//	result.Add(new Users()
			//	{
			//		Id = item.Id,
			//		FirstName = item.FirstName,
			//		LastName = item.LastName,
			//		Email = item.Email,
			//		IsActive = item.IsActive
			//	});
			//});

			result = Mapper.Map(list, result);
			return result;
		}

		public Users Insert(UsersInsertRequests request)
		{
			if(request.Password != request.PasswordConfirmation)
			{
				throw new Exception("Lozinke se ne podudaraju!");
			}

			Database.User entity = new Database.User();
			Mapper.Map(request, entity);
			entity.PasswordSalt = GenerateSalt();
			entity.PasswordHash = GenerateHash(entity.PasswordSalt, request.Password);
			entity.CreatedAt = DateOnly.FromDateTime(DateTime.Now);
			Context.Add(entity);
			Context.SaveChanges();

			return Mapper.Map<Users>(entity);
		}
		public static string GenerateSalt()
		{
			var byteArray = RandomNumberGenerator.GetBytes(16);
			return Convert.ToBase64String(byteArray);
		}
		public static string GenerateHash(string salt, string password)
		{
			byte[] src = Convert.FromBase64String(salt);
			byte[] bytes = Encoding.Unicode.GetBytes(password);
			byte[] dst = new byte[src.Length + bytes.Length];

			System.Buffer.BlockCopy(src, 0, dst, 0, src.Length);
			System.Buffer.BlockCopy(bytes, 0, dst, src.Length, bytes.Length);

			HashAlgorithm algorithm = HashAlgorithm.Create("SHA1");

			byte[] inArray = algorithm.ComputeHash(dst);
			return Convert.ToBase64String(inArray);
		}

		public Users Update(int id, UsersUpdateRequest request)
		{
			var entity = Context.Users.Find(id);

			Mapper.Map(request, entity);

			if(request.Password != null)
			{
				if (request.Password != request.PasswordConfirmation)
				{
					throw new Exception("Lozinke se ne podudaraju!");
				}
				entity.PasswordSalt = GenerateSalt();
				entity.PasswordHash = GenerateHash(entity.PasswordSalt, request.Password);
			}
			entity.ModifiedAt = DateOnly.FromDateTime(DateTime.Now);
			Context.SaveChanges();

			return Mapper.Map<Users>(entity);
		}
	}
}
