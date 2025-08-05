import 'package:ezscores_mobile/models/DTOs/groupDto.dart';
import 'package:ezscores_mobile/models/groups.dart';
import 'package:ezscores_mobile/models/search_result.dart';
import 'package:ezscores_mobile/providers/GroupsProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SelectGroupDialog extends StatefulWidget {
  final int competitionId;
  final int? initiallySelectedGroupId;

  const SelectGroupDialog({
    super.key,
    required this.competitionId,
    this.initiallySelectedGroupId,
  });

  @override
  State<SelectGroupDialog> createState() => _SelectGroupDialogState();
}

class _SelectGroupDialogState extends State<SelectGroupDialog> {
  late GroupProvider groupsProvider;
  SearchResult<Groups>? groupsResult;
  Groups? selectedGroup;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    groupsProvider = context.read<GroupProvider>();
    _loadGroups();
  }

  Future<void> _loadGroups() async {
    final data = await groupsProvider.get(filter: {"competitionId": widget.competitionId});
    setState(() {
      groupsResult = data;
      if (widget.initiallySelectedGroupId != null) {
        selectedGroup = data.result.firstWhere(
          (g) => g.id == widget.initiallySelectedGroupId
        );
      }
      isLoading = false;
    });
  }

  void _selectGroup(Groups group) {
    setState(() {
      selectedGroup = group;
    });
  }

  void _save() {
    if (selectedGroup != null && selectedGroup!.id != null) {
      Navigator.of(context).pop(GroupDTO(id: selectedGroup?.id, name: selectedGroup?.name));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Molimo odaberite grupu.")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 700, maxHeight: 600),
        child: isLoading
            ? const SizedBox(
                height: 150,
                child: Center(child: CircularProgressIndicator()),
              )
            : Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Text(
                      "Odaberite grupu",
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 16),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Wrap(
                          spacing: 16,
                          runSpacing: 16,
                          children: groupsResult!.result.map((group) {
                            final isSelected = selectedGroup?.id == group.id;
                            return GestureDetector(
                              onTap: () => _selectGroup(group),
                              child: Container(
                                width: 180,
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: isSelected ? Colors.lightBlue[100] : Colors.grey.shade200,
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                    color: isSelected ? Colors.blue : Colors.grey.shade400,
                                    width: 2,
                                  ),
                                ),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const Icon(Icons.group, size: 36, color: Colors.grey),
                                    const SizedBox(height: 10),
                                    Text(
                                      group.name ?? "Nepoznata grupa",
                                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        ElevatedButton.icon(
                          onPressed: _save,
                          icon: const Icon(Icons.check),
                          label: const Text("Odaberi"),
                        ),
                      ],
                    )
                  ],
                ),
              ),
      ),
    );
  }
}
