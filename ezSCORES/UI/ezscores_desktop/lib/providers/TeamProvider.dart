import 'dart:convert';
import 'package:ezscores_desktop/providers/auth_provider.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
class TeamProvider
{
  static String? baseurl;
  TeamProvider()
  {
    baseurl = const String.fromEnvironment("baseurl", defaultValue: "http://localhost:5230/api/");
  }
  Future<dynamic> Get() async
  {
    var url = '${baseurl}Teams';
    var uri = Uri.parse(url);
    var response = await http.get(uri, headers: createHeaders());

    if(isValidResponse(response))
    {
      var data = jsonDecode(response.body);
      return data;
    }
    else 
    {
      throw new Exception("Unknown exception");
    }
  }

bool isValidResponse(Response response)
{
  if(response.statusCode < 299)
  {
    return true;
  }
  else if (response.statusCode == 401)
  {
    throw new Exception("Unauthorized");
  }
  else 
  {
    throw new Exception("Something bad happened, please try again!");
  }
}
  Map<String, String> createHeaders()
  {
    String username = AuthProvider.username;
    String password = AuthProvider.password;
    String basicAuth = "Basic ${base64Encode(utf8.encode('${username}:${password}'))}";

    var headers = {
      "Content-type": "application/json",
      "Authorization": basicAuth
    };

    return headers;
  }
}