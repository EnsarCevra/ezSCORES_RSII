using ezSCORES.Model;
using ezSCORES.Model.SearchObjects;
using ezSCORES.Services.Database;
using MapsterMapper;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.ChangeTracking.Internal;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Security;
using System.Security.Cryptography;
using System.Text;
using System.Threading.Tasks;
using System.Linq.Dynamic;
using ezSCORES.Model.Requests.UserRequests;

namespace ezSCORES.Services
{
    public class UsersService : BaseCRUDService<Users, UserSearchObject, User, UsersInsertRequests, UsersUpdateRequest>, IUsersService
	{
		public UsersService(EzScoresdbRsiiContext context, IMapper mapper) : base(context, mapper)
		{
		}

		public override IQueryable<User> AddFilter(UserSearchObject search, IQueryable<User> query)
		{
			var filteredQuery = base.AddFilter(search, query);
			if (!string.IsNullOrWhiteSpace(search?.FirstNameGTE))
			{
				filteredQuery = filteredQuery.Where(x => x.FirstName.StartsWith(search.FirstNameGTE));
			}
			if (!string.IsNullOrWhiteSpace(search?.LastNameGTE))
			{
				filteredQuery = filteredQuery.Where(x => x.LastName.StartsWith(search.LastNameGTE));
			}
			if (!string.IsNullOrWhiteSpace(search?.Email))
			{
				filteredQuery = filteredQuery.Where(x => x.Email == search.Email);
			}
			if (!string.IsNullOrWhiteSpace(search?.UserName))
			{
				filteredQuery = filteredQuery.Where(x => x.UserName == search.UserName);
			}
			if (search.IsRolesIncluded == true)
			{
				filteredQuery = filteredQuery.Include(x => x.Role);
			}
			int count = filteredQuery.Count();
			if (!string.IsNullOrWhiteSpace(search.OrderBy))
			{
				//query = query.OrderBy(searchObject.OrderBy);
			}
			if (search?.Page.HasValue == true && search?.PageSize.HasValue == true)
			{
				filteredQuery = filteredQuery.Skip(search.Page.Value * search.PageSize.Value).Take(search.PageSize.Value);
			}
			return filteredQuery;
		}
		public override void BeforeInsert(UsersInsertRequests request, User entity)
		{
			base.BeforeInsert(request, entity);
			if (request.Password != request.PasswordConfirmation)
			{
				throw new Exception("Lozinke se ne podudaraju!");
			}
			entity.PasswordSalt = GenerateSalt();
			entity.PasswordHash = GenerateHash(entity.PasswordSalt, request.Password);
			entity.CreatedAt = DateTime.UtcNow;
		}
		public override void BeforeUpdate(UsersUpdateRequest request, User entity)
		{

			if (request.Password != null)
			{
				if (request.Password != request.PasswordConfirmation)
				{
					throw new Exception("Lozinke se ne podudaraju!");
				}
				entity.PasswordSalt = GenerateSalt();
				entity.PasswordHash = GenerateHash(entity.PasswordSalt, request.Password);
			}
			entity.ModifiedAt = DateTime.Now;
		}
		//public Users Insert(UsersInsertRequests request)
		//{
		//	if (request.Password != request.PasswordConfirmation)
		//	{
		//		throw new Exception("Lozinke se ne podudaraju!");
		//	}

		//	Database.User entity = new Database.User();
		//	Mapper.Map(request, entity);
		//	entity.PasswordSalt = GenerateSalt();
		//	entity.PasswordHash = GenerateHash(entity.PasswordSalt, request.Password);
		//	entity.CreatedAt = DateTime.Now;
		//	Context.Add(entity);
		//	Context.SaveChanges();

		//	return Mapper.Map<Users>(entity);
		//}
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
	}
}
