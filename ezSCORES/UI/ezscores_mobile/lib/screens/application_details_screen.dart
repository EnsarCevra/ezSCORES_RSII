import 'package:ezscores_mobile/helpers/app_loading_widget.dart';
import 'package:ezscores_mobile/models/applications.dart';
import 'package:ezscores_mobile/models/competitionsTeams.dart';
import 'package:ezscores_mobile/models/players.dart';
import 'package:ezscores_mobile/providers/CompetitionTeamsProvider.dart';
import 'package:ezscores_mobile/screens/pay_pal_screen.dart';
import 'package:ezscores_mobile/views/application_details_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class ApplicationDetailsScreen extends StatefulWidget {
  Applications application;

  ApplicationDetailsScreen({
    super.key,
    required this.application,
  });

  @override
  State<ApplicationDetailsScreen> createState() => _ApplicationDetailsScreenState();
}

class _ApplicationDetailsScreenState extends State<ApplicationDetailsScreen> {
  late CompetitionTeamsProvider competitionTeamsProvider;
  CompetitionsTeams? competitionTeam;
  Set<Players>? playersSet;

  @override
  void initState() {
    super.initState();
    competitionTeamsProvider = context.read<CompetitionTeamsProvider>();
    initForm();
  }
  void initForm() async{
    var filter = {
      "teamId" : widget.application.team!.id,
       "competitionId" : widget.application.competitionId,
       "isPlayersIncluded" : true,
       "includeDeletedRecords" : true,
       "applicationId" : widget.application.id
       };
    var competitionTeamsData = await competitionTeamsProvider.get(filter: filter);
    
    playersSet = competitionTeamsData.result.first.competitionsTeamsPlayers!
    .map((ctp) => ctp.player!)
    .toSet();
    setState(() {
      competitionTeam = competitionTeamsData.result.first;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Pregled prijave",
          style: TextStyle(fontSize: 15),
        ),
      ),
      body: competitionTeam == null ? const AppLoading() : ApplicationDetailsView(
        application: widget.application,
        competition: widget.application.competition!,
        team: widget.application.team!,
        players: playersSet!
      ),
      bottomNavigationBar: widget.application.isAccepted == true && widget.application.competition!.fee != null && widget.application.isPaId != true?
      SizedBox(
      width: double.infinity,
      height: 44,
      child: ElevatedButton(
        onPressed: () async {
          var isPaid = await Navigator.of(context).push(
                  PageRouteBuilder(
                    pageBuilder: (context, animation, secondaryAnimation) => CompetitionPaymentScreen(applicationId: widget.application.id!, competitionFee: widget.application.competition!.fee!, competitionName: widget.application.competition!.name!,),
                    transitionsBuilder: (context, animation, secondaryAnimation, child) {
                      return FadeTransition(opacity: animation, child: child);
                    },
                  ),
                );
          if(isPaid == true)
          {
            setState(() {
              widget.application.isPaId = true;
            });
          }
        },
        style: ElevatedButton.styleFrom(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.zero,
          ),
          backgroundColor: Colors.green,
          padding: EdgeInsets.zero,
        ),
        child: const Text(
          "Uplati kotizaciju",
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
        ),
      ),) : null
    );
  }
}