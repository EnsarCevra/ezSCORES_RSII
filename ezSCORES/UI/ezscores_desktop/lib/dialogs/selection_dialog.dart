import 'package:ezscores_desktop/models/selections.dart';
import 'package:ezscores_desktop/providers/SelectionProvider.dart';
import 'package:ezscores_desktop/providers/base_provider.dart';
import 'package:ezscores_desktop/providers/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:provider/provider.dart';

class SelectionDialog extends StatefulWidget {
  Selections? selection;
  SelectionDialog({super.key, this.selection});

  @override
  State<SelectionDialog> createState() => _SelectionDialogState();
}

class _SelectionDialogState extends State<SelectionDialog> {
  final _formKey = GlobalKey<FormBuilderState>();
  late SelectionProvider selectionProvider;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    selectionProvider = context.read<SelectionProvider>();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.selection == null ? "Dodaj selekciju" : "Uredi selekciju"),
      content: SizedBox(
        width: 300,
        child: FormBuilder(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              FormBuilderTextField(
                name: "name",
                initialValue: widget.selection?.name ?? "",
                decoration: const InputDecoration(labelText: "Naziv"),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Unesite naziv";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              FormBuilderTextField(
                name: "ageMax",
                initialValue: widget.selection?.ageMax?.toString() ?? "",
                decoration: const InputDecoration(labelText: "Max. godine"),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Unesite maksimalne godine";
                  }
                  if (int.tryParse(value) == null) {
                    return "Unesite ispravan broj";
                  }
                  return null;
                },
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context, false), // False = no reload needed
          child: const Text("Otkaži"),
        ),
        ElevatedButton(
          onPressed: () async {
            if (_formKey.currentState?.saveAndValidate() ?? false) {
              var request = Map.from(_formKey.currentState!.value);
              try
              {
                if (widget.selection == null) 
                {
                  await selectionProvider.insert( request);
                }
                else 
                {
                  await selectionProvider.update(widget.selection!.id!, request);
                }
              }on UserException catch(exception)
              {
                showDialog(
                   context: context, 
                   builder: (context) => AlertDialog(
                     title: Text("Error"), 
                     actions: [TextButton(onPressed: () => Navigator.pop(context), child: Text("Ok"))], 
                     content: Text(exception.toString()),));
              }
              if(context.mounted)
              {
                widget.selection == null ? showSuccessSnackBar(context, 'Selekcija uspješno dodana.') : showSuccessSnackBar(context, 'Selekcija uspješno ažurirana.');
                Navigator.pop(context, true); 
              }
            }
          },
          child: const Text("Spremi"),
        ),
      ],
    );
  }
}
