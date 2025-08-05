import 'dart:convert';

import 'package:ezscores_mobile/models/DTOs/adminCardsDto.dart';
import 'package:ezscores_mobile/models/competitions.dart';
import 'package:ezscores_mobile/providers/base_provider.dart';
import 'package:http/http.dart' as http;

class CompetitionProvider extends BaseProvider<Competitions>
{
  CompetitionProvider(): super("Competitions");

  @override
  Competitions fromJson(data) {
    return Competitions.fromJson(data);
  }

  Future<void> preparation(int competitionId) async {
    await _patchCompetitionStatus(competitionId, 'preparation');
  }
  Future<void> openApplications(int competitionId) async {
    await _patchCompetitionStatus(competitionId, 'applications-open');
  }

  Future<void> closeApplications(int competitionId) async {
    await _patchCompetitionStatus(competitionId, 'applications-closed');
  }

  Future<void> startCompetition(int competitionId) async {
    await _patchCompetitionStatus(competitionId, 'start-competition');
  }

  Future<void> finishCompetition(int competitionId) async {
    await _patchCompetitionStatus(competitionId, 'finish-competition');
  }

  Future<void> _patchCompetitionStatus(int id, String action) async {
    final url = "${BaseProvider.baseUrl}Competitions/$id/$action";
    final uri = Uri.parse(url);
    final headers = createHeaders();

    http.Response response;
    try {
      response = await http.patch(uri, headers: headers);
    } on UserException catch (e) {
      rethrow;
    }

    if (!isValidResponse(response)) {
      throw UserException("Neuspješna promjena statusa.");
    }
  }
  Future<AdminDashboardCardsDTO> getDashboardCardStats(int? selectedYear) async {
    final url = "${BaseProvider.baseUrl}Competitions/get-admin-dashboard-info?Year=$selectedYear";
    final uri = Uri.parse(url);
    final headers = createHeaders();

    http.Response response;
    try {
      response = await http.get(uri, headers: headers);
    } on UserException catch (e) {
      rethrow;
    }

    if (!isValidResponse(response)) {
      throw UserException("Neuspješno dohvaćanje podataka za dashboard.");
    }

    final data = jsonDecode(response.body);
    return AdminDashboardCardsDTO.fromJson(data);
  }

}