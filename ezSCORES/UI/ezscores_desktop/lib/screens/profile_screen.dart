import 'dart:convert';
import 'dart:io';

import 'package:ezscores_desktop/layouts/master_screen.dart';
import 'package:ezscores_desktop/providers/UserProvider.dart';
import 'package:ezscores_desktop/providers/auth_provider.dart';
import 'package:ezscores_desktop/providers/utils.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<StatefulWidget> createState() => _ProfileSettingsScreenState();
}

class _ProfileSettingsScreenState extends State<ProfileScreen> {
  String? _base64Image;
  late UserProvider userProvider;
  bool _showPasswordFields = false;
  Map<String, dynamic> _initialValue = {};
  final _formKey = GlobalKey<FormBuilderState>();

  @override
  void initState() {
    userProvider = context.read<UserProvider>();
    super.initState();
    _initialValue = {
      "id" : AuthProvider.id,
      "firstName": AuthProvider.firstName,
      "lastName": AuthProvider.lastName,
      "userName": AuthProvider.userName,
      "email": AuthProvider.email,
      "phoneNumber": AuthProvider.phoneNumber,
      "organization": AuthProvider.organization,
      "picture": AuthProvider.picture,
    };
    _base64Image = _initialValue['picture'];
  }

  @override
  Widget build(BuildContext context) {
    return MasterScreen(
      "Postavke profila",
      SingleChildScrollView(
        child: Column(
          children: [
            _buildForm(),
            _saveRow(),
          ],
        ),
      ),
      selectedIndex: 6,
    );
  }

