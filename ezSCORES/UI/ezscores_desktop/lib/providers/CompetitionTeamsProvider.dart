import 'dart:convert';

import 'package:ezscores_desktop/models/competitionsTeams.dart';
import 'package:ezscores_desktop/providers/base_provider.dart';
import 'package:http/http.dart' as http;

class CompetitionTeamsProvider extends BaseProvider<CompetitionsTeams>
{
  CompetitionTeamsProvider(): super("CompetitionTeams");

  @override
  CompetitionsTeams fromJson(data) {
    // TODO: implement fromJson
    return CompetitionsTeams.fromJson(data);
  }

  Future<void> assignGroup(dynamic request) async {
    var url =
        "${BaseProvider.baseUrl}CompetitionTeams/assign-group";

    var uri = Uri.parse(url);
    var headers = createHeaders();
    final body = jsonEncode(request);
    http.Response response;
    try {
      response = await http.patch(uri, headers: headers, body: body);
    } on UserException {
      rethrow;
    }
    if (isValidResponse(response)) {
      // var data = jsonDecode(response.body);
      // return fromJson(data);
    } else {
      throw UserException("Unknown error.");
    }
  }
}