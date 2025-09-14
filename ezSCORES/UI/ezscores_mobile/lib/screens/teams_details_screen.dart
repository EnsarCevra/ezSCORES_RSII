import 'dart:convert';
import 'dart:io';

import 'package:ezscores_mobile/dialogs/success_dialog.dart';
import 'package:ezscores_mobile/helpers/app_loading_widget.dart';
import 'package:ezscores_mobile/providers/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:file_picker/file_picker.dart';
import 'package:provider/provider.dart';

import '../../models/teams.dart';
import '../../models/selections.dart';
import '../../models/search_result.dart';
import '../../providers/TeamProvider.dart';
import '../../providers/SelectionProvider.dart';

class TeamsDetailsScreen extends StatefulWidget {
  final Teams? team;

  const TeamsDetailsScreen({super.key, this.team});

  @override
  State<TeamsDetailsScreen> createState() => _TeamsDetailsScreenState();
}

class _TeamsDetailsScreenState extends State<TeamsDetailsScreen> {
  final _formKey = GlobalKey<FormBuilderState>();
  Map<String, dynamic> _initialValue = {};
  late TeamProvider teamProvider;
  late SelectionProvider selectionProvider;
  SearchResult<Selections>? selectionResult;
  String? _base64Image;
  File? _image;

  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    teamProvider = context.read<TeamProvider>();
    selectionProvider = context.read<SelectionProvider>();

    _initialValue = {
      "name": widget.team?.name,
      "selectionId": widget.team?.selection?.id,
      "picture": widget.team?.picture,
    };
    _base64Image = widget.team?.picture;
    initForm();
  }

  Future<void> initForm() async {
    var selectionData = await selectionProvider.get();
    setState(() {
      selectionResult = selectionData;
      _isLoading = false;
    });
  }

  Future<String?> _pickImage() async {
    var result = await FilePicker.platform.pickFiles(type: FileType.image);
    if (result != null && result.files.single.path != null) {
      _image = File(result.files.single.path!);
      _base64Image = base64Encode(_image!.readAsBytesSync());
      return _base64Image;
    }
    return null;
  }

  Future<void> _saveTeam() async {
    final isValid = _formKey.currentState?.saveAndValidate();
    if (isValid == true) {
      var request = Map.from(_formKey.currentState!.value);
      request["picture"] = _base64Image;

      try {
        if (widget.team == null) {
          await teamProvider.insert(request);
        } else {
          await teamProvider.update(widget.team!.id!, request);
        }
        if (context.mounted) {
          showDialog(
                context: context,
                barrierDismissible: false,
                builder: (_) => SuccessPopup(message: "Ekipa uspješno ${widget.team == null ? 'kreirana' : 'ažurirana'}!"),
              );
          Future.delayed(const Duration(seconds: 2), () {
            if (context.mounted) {
              Navigator.of(context).pop(true);   // pop the form page
            }
          });
        }
      } on Exception catch (e) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text("Greška"),
            content: Text(e.toString()),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("Ok"),
              )
            ],
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.team == null ? "Nova ekipa" : "Detalji ekipe",
          style: const TextStyle(fontSize: 15),
        ),
      ),
      body: _isLoading
          ? const AppLoading()
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: FormBuilder(
                key: _formKey,
                initialValue: _initialValue,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    FormBuilderField<String>(
                      name: "imageId",
                      builder: (field) => Center(
                        child: Column(
                          children: [
                            _base64Image != null
                                ? Image.memory(
                                    base64Decode(_base64Image!),
                                    height: 150,
                                    fit: BoxFit.cover,
                                  )
                                : Image.asset(
                                    'assets/images/team_placeholder.png',
                                    height: 150,
                                    fit: BoxFit.cover,
                                  ),
                            const SizedBox(height: 12),
                            ElevatedButton.icon(
                              onPressed: () async {
                                final result = await _pickImage();
                                if (result != null) {
                                  field.didChange(result);
                                  setState(() {});
                                }
                              },
                              icon: const Icon(Icons.image),
                              label: Text(_base64Image == null
                                  ? "Odaberi sliku"
                                  : "Promijeni sliku"),
                              style: ElevatedButton.styleFrom(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 12, horizontal: 18),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    FormBuilderTextField(
                      name: "name",
                      decoration: mobileTextInputDecoration("Naziv"),
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(
                            errorText: 'Naziv je obavezan'),
                        FormBuilderValidators.minLength(2,
                            errorText: 'Naziv mora imati barem 2 slova'),
                      ]),
                    ),
                    const SizedBox(height: 20),
                    FormBuilderDropdown<int>(
                      name: "selectionId",
                      decoration: mobileTextInputDecoration("Selekcija"),
                      validator: FormBuilderValidators.required(
                          errorText: 'Selekcija je obavezna'),
                      items: selectionResult?.result
                              .map((item) => DropdownMenuItem(
                                    value: item.id,
                                    child: Text(item.name ?? ""),
                                  ))
                              .toList() ??
                          [],
                    ),
                    const SizedBox(height: 30),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: _saveTeam,
                      child: const Text(
                        "Sačuvaj",
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
