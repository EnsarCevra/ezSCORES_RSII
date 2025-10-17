import 'dart:convert';

import 'package:ezscores_desktop/models/competitionsTeams.dart';
import 'package:ezscores_desktop/providers/CompetitionTeamsProvider.dart';
import 'package:ezscores_desktop/providers/base_provider.dart';
import 'package:ezscores_desktop/providers/utils.dart';
import 'package:flutter/material.dart';
import 'package:ezscores_desktop/models/applications.dart';
import 'package:ezscores_desktop/providers/ApplicationsProvider.dart';
import 'package:provider/provider.dart';

class ApplicationDialog extends StatefulWidget {
  final Applications application;
  const ApplicationDialog({super.key, required this.application});

  @override
  State<ApplicationDialog> createState() => _ApplicationDialogState();
}

class _ApplicationDialogState extends State<ApplicationDialog> {
  late ApplicationProvider applicationProvider;
  late CompetitionTeamsProvider competitionTeamsProvider;
  CompetitionsTeams? competitionTeam;
  late final ScrollController _playersScrollController;

  bool _isLoading = false;
  @override
  void initState() {
    super.initState();
    applicationProvider = context.read<ApplicationProvider>();
    competitionTeamsProvider = context.read<CompetitionTeamsProvider>();
    _playersScrollController = ScrollController();
    initForm();
  }
  @override
void dispose() {
  _playersScrollController.dispose();
  super.dispose();
}
  Future initForm() async{
    var filter = {
      "teamId" : widget.application.team?.id,
       "competitionId" : widget.application.competitionId,
       "isPlayersIncluded" : true,
       "includeDeletedRecords" : widget.application.isAccepted == false,//if declined players are soft deleted
       "applicationId" : widget.application.id
       };
    var competitionTeamsData = await competitionTeamsProvider.get(filter: filter);
    setState(() {
      competitionTeam = competitionTeamsData.result.first;
    });
   }
@override
Widget build(BuildContext context) {
  final applicant = widget.application.team?.user;
  final team = widget.application.team;

  return Stack(
    children: [
      AlertDialog(
        backgroundColor: Colors.white,
        title: const Text("Pregled aplikacije"),
        content: SizedBox(
          width: 800,
          height: 450,
          child: competitionTeam != null ? Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Left section
              Expanded(
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      applicant?.picture != null
                          ? CircleAvatar(
                              radius: 75,
                              backgroundImage: MemoryImage(base64Decode(applicant!.picture!)),
                            )
                          : const CircleAvatar(
                              radius: 50,
                              child: Icon(Icons.account_circle, size: 50),
                            ),
                      const SizedBox(height: 16),
                      _buildCenteredRow("Ime i prezime:",
                          "${applicant?.firstName ?? '-'} ${applicant?.lastName ?? '-'}"),
                      _buildCenteredRow("Email:", applicant?.email ?? '-'),
                      _buildCenteredRow("Telefon:", applicant?.phoneNumber ?? '-'),
                      const SizedBox(height: 25),
                      const Text("Poruka:", style: TextStyle(fontWeight: FontWeight.bold)),
                      const SizedBox(height: 6),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade100,
                          border: Border.all(color: Colors.grey.shade300),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          widget.application.message ?? "-",
                          style: const TextStyle(color: Colors.black87),
                        ),
                      ),
                      const SizedBox(height: 25),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("Kotizacija: "),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                            decoration: BoxDecoration(
                              color: widget.application.isPaId! ? Colors.green.shade600 : Colors.red.shade600,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              widget.application.isPaId! ? "Plaćena" : "Nije plaćena",
                              style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                            ),
                          ),
                          const SizedBox(width: 10,),
                          const Text("Status: "),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                            decoration: BoxDecoration(
                              color: widget.application.isAccepted != null ? (widget.application.isAccepted == true ? Colors.green.shade600 : Colors.red.shade600) : Colors.grey.shade600,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              widget.application.isAccepted != null ? (widget.application.isAccepted == true ? 'Prihvaćena' : 'Odbijena') : 'Na obradi',
                              style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 24),
              // Right section
              Expanded(
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                        team?.picture != null?
                        CircleAvatar(radius: 24,
                        backgroundImage: MemoryImage(base64Decode(team!.picture!))) : 
                        CircleAvatar(
                          backgroundColor: Colors.transparent,
                              radius: 24,
                              child: Image.asset('assets/images/team_placeholder.png',),
                            ),
                        SizedBox(width: 30,),
                        Text(
                          team?.name ?? '-',
                          style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                          ),
                      ],),
                      const SizedBox(height: 16),
                      const Text("Igrači", style: TextStyle(fontWeight: FontWeight.bold)),
                      const SizedBox(height: 8),
                      SizedBox(
                        height: 200,
                        child: Scrollbar(
                          thumbVisibility: true,
                          controller: _playersScrollController,
                          child: SingleChildScrollView(
                            controller: _playersScrollController,
                            child: DataTable(
                              columnSpacing: 16,
                              columns: const [
                                DataColumn(label: Text("Slika")),
                                DataColumn(label: Text("Ime")),
                                DataColumn(label: Text("Prezime")),
                              ],
                              rows: competitionTeam?.competitionsTeamsPlayers
                                      ?.map((player) => DataRow(
                                            cells: [
                                              DataCell(player.player?.picture != null?
                                                CircleAvatar(radius: 15,
                                                backgroundImage: MemoryImage(base64Decode(player.player!.picture!))) : 
                                                Icon(Icons.account_circle, size: 25,)
                                              ),
                                              DataCell(Text(player.player?.firstName ?? '-')),
                                              DataCell(Text(player.player?.lastName ?? '-')),
                                            ],
                                          ))
                                      .toList() ??
                                  [],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ) : Container(
            height: MediaQuery.of(context).size.height * 0.7,
            width: double.infinity,
            alignment: Alignment.center,
            child: const CircularProgressIndicator(),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text("Zatvori"),
          ),
          if(widget.application.isAccepted == null) TextButton(
            onPressed: () async => _updateStatus(false),
            child: const Text("Odbij", style: TextStyle(color: Colors.red)),
          ),
          if(widget.application.isAccepted == null) ElevatedButton(
            onPressed: () async => _updateStatus(true),
            child: const Text("Prihvati"),
          ),
        ],
      ),
      if(_isLoading)
      Container(
        color: Colors.black.withOpacity(0.5),
        child: const Center(
          child: CircularProgressIndicator(),
        ),
      ),
    ],
  );
}


Widget _buildCenteredRow(String label, String content) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 4),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("$label ", style: const TextStyle(fontWeight: FontWeight.bold)),
        Flexible(child: Text(content)),
      ],
    ),
  );
}




  Future<void> _updateStatus(bool status) async {
    setState(() {
      _isLoading = true;
    });
    try {
          await applicationProvider.toogleApplicationStatus(widget.application.id!, status);
          if(context.mounted)
          {
            showBottomRightNotification(context, "Uspješno izmijenjen status prijave!");
            Navigator.pop(context, true);
          }
        } on UserException catch (e) {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text("Greška"),
              content: Text(e.toString()),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text("OK"),
                )
              ],
            ),
          );
    }
    finally {
      if (mounted){
        setState(() {
          _isLoading = false;
        });
      }
    }
  }
}
