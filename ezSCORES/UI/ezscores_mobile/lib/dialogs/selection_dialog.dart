import 'package:ezscores_mobile/models/selections.dart';
import 'package:ezscores_mobile/providers/SelectionProvider.dart';
import 'package:ezscores_mobile/providers/base_provider.dart';
import 'package:ezscores_mobile/providers/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
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
        width: 350,
        child: FormBuilder(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              FormBuilderTextField(
                name: "name",
                initialValue: widget.selection?.name ?? "",
                decoration: const InputDecoration(labelText: "Naziv"),
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator:  FormBuilderValidators.compose(
                  [
                    FormBuilderValidators.match(
                      r'^[A-ZČĆŽŠĐ][a-zčćžšđA-ZČĆŽŠĐ]*$',
                      errorText: 'Naziv mora početi velikim slovom i sadržavati samo slova'
                    ),
                    FormBuilderValidators.required(errorText: 'Naziv je obavezan'),
                    FormBuilderValidators.minLength(3, errorText: 'Naziv mora imati barem 3 slova'),
                  ]),
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
                widget.selection == null ? showBottomRightNotification(context, 'Selekcija uspješno dodana.') : showBottomRightNotification(context, 'Selekcija uspješno ažurirana.');
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