  _buildForm() {
    return Padding(
      padding: const EdgeInsets.all(25.0),
      child: FormBuilder(
        key: _formKey,
        initialValue: _initialValue,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              // Profile picture
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
                                labelText: "Profilna slika",
                                errorText: field.errorText,
                              ),
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 8.0),
                                    child: ClipOval(
                                      child: _base64Image != null
                                          ? Image.memory(
                                              base64Decode(_base64Image!),
                                              width: 150,
                                              height: 150,
                                              fit: BoxFit.cover,
                                            )
                                          : Image.asset(
                                              'assets/images/default_profile_image.jpg',
                                              height: 150,
                                              width: 150,
                                              fit: BoxFit.cover,
                                            ),
                                    ),
                                  ),
                                  ListTile(
                                    leading: Icon(Icons.image),
                                    title: Text(_base64Image == null
                                        ? "Odaberi sliku"
                                        : "Promijeni sliku"),
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
                  ),
                ],
              ),
              SizedBox(height: 10),

              // FirstName + LastName
              Row(
                children: [
                  Expanded(
                    child: FormBuilderTextField(
                      decoration: InputDecoration(labelText: "Ime"),
                      name: 'firstName',
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(errorText: 'Ime je obavezno'),
                        FormBuilderValidators.minLength(3, errorText: 'Prekratko ime'),
                      ]),
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: FormBuilderTextField(
                      decoration: InputDecoration(labelText: "Prezime"),
                      name: 'lastName',
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(errorText: 'Prezime je obavezno'),
                        FormBuilderValidators.minLength(3, errorText: 'Prekratko prezime'),
                      ]),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: FormBuilderTextField(
                      enabled: false,
                      decoration: InputDecoration(labelText: "Email"),
                      name: 'email',
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(errorText: 'Email je obavezan'),
                        FormBuilderValidators.email(errorText: 'Neispravan email format'),
                      ]),
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: FormBuilderTextField(
                      enabled: AuthProvider.roleID == 3 ? true : false,
                      decoration: InputDecoration(labelText: "Korisničko ime"),
                      name: 'userName',
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: FormBuilderValidators.required(errorText: 'Korisničko ime je obavezno'),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),

              // Organization
              Row(
                children: [
                  Expanded(
                    child: FormBuilderTextField(
                      decoration: InputDecoration(labelText: "Organizacija"),
                      name: 'organization',
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: FormBuilderTextField(
                      decoration: InputDecoration(labelText: "Telefon"),
                      name: 'phoneNumber',
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
    
              Align(
                alignment: Alignment.centerLeft,
                child: TextButton.icon(
                  onPressed: () {
                    setState(() {
                      _showPasswordFields = !_showPasswordFields;
                      if(!_showPasswordFields)
                      {
                        _formKey.currentState!.fields['oldPassword']?.reset();
                        _formKey.currentState!.fields['password']?.reset();
                        _formKey.currentState!.fields['passwordConfirmation']?.reset();

                      }
                    });
                  },
                  icon: Icon(_showPasswordFields ? Icons.lock_open : Icons.lock),
                  label: Text(_showPasswordFields ? "Cancel Password Change" : "Change Password"),
                ),
              ),

              if (_showPasswordFields) ...[
                SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: FormBuilderTextField(
                        name: 'oldPassword',
                        decoration: InputDecoration(labelText: 'Old Password'),
                        obscureText: true,
                        validator: FormBuilderValidators.required(errorText: "Old password required"),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: FormBuilderTextField(
                        name: 'password',
                        decoration: InputDecoration(labelText: 'New Password'),
                        obscureText: true,
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(errorText: "New password required"),
                          FormBuilderValidators.minLength(6, errorText: "Password must be at least 6 characters"),
                        ]),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: FormBuilderTextField(
                        name: 'passwordConfirmation',
                        decoration: InputDecoration(labelText: 'Confirm Password'),
                        obscureText: true,
                        validator: (val) {
                          if (_formKey.currentState?.fields['password']?.value != val) {
                            return 'Passwords do not match';
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  _saveRow() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 0, 25, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          ElevatedButton(
            onPressed: () async {
              final isValid = _formKey.currentState?.saveAndValidate();
              if (isValid == true) { 
                var request = <String, dynamic>{};
                final originalForm = _formKey.currentState?.value;
                final formData = Map<String, dynamic>.from(originalForm!);
                if ((formData['oldPassword']?.isNotEmpty ?? false) &&
                    (formData['password']?.isNotEmpty ?? false) &&
                    (formData['passwordConfirmation']?.isNotEmpty ?? false)) 
                {
                  request = Map.from(_formKey.currentState!.value);
                }
                else
                {
                  request["userName"] = formData['userName'];
                  request["firstName"] = formData['firstName'];
                  request["lastName"] = formData['lastName'];
                  request["email"] = formData['email'];
                  request["phoneNumber"] = formData['phoneNumber'];
                  request["organization"] = formData['organization'];
                }
                request["picture"] = _base64Image;
                try {
                  var userId = AuthProvider.id;
                  if(userId != null)
                  {
                    await userProvider.update(userId, request);
                  }
                  
                if(context.mounted)
                {
                  showSuccessSnackBar(context, 'Profil uspješno ažuriran.');
                  AuthProvider.firstName = request['firstName'];
                  AuthProvider.lastName = request['lastName'];
                  AuthProvider.userName = request['userName'];
                  AuthProvider.picture = request['picture'];
                  AuthProvider.email = request['email'];
                  AuthProvider.phoneNumber = request['phoneNumber'];
                  AuthProvider.organization = request['organization'];
                }
                } catch (exception) {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text("Greška"),
                      content: Text(exception.toString()),
                      actions: [
                        TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: Text("Ok")),
                      ],
                    ),
                  );
                }
              }
            },
            child: Text("Sačuvaj"),
          ),
        ],
      ),
    );
  }

  File? _image;
  Future<String?> getImage() async {
    var result = await FilePicker.platform.pickFiles(type: FileType.image);
    if (result != null && result.files.single.path != null) {
      _image = File(result.files.single.path!);
      _base64Image = base64Encode(_image!.readAsBytesSync());
      return _base64Image;
    }
    return null;
  }
}
