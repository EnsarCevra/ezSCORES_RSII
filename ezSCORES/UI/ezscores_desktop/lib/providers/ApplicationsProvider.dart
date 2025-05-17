import 'dart:convert';

import 'package:ezscores_desktop/models/applications.dart';
import 'package:ezscores_desktop/providers/base_provider.dart';
import 'package:http/http.dart' as http;

class ApplicationProvider extends BaseProvider<Applications>
{
  ApplicationProvider(): super("Applications");

  @override
  Applications fromJson(data) {
    // TODO: implement fromJson
    return Applications.fromJson(data);
  }

  Future<Applications> toogleApplicationStatus(int id, bool status) async {
    var url =
        "${BaseProvider.baseUrl}Applications/$id/toggle-status";

    var uri = Uri.parse(url);
    var headers = createHeaders();
    final body = jsonEncode({"status": status});
    http.Response response;
    try {
      response = await http.patch(uri, headers: headers, body: body);
    } on UserException catch (e) {
      rethrow;
    }
    if (isValidResponse(response)) {
      var data = jsonDecode(response.body);
      return fromJson(data);
    } else {
      throw UserException("Unknown error.");
    }
  }
}