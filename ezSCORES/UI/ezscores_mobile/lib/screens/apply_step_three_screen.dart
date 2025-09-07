import 'dart:ui';

import 'package:ezscores_mobile/dialogs/success_dialog.dart';
import 'package:ezscores_mobile/helpers/progress_bar.dart';
import 'package:ezscores_mobile/models/competitions.dart';
import 'package:ezscores_mobile/models/players.dart';
import 'package:ezscores_mobile/models/teams.dart';
import 'package:ezscores_mobile/providers/ApplicationsProvider.dart';
import 'package:ezscores_mobile/providers/utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ApplyStepThreeScreen extends StatefulWidget {
  final Competitions competition;
  final Teams selectedTeam;
  final Set<Players> selectedPlayers;

  const ApplyStepThreeScreen({
    super.key,
    required this.competition,
    required this.selectedTeam,
    required this.selectedPlayers,
  });

  @override
  State<ApplyStepThreeScreen> createState() => _ApplyStepThreeScreenState();
}

class _ApplyStepThreeScreenState extends State<ApplyStepThreeScreen> {
  late ApplicationProvider applicationProvider;
  String? message;

  @override
  void initState() {
    super.initState();
    applicationProvider = context.read<ApplicationProvider>();
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
      body: SingleChildScrollView(
        padding: EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildGeneralDetails(),
            const SizedBox(height: 20),
            const Text(
              "Odabrani igrači",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
            ),
            const SizedBox(height: 2),
            _buildTeamPlayersView(),
            const SizedBox(height: 10),
            _buildMessageInput(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green,
        onPressed: (){_confirmSubmit(context);},
        child: const Icon(Icons.send, size: 28, color: Colors.white,),
      ),
      bottomNavigationBar: const StepProgressBar(currentStep: 3,),
    );
  }

  Widget _buildGeneralDetails() {
  final textTheme = Theme.of(context).textTheme;

  return Container(
    height: 160,
    width: double.infinity,
    clipBehavior: Clip.hardEdge,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(16),
    ),
    child: Stack(
      fit: StackFit.expand,
      children: [
        Image.asset(
            "assets/images/match_bg_2.jpeg", // replace with your asset path
            fit: BoxFit.cover,
        ),
        // Blur overlay
        BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
          child: Container(
            color: Colors.black.withOpacity(0.4), // dark overlay for text readability
          ),
        ),

        // Foreground info
        Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Takmičenje:",
                style: textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
              Text(
                '${widget.competition.name} - ${widget.competition.selection?.name}',
                style: textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                "Tim:",
                style: textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 5),
              Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Container(
                      width: 40,
                      height: 40,
                      color: Colors.grey[300],
                      child: widget.selectedTeam.picture == null ||
                              widget.selectedTeam.picture!.isEmpty
                          ? const Icon(Icons.groups,
                              size: 20, color: Colors.white70)
                          : imageFromString(widget.selectedTeam.picture!),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      widget.selectedTeam.name ?? "Nepoznat tim",
                      style: textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    ),
  );
}


  Widget _buildTeamPlayersView() {
    if (widget.selectedPlayers.isEmpty) {
      return const Text("Nema odabranih igrača.");
    }

    return SizedBox(
      height: 120,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: widget.selectedPlayers.length,
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final player = widget.selectedPlayers.elementAt(index);
          return _buildMiniPlayerCard(player);
        },
      ),
    );
  }

  Widget _buildMiniPlayerCard(Players player) {
    final textTheme = Theme.of(context).textTheme;

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 2,
      child: SizedBox(
        width: 100,
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              ClipOval(
                child: Container(
                  width: 50,
                  height: 50,
                  color: Colors.grey[300],
                  child: player.picture == null || player.picture!.isEmpty
                      ? const Icon(Icons.person, size: 30, color: Colors.grey)
                      : imageFromString(player.picture!),
                ),
              ),
              const SizedBox(height: 6),
              Text(
                "${player.firstName ?? ''} ${player.lastName ?? ''}",
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: textTheme.bodySmall
                    ?.copyWith(fontWeight: FontWeight.w600, fontSize: 12),
              ),
              const SizedBox(height: 4),
              Text(
                player.birthDate != null
                    ? formatDateOnly(player.birthDate!)
                    : "Nepoznat datum",
                style: textTheme.labelSmall?.copyWith(color: Colors.grey[700]),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
  
  Widget _buildMessageInput() {
  return TextField(
    maxLines: 4,
    minLines: 2,
    decoration: InputDecoration(
      labelText: "Poruka / napomena za organizatora",
      labelStyle: TextStyle(
        color: Colors.grey[600],
        fontSize: 12,
      ),
      alignLabelWithHint: true,
      filled: true,
      fillColor: Colors.grey.shade100,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Colors.grey.shade300),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Colors.blue.shade400, width: 1.6),
      ),
      hintText: "Dodajte poruku / napomenu za organizatora...",
      hintStyle: TextStyle(
        color: Colors.grey[600],
        fontSize: 12,
      ),
    ),
    onChanged: (value) {
      setState(() {
        message = value;
      });
    },
  );
}

  void _confirmSubmit(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Potvrda"),
          content: const Text("Jeste li sigurni da želite poslati prijavu?"),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(), 
              child: const Text("Odustani"),
            ),
            TextButton(
              onPressed: () async {
                Navigator.of(context).pop();
                await _submitApplication();
              },
              child: const Text("Da"),
            ),
          ],
        );
      },
    );
  }
  
  _submitApplication() async{
    try {
      final List<int> selectedPlayerIds = widget.selectedPlayers
          .where((p) => p.id != null)
          .map((p) => p.id!)
          .toList();
      var request = {
        "teamId": widget.selectedTeam.id,
        "competitionId": widget.competition.id,
        "message": message,
        "playerIds": selectedPlayerIds
      };
      await applicationProvider.insert(request);
      if (context.mounted) {
          showDialog(
                context: context,
                barrierDismissible: false,
                builder: (_) => const SuccessPopup(message: "Uspješno ste poslali prijavu na takmičenje!"),
              );
          Future.delayed(const Duration(seconds: 2), () {
            if (context.mounted) {
              int count = 0;
              Navigator.of(context).popUntil((_) => count++ >= 3);
            }
          });
        }
    } catch (e) {
      
    }
  }

}
