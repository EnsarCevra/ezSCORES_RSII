import 'dart:convert';
import 'dart:io';

import 'package:ezscores_mobile/providers/PlayersProvider.dart';
import 'package:ezscores_mobile/providers/utils.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class AddPlayerDialog extends StatefulWidget {
  const AddPlayerDialog({super.key});

  @override
  State<AddPlayerDialog> createState() => _AddPlayerDialogState();
}

class _AddPlayerDialogState extends State<AddPlayerDialog> {
  late PlayerProvider playerProvider;
  final _formKey = GlobalKey<FormBuilderState>();

  String? _base64Image;
  File? _image;

  @override
  void initState() {
    super.initState();
    playerProvider = context.read<PlayerProvider>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Novi igrač"),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: FormBuilder(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Center(
                  child: GestureDetector(
                    onTap: () async {
                      final result = await getImage();
                      if (result != null) {
                        setState(() {
                          _base64Image = result;
                        });
                      }
                    },
                    child: CircleAvatar(
                      radius: 60,
                      backgroundColor: Colors.grey.shade200,
                      backgroundImage: _base64Image != null
                          ? MemoryImage(base64Decode(_base64Image!))
                          : const AssetImage('assets/images/default_profile_image.jpg')
                              as ImageProvider,
                      child: _base64Image == null
                          ? Icon(Icons.add_a_photo,
                              size: 32, color: Colors.grey.shade600)
                          : null,
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                FormBuilderTextField(
                  name: 'firstName',
                  decoration: mobileTextInputDecoration("Ime"),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  valueTransformer: (value) => value?.trim(),
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(errorText: 'Ime je obavezno'),
                    FormBuilderValidators.minLength(3,
                        errorText: 'Ime mora imati barem 3 slova'),
                    FormBuilderValidators.match(
                        r'^[A-ZČĆŽŠĐ][a-zčćžšđA-ZČĆŽŠĐ]*$',
                        errorText:
                            'Ime mora početi velikim slovom i sadržavati samo slova'),
                  ]),
                ),
                const SizedBox(height: 16),
                FormBuilderTextField(
                  name: 'lastName',
                  decoration: mobileTextInputDecoration("Prezime"),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  valueTransformer: (value) => value?.trim(),
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(
                        errorText: 'Prezime je obavezno'),
                    FormBuilderValidators.minLength(3,
                        errorText: 'Prezime mora imati barem 3 slova'),
                    FormBuilderValidators.match(
                        r'^[A-ZČĆŽŠĐ][a-zčćžšđA-ZČĆŽŠĐ]*$',
                        errorText:
                            'Prezime mora početi velikim slovom i sadržavati samo slova'),
                  ]),
                ),
                const SizedBox(height: 16),
                FormBuilderDateTimePicker(
                  name: 'birthDate',
                  format: DateFormat('dd.MM.yyyy'),
                  inputType: InputType.date,
                  decoration: mobileTextInputDecoration("Datum rođenja").copyWith(
                    suffixIcon: const Icon(Icons.calendar_today),
                  ),
                  firstDate: DateTime(1900),
                  lastDate: DateTime.now(),
                  initialEntryMode: DatePickerEntryMode.calendar,
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(
                        errorText: "Datum je obavezan"),
                  ]),
                ),
                const SizedBox(height: 32),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _savePlayer,
                    child: const Text("Sačuvaj"),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _savePlayer() async {
    final isValid = _formKey.currentState?.saveAndValidate() ?? false;
    if (!isValid) return;

    final formData = Map<String, dynamic>.from(_formKey.currentState!.value);
    DateTime birthDate = formData['birthDate'];
    formData['birthDate'] = birthDate.toIso8601String();
    formData['picture'] = _base64Image;

    try {
      final newPlayer = await playerProvider.insert(formData);
      if (!mounted) return;
      showMobileNotification(context, 'Uspješno kreiran igrač');
      Navigator.pop(context, newPlayer);
    } catch (e) {
      if (!mounted) return;
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("Greška"),
          content: Text(e.toString()),
          actions: [
            TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("Ok")),
          ],
        ),
      );
    }
  }

  Future<String?> getImage() async {
    final result = await FilePicker.platform.pickFiles(type: FileType.image);
    if (result != null && result.files.single.path != null) {
      _image = File(result.files.single.path!);
      return base64Encode(_image!.readAsBytesSync());
    }
    return null;
  }
}
