import 'dart:convert';

import 'package:ezscores_mobile/models/DTOs/matchDto.dart';
import 'package:ezscores_mobile/models/DTOs/matchesByDateDto.dart';
import 'package:ezscores_mobile/models/matches.dart';
import 'package:ezscores_mobile/models/search_result.dart';
import 'package:ezscores_mobile/providers/base_provider.dart';
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
        "${BaseProvider.baseUrl}Matches/get-match-details/$id";

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
      return MatchDTO.fromJson(data);
    } else {
      throw UserException("Unknown error.");
    }
  }
  Future<SearchResult<MatchesByDateDTO>> getMatchesByDate({dynamic filter}) async {
    var url =
        "${BaseProvider.baseUrl}Matches/get-matches-by-date";

     if (filter != null) {
      var queryString = getQueryString(filter);
      url = "$url?$queryString";
    }

    var uri = Uri.parse(url);
    var headers = createHeaders();

    var response = await http.get(uri, headers: headers);
    if (isValidResponse(response)) {
      var data = jsonDecode(response.body);
      var result = SearchResult<MatchesByDateDTO>();

      result.count = data['count'];

      for (var item in data['resultList']) {
        result.result.add(MatchesByDateDTO.fromJson(item));
      }
      return result;
    } else {
      throw UserException("Unknown error.");
    }
  }

  Future<void> startMatch(int matchId) async {
    var url = "${BaseProvider.baseUrl}Matches/$matchId/start-match";
    var uri = Uri.parse(url);
    var headers = createHeaders();
    http.Response response;

    try {
      response = await http.patch(uri, headers: headers);
    } on UserException {
      rethrow;
    }

    if (!isValidResponse(response)) {
      throw UserException("Neuspješno pokretanje utakmice.");
    }
  }

  Future<void> finishMatch(int matchId, isCompletedInRegullarTime) async {
    var url = "${BaseProvider.baseUrl}Matches/$matchId/finish-match";
    var uri = Uri.parse(url);
    var headers = createHeaders();
    final body = jsonEncode({"isCompletedInRegullarTime": isCompletedInRegullarTime});
    http.Response response;

    try {
      response = await http.patch(uri, headers: headers, body: body);
    } on UserException {
      rethrow;
    }

    if (!isValidResponse(response)) {
      throw UserException("Neuspješno završavanje utakmice.");
    }
  }
}