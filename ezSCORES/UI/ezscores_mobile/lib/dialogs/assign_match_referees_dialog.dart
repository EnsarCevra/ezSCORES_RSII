import 'dart:convert';
import 'package:ezscores_mobile/models/DTOs/refereeDto.dart';
import 'package:ezscores_mobile/models/competitionsReferees.dart';
import 'package:ezscores_mobile/models/search_result.dart';
import 'package:ezscores_mobile/providers/CompetitionRefereeProvider.dart';
import 'package:ezscores_mobile/providers/CompetitionsRefereesMatchesProvider.dart';
import 'package:ezscores_mobile/providers/base_provider.dart';
import 'package:ezscores_mobile/providers/utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AssignRefereesDialog extends StatefulWidget {
  final int competitionId;
  final int matchId;
  final List<RefereeDTO> initiallyAssignedReferees;
  final VoidCallback onClose;

  const AssignRefereesDialog({
    super.key,
    required this.competitionId,
    required this.matchId,
    required this.initiallyAssignedReferees,
    required this.onClose
  });

  @override
  State<AssignRefereesDialog> createState() => _AssignRefereesDialogState();
}

class _AssignRefereesDialogState extends State<AssignRefereesDialog> {
  late CompetitionsRefereesProvider competitionsRefereesProvider;
  late CompeititionRefereeMatchProvider competitionsRefereesMatchesProvider;
  SearchResult<CompetitionsReferees>? competitionRefereeResult;
  Set<int?> assignedIds = {};
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    competitionsRefereesProvider = context.read<CompetitionsRefereesProvider>();
    competitionsRefereesMatchesProvider = context.read<CompeititionRefereeMatchProvider>();
    _loadReferees();
  }

  Future<void> _loadReferees() async {
    final data = await competitionsRefereesProvider.get(filter: {"competitionId": widget.competitionId});
    setState(() {
      competitionRefereeResult = data;
      assignedIds = widget.initiallyAssignedReferees.map((r) => r.competitionRefereeId).toSet();
      isLoading = false;
    });
  }

  Future<void> _assignReferee(int competitionRefereeId) async {
    final request = {
      "competitionsRefereesId": competitionRefereeId,
      "matchId": widget.matchId,
    };

    try {
      await competitionsRefereesMatchesProvider.insert(request);
      if (!mounted) return;
      setState(() {
        assignedIds.add(competitionRefereeId);
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

  @override
Widget build(BuildContext context) {
  return Dialog(
    child: ConstrainedBox(
      constraints: const BoxConstraints(
        maxWidth: 800,
        maxHeight: 600,
      ),
      child: isLoading
          ? const SizedBox(
              height: 150,
              child: Center(child: CircularProgressIndicator()),
            )
          : Padding(
              padding: const EdgeInsets.all(16),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.topRight,
                      child: ElevatedButton.icon(
                        onPressed: () {
                          Navigator.of(context).pop();
                          widget.onClose(); // notify parent
                        },
                        icon: const Icon(Icons.close),
                        label: const Text("Zatvori"),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.redAccent,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    if(assignedIds.length>=4) const Text("Ne možete više od četiri suca na jednu utakmicu!", style: TextStyle(color: Colors.red),),
                    const SizedBox(height: 10),
                    Wrap(
                      spacing: 16,
                      runSpacing: 16,
                      children: competitionRefereeResult!.result.map((competitionReferee) {
                        final isAssigned = assignedIds.contains(competitionReferee.id);
                        return Container(
                          width: 175,
                          //height: 200,
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: isAssigned ? Colors.green.shade200 : Colors.grey.shade300,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                blurRadius: 5,
                                offset: const Offset(2, 2),
                              ),
                            ],
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              CircleAvatar(
                                radius: 30,
                                backgroundColor: Colors.transparent,
                                backgroundImage: competitionReferee.referee!.picture != null
                                    ? MemoryImage(base64Decode(competitionReferee.referee!.picture!))
                                    : null,
                                child: competitionReferee.referee!.picture == null
                                    ? const Icon(Icons.account_circle, size: 50)
                                    : null,
                              ),
                              const SizedBox(height: 10),
                              Text(
                                '${competitionReferee.referee!.firstName} ${competitionReferee.referee!.lastName}',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 10),
                              ElevatedButton.icon(
                                onPressed: isAssigned
                                    ? null
                                    : assignedIds.length >= 4 ? null : () => _assignReferee(competitionReferee.id!),
                                icon: const Icon(Icons.add_circle_outline),
                                label: const Text("Dodijeli"),
                              )
                            ],
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
            ),
    ),
  );
}

}
