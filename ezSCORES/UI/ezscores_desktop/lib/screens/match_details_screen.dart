import 'dart:convert';
import 'package:ezscores_desktop/dialogs/assign_match_referees_dialog.dart';
import 'package:ezscores_desktop/dialogs/competitionTeam_match_upsert_dialog.dart';
import 'package:ezscores_desktop/dialogs/goal_upsert_dialog.dart';
import 'package:ezscores_desktop/dialogs/match_select_group_dialog.dart';
import 'package:ezscores_desktop/dialogs/match_stadium_upsert_dialog.dart';
import 'package:ezscores_desktop/layouts/master_screen.dart';
import 'package:ezscores_desktop/models/DTOs/fixtureDto.dart';
import 'package:ezscores_desktop/models/DTOs/goalDto.dart';
import 'package:ezscores_desktop/models/DTOs/groupDto.dart';
import 'package:ezscores_desktop/models/DTOs/matchDto.dart';
import 'package:ezscores_desktop/models/DTOs/playerDto.dart';
import 'package:ezscores_desktop/models/DTOs/teamDto.dart';
import 'package:ezscores_desktop/models/enums/gameStage.dart';
import 'package:ezscores_desktop/models/stadiums.dart';
import 'package:ezscores_desktop/providers/CompetitionRefereeProvider.dart';
import 'package:ezscores_desktop/providers/CompetitionsRefereesMatchesProvider.dart';
import 'package:ezscores_desktop/providers/GoalProvider.dart';
import 'package:ezscores_desktop/providers/MatchesProvider.dart';
import 'package:ezscores_desktop/providers/base_provider.dart';
import 'package:ezscores_desktop/providers/utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MatchDetailsScreen extends StatefulWidget {
  int competitionId;
  int? matchID;
  FixtureDTO fixture;
  MatchDetailsScreen({super.key, this.matchID, required this.fixture, required this.competitionId});

  @override
  State<MatchDetailsScreen> createState() => _MatchDetailsScreenState();
}

class _MatchDetailsScreenState extends State<MatchDetailsScreen> {
  late MatchesProvider matchesProvider;
  late CompetitionsRefereesProvider competitionsRefereesProvider;
  late CompeititionRefereeMatchProvider compeititionRefereeMatchProvider;
  late GoalProvider goalProvider;
  DateTime? _selectedDateTime;
  MatchDTO? match;
  GroupDTO? selectedGroup;
  TeamDTO? selectedHomeTeam;
  TeamDTO? selectedAwayTeam;
  Stadiums? selectedStadium;

  bool _validationErrorNotifier = false;
  Color getFieldColor(bool isValid) => (!_validationErrorNotifier || isValid) ? Colors.white : Colors.red;

