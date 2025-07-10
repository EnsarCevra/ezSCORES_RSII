import 'dart:convert';
import 'package:ezscores_desktop/providers/StadiumsProvider.dart';
import 'package:flutter/material.dart';
import 'package:ezscores_desktop/models/search_result.dart';
import 'package:ezscores_desktop/models/stadiums.dart';
import 'package:provider/provider.dart';

class SelectStadiumDialog extends StatefulWidget {
  final int competitionId;
  final Stadiums? initiallySelectedStadium;

  const SelectStadiumDialog({
    super.key,
    required this.competitionId,
    this.initiallySelectedStadium,
  });

  @override
  State<SelectStadiumDialog> createState() => _SelectStadiumDialogState();
}

class _SelectStadiumDialogState extends State<SelectStadiumDialog> {
  late StadiumProvider stadiumProvider;
  SearchResult<Stadiums>? stadiumsResult;
  Stadiums? selectedStadium;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    stadiumProvider = context.read<StadiumProvider>();
    _loadStadiums();
  }

  Future<void> _loadStadiums() async {
    final data = await stadiumProvider.get(filter: {"competitionId": widget.competitionId});
    setState(() {
      stadiumsResult = data;
      selectedStadium = data.result.firstWhere(
        (s) => s.id == widget.initiallySelectedStadium?.id
      );
      isLoading = false;
    });
  }

  void _selectStadium(Stadiums stadium) {
    setState(() {
      selectedStadium = stadium;
    });
  }

  void _save() {
    if (selectedStadium != null && selectedStadium!.id != null) {
      Navigator.of(context).pop(selectedStadium);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Molimo odaberite stadion.")),
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
                      "Odaberite stadion",
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 16),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Wrap(
                          spacing: 16,
                          runSpacing: 16,
                          children: stadiumsResult!.result.map((stadium) {
                            final isSelected = selectedStadium?.id == stadium.id;
                            final image = stadium.picture != null && stadium.picture!.isNotEmpty
                                ? MemoryImage(base64Decode(stadium.picture!))
                                : null;

                            return GestureDetector(
                              onTap: () => _selectStadium(stadium),
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
                                    CircleAvatar(
                                      radius: 30,
                                      backgroundImage: image,
                                      child: image == null
                                          ? const Icon(Icons.stadium, size: 32, color: Colors.grey)
                                          : null,
                                    ),
                                    const SizedBox(height: 10),
                                    Text(
                                      stadium.name ?? "Nepoznat stadion",
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
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text("Zatvori"),
                        ),
                        const SizedBox(width: 10),
                        ElevatedButton.icon(
                          onPressed: _save,
                          icon: const Icon(Icons.check),
                          label: const Text("Spremi"),
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

