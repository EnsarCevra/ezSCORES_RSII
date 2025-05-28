import 'package:ezscores_desktop/models/enums/gameStage.dart';
import 'package:ezscores_desktop/providers/FixturesProvider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:ezscores_desktop/models/fixtures.dart';
import 'package:provider/provider.dart';

class FixtureDialog extends StatefulWidget {
  final int competitionId;
  final int? fixtureId;
  const FixtureDialog({super.key, required this.competitionId, this.fixtureId});

  @override
  State<FixtureDialog> createState() => _FixtureDialogState();
}

class _FixtureDialogState extends State<FixtureDialog> {
  final _formKey = GlobalKey<FormBuilderState>();
  late FixtureProvider fixtureProvider;
  Fixtures? fixture;

  @override
  void initState() {
    super.initState();
    fixtureProvider = context.read<FixtureProvider>();
    _initForm();
  }
  Future _initForm() async {
    if(widget.fixtureId != null)
    {
      fixture = await fixtureProvider.getById(widget.fixtureId!);
    }
    setState(() {
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(fixture == null ? "Dodaj kolo" : "Uredi kolo"),
      content: SizedBox(
        width: 400,
        height: 150, // Keep consistent height regardless of loading state
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          child: widget.fixtureId != null && fixture == null
              ? Column(
                  key: const ValueKey('loading'),
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    SizedBox(
                      width: 24,
                      height: 24,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    ),
                    SizedBox(height: 12),
                    Text(
                      'Učitavanje podataka...',
                      style: TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                  ],
                )
              : FormBuilder(
                  key: _formKey,
                  child: Column(
                    key: const ValueKey('form'),
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      FormBuilderDropdown<GameStage>(
                        name: "gameStage",
                        initialValue: fixture?.gameStage,
                        decoration: const InputDecoration(labelText: "Faza igre"),
                        items: GameStage.values
                            .map((stage) => DropdownMenuItem(
                                  value: stage,
                                  child: Text(stage.displayName),
                                ))
                            .toList(),
                        validator: (value) =>
                            value == null ? 'Faza igre je obavezna' : null,
                      ),
                      const SizedBox(height: 16),
                      FormBuilderTextField(
                        name: "matchLength",
                        initialValue: fixture?.matchLength?.toString() ?? '',
                        decoration: const InputDecoration(labelText: "Trajanje utakmice (min)"),
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Trajanje utakmice je obavezno';
                          }
                          final parsed = int.tryParse(value);
                          if (parsed == null || parsed <= 0) {
                            return 'Unesite važeći broj minuta';
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context, false),
          child: const Text("Odustani"),
        ),
        ElevatedButton(
          onPressed: fixture == null && widget.fixtureId != null ? null : _saveFixture,
          child: const Text("Spremi"),
        ),
      ],
    );
  }

  Future<void> _saveFixture() async {
    if (_formKey.currentState?.saveAndValidate() ?? false) {
      final formData = _formKey.currentState!.value;

      final request = {
        "competitionId" : widget.competitionId,
        "gameStage": (formData['gameStage'] as GameStage).value,
        "matchLength": int.parse(formData['matchLength']),
      };

      try {
        if (fixture == null) {
          await fixtureProvider.insert(request);
        } else {
          await fixtureProvider.update(fixture!.id!, request);
        }

        Navigator.pop(context, true);
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
              )
            ],
          ),
        );
      }
    }
  }
}
