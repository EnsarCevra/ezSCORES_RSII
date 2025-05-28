import 'dart:convert';

import 'package:ezscores_desktop/models/DTOs/fixtureDto.dart';
import 'package:ezscores_desktop/models/fixtures.dart';
import 'package:ezscores_desktop/providers/base_provider.dart';
import 'package:http/http.dart' as http;

class FixtureProvider extends BaseProvider<Fixtures>
{
  FixtureProvider(): super("Fixtures");

  @override
  Fixtures fromJson(data) {
    return Fixtures.fromJson(data);
  }

  Future<List<FixtureDTO>> getByCompetitionId(int id) async {
    var url =
        "${BaseProvider.baseUrl}Fixtures/get-fixtures-by-competition?competitionId=$id";

    var uri = Uri.parse(url);
    var headers = createHeaders();
    http.Response response;
    try {
      response = await http.get(uri, headers: headers);
    } on UserException {
      rethrow;
    }
    if (isValidResponse(response)) {
      var data = jsonDecode(response.body) as List;
      return data.map((e) => FixtureDTO.fromJson(e)).toList();
    } else {
      throw UserException("Unknown error.");
    }
  }
  Future<void> activateFixture(int fixtureId, bool status) async {
    var url =
        "${BaseProvider.baseUrl}Fixtures/$fixtureId/toggle-status";

    var uri = Uri.parse(url);
    var headers = createHeaders();
    final body = jsonEncode({"status": status});
    http.Response response;
    try {
      response = await http.patch(uri, headers: headers, body: body);
    } on UserException {
      rethrow;
    }
    if (isValidResponse(response)) {
    } else {
      throw UserException("Unknown error.");
    }
  }
  Future<void> finishFixture(int fixtureId) async {
    var url =
        "${BaseProvider.baseUrl}Fixtures/$fixtureId/finish-fixture";

    var uri = Uri.parse(url);
    var headers = createHeaders();
    http.Response response;
    try {
      response = await http.patch(uri, headers: headers);
    } on UserException {
      rethrow;
    }
    if (isValidResponse(response)) {
    } else {
      throw UserException("Unknown error.");
    }
  }
}