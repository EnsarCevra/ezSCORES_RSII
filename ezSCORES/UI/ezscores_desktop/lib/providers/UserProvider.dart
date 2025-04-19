import 'dart:convert';

import 'package:ezscores_desktop/models/users.dart';
import 'package:ezscores_desktop/providers/base_provider.dart';
import 'package:http/http.dart' as http;

class UserProvider extends BaseProvider<Users>
{
  UserProvider(): super("Users");

  @override
  Users fromJson(data) {
    return Users.fromJson(data);
  }

  Future<Users> login(
      String username, String password) async {
    var url =
        "${BaseProvider.baseUrl}Users/login?username=$username&password=$password";

    var uri = Uri.parse(url);
    var headers = createHeaders();

    http.Response response;
    try {
      response = await http.post(uri, headers: headers);
    } on UserException catch (e) {
      throw UserException("Greška prilikom prijave.");
    }
    if (username.isEmpty || password.isEmpty) {
      throw UserException("Molimo unesite korisničko ime i lozinku.");
    }
    if (response.body == "") {
      throw UserException("Pogrešno korisničko ime ili lozinka.");
    }
    if (isValidResponse(response)) {
      var data = jsonDecode(response.body);
      return fromJson(data);
    } else {
      throw UserException("Unknown error.");
    }
  }
}