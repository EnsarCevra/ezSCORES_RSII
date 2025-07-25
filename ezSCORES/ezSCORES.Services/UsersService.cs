﻿using ezSCORES.Model;
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
using System.IO.Pipelines;
using ezSCORES.Services.Auth;

namespace ezSCORES.Services
{
    public class UsersService : BaseCRUDService<Users, UserSearchObject, User, UsersInsertRequests, UsersUpdateRequest>, IUsersService
	{
		private readonly IActiveUserService _activeUserService;
		public UsersService(EzScoresdbRsiiContext context, IMapper mapper, IActiveUserService userService) : base(context, mapper)
		{
			_activeUserService = userService;
		}

		public override IQueryable<User> AddFilter(UserSearchObject search, IQueryable<User> query)
		{
			var filteredQuery = base.AddFilter(search, query);
			if (!string.IsNullOrWhiteSpace(search?.FirstNameGTE))
			{
				query = query.Where(x => x.FirstName.StartsWith(search.FirstNameGTE));
			}
			if (!string.IsNullOrWhiteSpace(search?.LastNameGTE))
			{
				query = query.Where(x => x.LastName.StartsWith(search.LastNameGTE));
			}
			if (search?.RoleId != null)
			{
				query = query.Where(x => x.RoleId == search.RoleId);
			}
			if (!string.IsNullOrWhiteSpace(search?.Email))
			{
				query = query.Where(x => x.Email == search.Email);
			}
			if (!string.IsNullOrWhiteSpace(search?.UserName))
			{
				query = query.Where(x => x.UserName.StartsWith(search.UserName));
			}
			if (search.IsRolesIncluded == true)
			{
				query = query.Include(x => x.Role);
			}
			if (!string.IsNullOrWhiteSpace(search.OrderBy))
			{
				//query = query.OrderBy(searchObject.OrderBy);
			}
			//if (search?.Page.HasValue == true && search?.PageSize.HasValue == true)
			//{
			//	query = query.Skip(search.Page.Value * search.PageSize.Value).Take(search.PageSize.Value);
			//}
			return base.AddFilter(search, query);
		}
		public override void BeforeInsert(UsersInsertRequests request, User entity)
		{
			base.BeforeInsert(request, entity);
			if(Context.Users.Where(x=>x.UserName == request.UserName).Any())
			{
				throw new UserException("Korisničko ime je zauzeto");
			}
			if (request.Password != request.PasswordConfirmation)
			{
				throw new UserException("Lozinke se ne podudaraju!");
			}
			entity.PasswordSalt = GenerateSalt();
			entity.PasswordHash = GenerateHash(entity.PasswordSalt, request.Password);
		}
		public override void BeforeUpdate(UsersUpdateRequest request, User entity)
		{

			if (request.Password != null && request.PasswordConfirmation != null)
			{
				//if no oldPasword is sent admin is chaning another users pass
				if(request.OldPassword == null)//check wether current user is requesting his own pass change
				{
					if (_activeUserService.GetActiveUserId() == entity.Id)
						throw new UserException("Stara lozinka nije unesena!");
				}
				else
				{
					if (!Context.Users.Where(x => x.PasswordHash == GenerateHash(entity.PasswordSalt, request.OldPassword) && x.Id == entity.Id).Any())
					{
						throw new UserException("Stara lozinka nije ispravna!");
					}
				}
				if (request.Password != request.PasswordConfirmation)
				{
					throw new UserException("Lozinke se ne podudaraju!");
				}
				entity.PasswordSalt = GenerateSalt();
				entity.PasswordHash = GenerateHash(entity.PasswordSalt, request.Password);
			}
			entity.ModifiedAt = DateTime.Now;
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

		public Users Login(string username, string password)
		{
			var entity = Context.Users.Include(x=>x.Role).FirstOrDefault(x => x.UserName == username);
			if(entity == null)
			{
				return null;
			}
			var hash = GenerateHash(entity.PasswordSalt, password);
			if(hash != entity.PasswordHash)
			{
				return null;
			}
			return this.Mapper.Map<Users>(entity);
		}
	}
}
