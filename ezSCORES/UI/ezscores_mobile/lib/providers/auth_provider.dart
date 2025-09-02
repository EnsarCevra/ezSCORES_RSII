class AuthProvider
{
  static String username = "";
  static String password = "";
  static int? id;
  static String? firstName;
  static String? lastName;
  static String? userName;
  static String? picture;
  static String? email;
  static String? phoneNumber;
  static String? organization;
  static int? roleID;
  static String? roleName;
  static String? roleDecription;
  static isLoggedIn(){return id == null ? false : true;}
}