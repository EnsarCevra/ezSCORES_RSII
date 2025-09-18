import 'dart:convert';

import 'package:ezscores_mobile/models/applications.dart';
import 'package:ezscores_mobile/providers/base_provider.dart';
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
    } on UserException {
      rethrow;
    }
    if (isValidResponse(response)) {
      var data = jsonDecode(response.body);
      return fromJson(data);
    } else {
      throw UserException("Unknown error.");
    }
  }

  Future<void> validateTeam([dynamic request]) async {
    var url = "${BaseProvider.baseUrl}Applications/validate-team";
    var uri = Uri.parse(url);
    var headers = createHeaders();
    
    var jsonRequest = jsonEncode(request);

    http.Response response;
    try {
      response = await http.post(uri, headers: headers, body: jsonRequest);
    } on UserException {
      rethrow;
    }

    if (!isValidResponse(response)) {
      throw UserException("Unknown error while validating team.");
    }
  }
  Future<void> validatePlayers([dynamic request]) async {
    var url = "${BaseProvider.baseUrl}Applications/validate-players";
    var uri = Uri.parse(url);
    var headers = createHeaders();
    
    var jsonRequest = jsonEncode(request);

    http.Response response;
    try {
      response = await http.post(uri, headers: headers, body: jsonRequest);
    } on UserException {
      rethrow;
    }

    if (!isValidResponse(response)) {
      throw UserException("Unknown error while validating players.");
    }
  }
  Future<Applications> makePayment(int id, dynamic request) async {
    var url = "${BaseProvider.baseUrl}Applications/$id/make-payment";
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
      var data = jsonDecode(response.body);
      return fromJson(data);
    } else {
      throw UserException("Unknown error.");
    }
  }
}