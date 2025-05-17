import 'dart:convert';

import 'package:ezscores_desktop/models/DTOs/groupStandingsDto.dart';
import 'package:ezscores_desktop/models/groups.dart';
import 'package:http/http.dart' as http;
import 'package:ezscores_desktop/providers/base_provider.dart';

class GroupProvider extends BaseProvider<Groups>
{
  GroupProvider(): super("Groups");

  @override
  Groups fromJson(data) {
    // TODO: implement fromJson
    return Groups.fromJson(data);
  }


  Future<List<GroupStandingsDTO>> getGroupStandings(int id) async {
    var url =
        "${BaseProvider.baseUrl}Groups/$id/get-group-standings";

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
      return data.map((e) => GroupStandingsDTO.fromJson(e)).toList();
    } else {
      throw UserException("Unknown error.");
    }
  }
}