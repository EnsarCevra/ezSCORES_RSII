import 'dart:convert';
import 'dart:io';

import 'package:ezscores_mobile/models/stadiums.dart';
import 'package:ezscores_mobile/providers/StadiumsProvider.dart';
import 'package:ezscores_mobile/providers/base_provider.dart';
import 'package:ezscores_mobile/providers/utils.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:provider/provider.dart';

class StadiumDialog extends StatefulWidget {
  Stadiums? stadium;
  StadiumDialog({super.key, this.stadium});

  @override
  State<StadiumDialog> createState() => _StadiumDialogState();
}

class _StadiumDialogState extends State<StadiumDialog> {
  final _formKey = GlobalKey<FormBuilderState>();
  late StadiumProvider stadiumProvider;
  String? _base64Image;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    stadiumProvider = context.read<StadiumProvider>();
  }
   @override
  void initState() {
    super.initState();
    initForm();
  }

  Future initForm() async{
    setState(() {
      _base64Image = widget.stadium?.picture;
    });
   }
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.stadium == null ? "Dodaj stadion" : "Uredi stadion"),
      content: SizedBox(
        width: 350,
        child: FormBuilder(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              FormBuilderTextField(
                name: "name",
                initialValue: widget.stadium?.name ?? "",
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
              Row(
                children: [
                  Expanded(
                    child: FormBuilderField<String>(
                      name: "imageId",
                      builder: (field) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            InputDecorator(
                              decoration: InputDecoration(
                                labelText: "Odaberite sliku",
                                errorText: field.errorText,
                              ),
                              child: Column(
                                children: [
                                    Padding(
                                      padding: const EdgeInsets.only(bottom: 8.0),
                                      child: ClipOval(
                                        child: _base64Image != null ?
                                       Image.memory(
                                        base64Decode(_base64Image!),
                                        width: 200,
                                        height: 200,
                                        fit: BoxFit.cover,
                                      ) :
                                      Icon(Icons.stadium, size: 150,)
                                    ),),
                                      
                                  ListTile(
                                    leading: Icon(Icons.image, weight: 50,),
                                    title: Text(_base64Image == null ? "Odaberi sliku" : "Promijeni sliku"),
                                    trailing: Icon(Icons.file_upload),
                                    onTap: () async {
                                      final result = await getImage(); 
                                      if (result != null) {
                                        field.didChange(result);
                                        setState(() {
                                          _base64Image = result;
                                        });
                                      }
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  )
                ],
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
              request["picture"] = _base64Image;
              try {
                if (widget.stadium == null) {
                  await stadiumProvider.insert(request);
                } else {
                  await stadiumProvider.update(widget.stadium!.id!, request);
                }
              } on UserException catch (exception) {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text("Error"),
                    actions: [
                      TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text("Ok")),
                    ],
                    content: Text(exception.toString()),
                  ),
                );
              }
              if (context.mounted) {
                widget.stadium == null
                    ? showBottomRightNotification(context, 'Stadion uspješno dodan.')
                    : showBottomRightNotification(context, 'Stadion uspješno ažuriran.');
                Navigator.pop(context, true);
              }
            }
          },
          child: const Text("Spremi"),
        ),
      ],
    );
  }

  File? _image;
  Future<String?> getImage() async{
        var result = await FilePicker.platform.pickFiles(type: FileType.image);

        if(result != null && result.files.single.path != null)
        {
          _image = File(result.files.single.path!);
          _base64Image = base64Encode(_image!.readAsBytesSync());
          return _base64Image;
        }

        return null;
      }
}
