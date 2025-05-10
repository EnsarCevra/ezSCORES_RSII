import 'dart:io';
import 'dart:convert';
import 'package:ezscores_desktop/models/sponsors.dart';
import 'package:ezscores_desktop/providers/SponsorsProvider.dart';
import 'package:ezscores_desktop/providers/base_provider.dart';
import 'package:ezscores_desktop/providers/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:file_picker/file_picker.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:provider/provider.dart';

class SponsorDialog extends StatefulWidget {
  final Sponsors? sponsor;
  const SponsorDialog({super.key, this.sponsor});

  @override
  State<SponsorDialog> createState() => _SponsorDialogState();
}

class _SponsorDialogState extends State<SponsorDialog> {
  final _formKey = GlobalKey<FormBuilderState>();
  String? _base64Image;
  late SponsorProvider sponsorProvider;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    sponsorProvider = context.read<SponsorProvider>();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.sponsor == null ? "Dodaj sponzora" : "Uredi sponzora"),
      content: SizedBox(
        width: 350,
        child: FormBuilder(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              FormBuilderTextField(
                name: "name",
                initialValue: widget.sponsor?.name ?? "",
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
                                      Icon(Icons.handshake, size: 150,)
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
          onPressed: () => Navigator.pop(context, false),
          child: const Text("Otkaži"),
        ),
        ElevatedButton(
          onPressed: () async {
            if (_formKey.currentState?.saveAndValidate() ?? false) {
              var request = Map<String, dynamic>.from(_formKey.currentState!.value);
              request["picture"] = _base64Image;
              try {
                if (widget.sponsor == null) {
                  await sponsorProvider.insert(request);
                } else {
                  await sponsorProvider.update(widget.sponsor!.id!, request);
                }
                if (context.mounted) {
                  showBottomRightNotification(context, 'Sponzor uspješno spremljen.');
                  Navigator.pop(context, true);
                }
              } on UserException catch (e) {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text("Greška"),
                    content: Text(e.toString()),
                    actions: [
                      TextButton(onPressed: () => Navigator.pop(context), child: const Text("OK")),
                    ],
                  ),
                );
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
