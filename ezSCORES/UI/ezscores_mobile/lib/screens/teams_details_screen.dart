import 'dart:convert';
import 'dart:io';

import 'package:ezscores_mobile/dialogs/success_dialog.dart';
import 'package:ezscores_mobile/helpers/app_loading_widget.dart';
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
        title: Text(widget.team == null ? "Nova ekipa" : "Detalji ekipe",
        style: const TextStyle(fontSize: 15),),
      ),
      body: _isLoading
          ? const AppLoading()
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: FormBuilder(
                key: _formKey,
                initialValue: _initialValue,
                child: ListView(
                  children: [
                    /// Team image
                    FormBuilderField<String>(
                      name: "imageId",
                      builder: (field) => Center(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _base64Image != null
                                ? Center(
                                  child: Image.memory(
                                      base64Decode(_base64Image!),
                                      height: 150,
                                      fit: BoxFit.cover,
                                    ),
                                )
                                : Center(
                                  child: Image.asset(
                                      'assets/images/team_placeholder.png',
                                      height: 150,
                                      fit: BoxFit.cover,
                                    ),
                                ),
                            const SizedBox(height: 8),
                            Center(
                              child: ElevatedButton.icon(
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
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),

                    /// Team name
                    FormBuilderTextField(
                      name: "name",
                      decoration: const InputDecoration(labelText: "Naziv"),
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(
                            errorText: 'Naziv je obavezan'),
                        FormBuilderValidators.minLength(2,
                            errorText: 'Naziv mora imati barem 2 slova'),
                      ]),
                    ),
                    const SizedBox(height: 16),

                    /// Selection dropdown
                    FormBuilderDropdown<int>(
                      name: "selectionId",
                      decoration: const InputDecoration(labelText: "Selekcija"),
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(
                            errorText: 'Selekcija je obavezna'),
                      ]),
                      items: selectionResult?.result
                              .map((item) => DropdownMenuItem(
                                    value: item.id,
                                    child: Text(item.name ?? ""),
                                  ))
                              .toList() ??
                          [],
                    ),
                    const SizedBox(height: 32),

                    /// Save button
                    Align(
                      alignment: Alignment.centerRight,
                      child: ElevatedButton(
                        onPressed: _saveTeam,
                        child: const Text("Sačuvaj"),
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
