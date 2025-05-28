import 'dart:convert';

import 'package:ezscores_desktop/models/DTOs/matchDto.dart';
import 'package:ezscores_desktop/models/matches.dart';
import 'package:ezscores_desktop/providers/base_provider.dart';
import 'package:http/http.dart' as http;

class MatchesProvider extends BaseProvider<Matches>
{
  MatchesProvider(): super("Matches");

  @override
  Matches fromJson(data) {
    return Matches.fromJson(data);
  }

  Future<MatchDTO> getMatchDetails(int id) async {
    var url =
        "${BaseProvider.baseUrl}get-match-details/$id";

    var uri = Uri.parse(url);
    var headers = createHeaders();
    http.Response response;
    try {
      response = await http.get(uri, headers: headers);
    } on UserException {
      rethrow;
    }
    if (isValidResponse(response)) {
      var data = jsonDecode(response.body);
      return data.map((e) => MatchDTO.fromJson(e));
    } else {
      throw UserException("Unknown error.");
    }
  }
}