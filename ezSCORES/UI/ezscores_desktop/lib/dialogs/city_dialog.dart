import 'package:ezscores_desktop/models/cities.dart';
import 'package:ezscores_desktop/providers/CitiesProvider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:provider/provider.dart';

class CityDialog extends StatefulWidget {
  final Cities? city;
  const CityDialog({super.key, this.city});

  @override
  State<CityDialog> createState() => _CityDialogState();
}

class _CityDialogState extends State<CityDialog> {
  final _formKey = GlobalKey<FormBuilderState>();
  late CityProvider cityProvider;

  @override
  void initState() {
    super.initState();
    cityProvider = context.read<CityProvider>();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.city == null ? "Dodaj grad" : "Uredi grad"),
      content: SizedBox(
        width: 400,
        child: FormBuilder(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              FormBuilderTextField(
                name: "name",
                initialValue: widget.city?.name ?? '',
                decoration: InputDecoration(labelText: "Naziv"),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Naziv je obavezan';
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
          onPressed: () => Navigator.pop(context, false),
          child: Text("Odustani"),
        ),
        ElevatedButton(
          onPressed: _saveCity,
          child: Text("Spremi"),
        ),
      ],
    );
  }

  Future<void> _saveCity() async {
    if (_formKey.currentState?.saveAndValidate() ?? false) {
      var request = Map.from(_formKey.currentState!.value);
      try {
        if (widget.city == null) {
          await cityProvider.insert(request);
        } else {
          await cityProvider.update(widget.city!.id!, request);
        }
        Navigator.pop(context, true); // reload list
      } catch (e) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text("Greška"),
            content: Text(e.toString()),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text("OK"),
              )
            ],
          ),
        );
      }
    }
  }
}