  @override
  void initState() {
    matchesProvider = context.read<MatchesProvider>();
    competitionsRefereesProvider = context.read<CompetitionsRefereesProvider>();
    compeititionRefereeMatchProvider = context.read<CompeititionRefereeMatchProvider>();
    goalProvider = context.read<GoalProvider>();
    super.initState();
    initForm();
  }
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if(widget.matchID == null && widget.fixture.gameStage == GameStage.groupPhase)
    {
      Future.microtask(() => _displayGroupSelection());
    }
  }
  Future initForm() async {
    if (widget.matchID != null) {
      await _loadMatch(widget.matchID!);
    }
    if(mounted)
    {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.matchID != null && match == null) {
      return MasterScreen(
        "Detalji utakmice",
        selectedIndex: 1,
        const Center(child: CircularProgressIndicator()),
      );
    }

    return MasterScreen(
      "Detalji utakmice",
      selectedIndex: 1,
      SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(50.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildMainInfo(),
              const SizedBox(height: 16),
              if(match != null) _buildPlayerData(),//display additional data when match already created
              const SizedBox(height: 16),
              if(match == null) _buildSaveButton(),//manual save only when creating match
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMainInfo() {
    final bool isFinished = match?.isCompleted ?? false;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        image: const DecorationImage(
          image: AssetImage('assets/images/match_bg_3.jpeg'),
          fit: BoxFit.cover,
          opacity: 0.95,
        ),
        border: Border.all(color: Colors.grey.shade400, width: 1.5),
        borderRadius: BorderRadius.circular(12),
        color: Colors.white.withOpacity(0.8),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "${widget.fixture.gameStage!.displayName}"
                "${(widget.fixture.gameStage == GameStage.league || widget.fixture.gameStage == GameStage.groupPhase) ? " • ${widget.fixture.sequenceNumber! + 1}. kolo" : ""}"
                 "${widget.fixture.gameStage == GameStage.groupPhase ? " • ${match != null ? match!.group?.name : selectedGroup != null ? selectedGroup?.name : '[Odaberite grupu]'}" : ""}",
                style: const TextStyle(color: Colors.white, fontSize: 20),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              MouseRegion(
                cursor: SystemMouseCursors.click,
                child: GestureDetector(
                  onTap: () async {
                    final selectedTeam = await showDialog<TeamDTO>(
                      context: context,
                      builder: (context) => TeamSelectionDialog(
                        competitionId: widget.competitionId,
                        gameStage: widget.fixture.gameStage!,
                        competitionTeamId: match != null ? match!.homeTeam!.id : selectedHomeTeam?.id,
                        oposingCompetitionTeamId: match != null ? match!.awayTeam!.id : selectedAwayTeam?.id,
                        group: match != null ? match!.group : selectedGroup,
                      ),
                    );
                    if(match != null)
                    {
                      if (selectedTeam != null && selectedTeam.id != match?.homeTeam?.id) {
                        updateMatch(widget.fixture.id!, selectedTeam.id!, match!.awayTeam!.id!, match!.stadium!.id!, match!.dateAndTime!);                        
                      }
                    }
                    else
                    {
                      setState(() {
                        selectedHomeTeam = selectedTeam;
                      });
                    }
                  },
                  child: Row(
                    children: [
                      Text(
                        match != null ? match!.homeTeam!.name! : selectedHomeTeam != null ? selectedHomeTeam!.name! : '[Odaberite domaćina]',
                        style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: getFieldColor(selectedHomeTeam != null)),
                      ),
                      const SizedBox(width: 4),
                      const Icon(Icons.edit, size: 20, color: Colors.white),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Text(
                isFinished || match?.isUnderway == true
                    ? "${match?.homeTeamScore} : ${match?.awayTeamScore}"
                    : "- : -",
                style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.white),
              ),
              const SizedBox(width: 8),
              MouseRegion(
                cursor: SystemMouseCursors.click,
                child: GestureDetector(
                  onTap: () async{
                    final selectedTeam = await showDialog<TeamDTO>(
                      context: context,
                      builder: (context) => TeamSelectionDialog(
                        competitionId: widget.competitionId,
                        gameStage: widget.fixture.gameStage!,
                        competitionTeamId: match != null ? match!.awayTeam!.id : selectedAwayTeam?.id,
                        oposingCompetitionTeamId: match != null ? match!.homeTeam!.id : selectedHomeTeam?.id,
                        group: match != null ? match!.group : selectedGroup,
                      ),
                    );
                    if(match != null)
                    {
                      if (selectedTeam != null && selectedTeam.id != match?.awayTeam?.id) {
                        updateMatch(widget.fixture.id!, match!.homeTeam!.id!, selectedTeam.id!, match!.stadium!.id!, match!.dateAndTime!);                        
                      }
                    }
                    else
                    {
                      setState(() {
                        selectedAwayTeam = selectedTeam;
                      });
                    }
                  },
                  child: Row(
                    children: [
                      Text(
                        match != null ? match!.awayTeam!.name! : selectedAwayTeam != null ? selectedAwayTeam!.name! : '[Odaberite gosta]',
                        style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: getFieldColor(selectedAwayTeam != null)),
                      ),
                      const SizedBox(width: 4),
                      const Icon(Icons.edit, size: 20, color: Colors.white),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              MouseRegion(
                cursor: SystemMouseCursors.click,
                child: GestureDetector(
                  onTap: _pickDateTime,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.calendar_today, size: 20, color: Colors.white.withOpacity(0.8)),
                      const SizedBox(width: 6),
                      Text(
                        match != null ? formatDateTime(match!.dateAndTime) : _selectedDateTime != null ? formatDateTime(_selectedDateTime) : '[Odaberite datum]',
                        style: TextStyle(color: getFieldColor(_selectedDateTime != null), fontSize: 20),
                      ),
                      const SizedBox(width: 4),
                      const Icon(Icons.edit, size: 18, color: Colors.white),
                    ],
                  ),
                ),
              ),
              const Text(" • • • ", style: TextStyle(color: Colors.white, fontSize: 20)),
              MouseRegion(
              cursor: SystemMouseCursors.click,
              child: GestureDetector(
                onTap: () async {
                  final selectedStadium = await showDialog<Stadiums>(
                    context: context,
                    builder: (context) => SelectStadiumDialog(
                      competitionId: widget.competitionId,
                      initiallySelectedStadium: match != null ? match?.stadium : this.selectedStadium,
                    ),
                  );

                  if (selectedStadium != null) {
                    if(match != null)
                    {
                      match?.stadium = selectedStadium;
                      updateMatch(widget.fixture.id!, match!.homeTeam!.id!, match!.awayTeam!.id!, selectedStadium.id!, match!.dateAndTime!);
                    }
                    else
                    {
                      setState(() {
                        this.selectedStadium = selectedStadium;
                      });
                    }
                  }
                },
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.stadium, size: 20, color: Colors.white),
                    const SizedBox(width: 4),
                    Text(
                     match != null ?  match!.stadium!.name! : selectedStadium != null ? selectedStadium!.name! : '[Odaberite stadion]',  
                      style: TextStyle(color: getFieldColor(selectedStadium != null), fontSize: 20),
                    ),
                    const SizedBox(width: 4),
                    const Icon(Icons.edit, size: 18, color: Colors.white),
                  ],
                ),
              ),
            ),

            ],
          ),
          const SizedBox(height: 8),
          if ((isFinished || match?.isUnderway == true) && match?.goals != null) ...[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: _strikersList(match!.goals!),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: (){
                    showGoalUpsertDialog(
                              context: context,
                              matchId: match!.matchId!,
                              competitionTeamId: match!.homeTeam!.id!,
                              isHomeGoal: true,
                              goal: null,
                              onSuccess: (){initForm();}
                            );
                  },
                  style: const ButtonStyle(backgroundColor: MaterialStatePropertyAll(Colors.green)),
                  child: const Text("Novi pogodak domaćina"),
                ),
                ElevatedButton(
                  onPressed: (){
                    showGoalUpsertDialog(
                              context: context,
                              matchId: match!.matchId!,
                              competitionTeamId: match!.awayTeam!.id!,
                              isHomeGoal: false,
                              goal: null,
                              onSuccess: (){initForm();}
                            );
                  },
                  style: const ButtonStyle(backgroundColor: MaterialStatePropertyAll(Colors.green)),
                  child: const Text("Novi pogodak gosta")),
              ],
            )
          ],
        ],
      ),
    );
  }

  Widget _buildPlayerData() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Flexible(
          flex: 1,
          child: _playersList("Igrači domaćina", match?.homeTeam?.players, true),
        ),
        Flexible(
          flex: 1,
          child: _referees(),
        ),
        Flexible(
          flex: 1,
          child: _playersList("Igrači gosta", match?.awayTeam?.players, false),
        ),
      ],
    );
  }

  Widget _playersList(String title, List<PlayerDTO>? players, bool isHomeList) {
  return Padding(
    padding: const EdgeInsets.all(20.0),
    child: Column(
      crossAxisAlignment: isHomeList ? CrossAxisAlignment.start : CrossAxisAlignment.end,
      children: [
        Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        if (players != null && players.isNotEmpty)
          ...players.map(
            (player) => Container(
              constraints: const BoxConstraints(minHeight: 50),
              margin: const EdgeInsets.symmetric(vertical: 4),
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(10),
              ),
              alignment: isHomeList ? Alignment.centerLeft : Alignment.centerRight,
              child: Text(
                player.name ?? "",
                textAlign: isHomeList ? TextAlign.left : TextAlign.right,
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
          )
        else
          Text(
            "Nema igrača",
            style: TextStyle(color: Colors.grey.shade600),
          ),
      ],
    ),
  );
}



  Widget _buildSaveButton() {
    return Align(
      alignment: Alignment.bottomRight,
      child: ElevatedButton(
        onPressed: _save,
        child: const Text("Spremi"),
      ),
    );
  }

  Widget _referees() {
    final referees = match?.referees ?? [];

    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            "Sudski arbitar",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          if (referees.isNotEmpty)
            ...referees.map(
              (ref) => Container(
                constraints: const BoxConstraints(minHeight: 50),
                margin: const EdgeInsets.symmetric(vertical: 4),
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(ref.name!, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                    IconButton(
                      icon: const Icon(Icons.remove_circle_outline, color: Colors.red),
                      tooltip: "Ukloni sudiju",
                      onPressed: () => _unassignReferee(ref.id!),
                    ),
                  ],
                ),
              ),
            )
          else
            const Text("Nema dodijeljenih sudija."),
          const SizedBox(height: 12),
          ElevatedButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (_) => AssignRefereesDialog(
                  competitionId: widget.competitionId,
                  matchId: match!.matchId!,
                  initiallyAssignedReferees: match!.referees!,
                  onClose: () {
                    setState(() {
                      initForm();
                    });
                  },
                ),
              );
            },
            child: const Text("Dodijeli"),
          ),
        ],
      ),
    );
  }

  Widget _strikersList(List<GoalDTO> goals) {
    return Column(
      children: goals.map((goal) {
        final minute = goal.scoredAtMinute != null ? "${goal.scoredAtMinute}'" : "";
        final strikerText = goal.scorer != null ? "⚽$minute ${goal.scorer}" : "⚽$minute Nepoznat strijelac";
        final isLeft = goal.isHomeGoal!;
        return Row(
          mainAxisAlignment: isLeft ? MainAxisAlignment.start : MainAxisAlignment.end,
          children: [
            Container(
              margin: const EdgeInsets.symmetric(vertical: 4.0),
              padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
              decoration: BoxDecoration(
                color: Colors.grey.shade600,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(strikerText, style: const TextStyle(color: Colors.white)),
                  const SizedBox(width: 8),
                  MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: Tooltip(
                      message: "Uredi",
                      child: GestureDetector(
                        onTap: () {
                          showGoalUpsertDialog(
                            context: context,
                            matchId: match!.matchId!,
                            competitionTeamId: goal.isHomeGoal == true ? match!.homeTeam!.id! : match!.awayTeam!.id!,
                            isHomeGoal: goal.isHomeGoal!,
                            goal: goal,
                            onSuccess: (){initForm();}
                          );
                        },
                        child: const Icon(
                          Icons.edit,
                          size: 16,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10,),
                  MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: Tooltip(
                      message: "Ukloni",
                      child: GestureDetector(
                        onTap: () {
                          _deleteGoal(goal.id!);
                        },
                        child: const Icon(
                          Icons.delete,
                          size: 16,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      }).toList(),
    );
  }

  Widget _teamLogo(String? base64Image) {
    if (base64Image == null || base64Image.isEmpty) {
      return const SizedBox(width: 40, height: 40);
    }

    return Image.memory(
      base64Decode(base64Image),
      width: 40,
      height: 40,
      fit: BoxFit.cover,
    );
  }

  void _save() async{
    //first validate if every field is inserted
    //if not then display it in red color
    if(selectedHomeTeam == null || selectedAwayTeam == null || selectedStadium == null || _selectedDateTime == null)
    {
      setState(() {
        _validationErrorNotifier = true;
      });
      showErrorBottomNotification(context, 'Morate popuniti sva polja');
    }
    //after validation is completed and if input is valid create request
    else
    {
      try {
         final request = {
           "fixtureId": widget.fixture.id,
           "homeTeamId": selectedHomeTeam?.id,
           "awayTeamId": selectedAwayTeam?.id,
           "stadiumId": selectedStadium?.id,
           "dateAndTime": _selectedDateTime!.toIso8601String(),
         };
         var newMatch = await matchesProvider.insert(request);
         showBottomRightNotification(context, 'Uspjesno kreirana utakmica');
         await _loadMatch(newMatch.id!);
         setState(() {
         });
       } catch (e) {
         showDialog(
           context: context,
           builder: (context) => AlertDialog(
             title: const Text("Greška"),
             content: Text(e.toString()),
             actions: [
               TextButton(
                 onPressed: () => Navigator.pop(context),
                 child: const Text("OK"),
               ),
             ],
           ),
         );
       }
    }
    //should we allow user to switch groups after creating the match?
  }

  Future<void> _unassignReferee(int competitionRefereeMatchId) async {
    try {
      await compeititionRefereeMatchProvider.delete(competitionRefereeMatchId);
      if (!mounted) return;
      setState(() {
        initForm();
      });
      showBottomRightNotification(context, "Uspješno dodijeljen sudac");
    } on UserException catch (e) {
      if (!mounted) return;
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: const Text("Greška"),
          content: Text(e.toString()),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("OK"),
            ),
          ],
        ),
      );
    }
  }

  void _deleteGoal (int goalId) async{
    bool confirmed = await showConfirmDeleteDialog(context, content: 'Jeste li sigurni da želite izbrisati ovaj pogodak?');
    if(confirmed)
    {
      try {
      await goalProvider.delete(goalId);
      if(context.mounted)
      {
        showBottomRightNotification(context, 'Pogodak uspješno obrisan');
        initForm();
      }
      } catch (e) {
        showDialog(
          context: context, 
          builder: (context) => AlertDialog(
          title: const Text("Error"), 
          actions: [TextButton(onPressed: () => Navigator.pop(context), child: Text("Ok"))], 
          content: Text(e.toString()),));
      }
    }
    }

  Future<void> showGoalUpsertDialog({
  required BuildContext context,
  required int matchId,
  required int competitionTeamId,
  required bool isHomeGoal,
  required GoalDTO? goal,
  required VoidCallback onSuccess,
}) async {
  final result = await showDialog<bool>(
    context: context,
    builder: (context) => GoalUpsertDialog(
      matchId: matchId,
      competitionTeamId: competitionTeamId,
      isHomeGoal: isHomeGoal,
      goal: goal,
    ),
  );

  if (result == true) {
    onSuccess();
  }
}
Future<void> _pickDateTime() async {
  final currentDateTime = _selectedDateTime ?? DateTime.now();

  final DateTime? pickedDate = await showDatePicker(
    context: context,
    initialDate: currentDateTime,
    firstDate: DateTime(2025),
    lastDate: DateTime(2100),
  );

  if (pickedDate == null) return;

  final TimeOfDay? pickedTime = await showTimePicker(
    context: context,
    initialTime: TimeOfDay.fromDateTime(currentDateTime),
  );

  if (pickedTime == null) return;

  setState(() {
    _selectedDateTime = DateTime(
      pickedDate.year,
      pickedDate.month,
      pickedDate.day,
      pickedTime.hour,
      pickedTime.minute,
    );
  });
  if(match != null)
    {
      updateMatch(widget.fixture.id!, match!.homeTeam!.id!, match!.awayTeam!.id!, match!.stadium!.id!, _selectedDateTime!);
    }
}

  void updateMatch(int fixtureId, int homeTeamId, int awayTeamId, int stadiumId, DateTime dateAndTime) async {
    if(match != null)
    {
      try {
         final request = {
           "fixtureId": fixtureId,
           "homeTeamId": homeTeamId,
           "awayTeamId": awayTeamId,
           "stadiumId": stadiumId,
           "dateAndTime": dateAndTime.toIso8601String(),
         };
         await matchesProvider.update(match!.matchId!, request);
         initForm();
       } catch (e) {
         showDialog(
           context: context,
           builder: (context) => AlertDialog(
             title: const Text("Greška"),
             content: Text(e.toString()),
             actions: [
               TextButton(
                 onPressed: () => Navigator.pop(context),
                 child: const Text("OK"),
               ),
             ],
           ),
         );
       }
    }
  }
  
  Future<void> _displayGroupSelection() async{
    final selectedGroup = await showDialog<GroupDTO>(
      context: context,
      builder: (context) => SelectGroupDialog(
        competitionId: widget.competitionId,
        initiallySelectedGroupId: this.selectedGroup?.id,)
    );
    if (selectedGroup != null)
    {
      setState(() {
        this.selectedGroup = selectedGroup;
      });
    }
  }
  
  Future<void> _loadMatch(int matchID) async {
    this.match = await matchesProvider.getMatchDetails(matchID);
    _selectedDateTime = match?.dateAndTime;
    if (match!.goals!.isNotEmpty == true) {
      match!.homeTeamScore = match!.goals!.where((e) => e.isHomeGoal == true).length;
      match!.awayTeamScore = match!.goals!.where((e) => e.isHomeGoal == false).length;
    }
  }
}