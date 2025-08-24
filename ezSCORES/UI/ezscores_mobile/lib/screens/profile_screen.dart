import 'dart:convert';
import 'dart:io';

import 'package:ezscores_mobile/dialogs/success_dialog.dart';
import 'package:ezscores_mobile/main.dart';
import 'package:ezscores_mobile/providers/UserProvider.dart';
import 'package:ezscores_mobile/providers/auth_provider.dart';
import 'package:ezscores_mobile/providers/utils.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:provider/provider.dart';
import 'package:ezscores_mobile/models/users.dart';

class ProfileScreen extends StatefulWidget {
  Users? user;

  ProfileScreen({super.key, this.user});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String? _base64Image;
  late UserProvider userProvider;
  bool _showPasswordFields = false;
  Map<String, dynamic> _initialValue = {};
  final _formKey = GlobalKey<FormBuilderState>();

  @override
  void initState() {
    super.initState();
    userProvider = context.read<UserProvider>();

    // Fill user with current auth if null
    widget.user = Users(
      id: AuthProvider.id,
      firstName: AuthProvider.firstName,
      lastName: AuthProvider.lastName,
      userName: AuthProvider.userName,
      email: AuthProvider.email,
      phoneNumber: AuthProvider.phoneNumber,
      organization: AuthProvider.organization,
      picture: AuthProvider.picture,
    );

    _initialValue = {
      "firstName": widget.user?.firstName,
      "lastName": widget.user?.lastName,
      "userName": widget.user?.userName,
      "email": widget.user?.email,
      "phoneNumber": widget.user?.phoneNumber,
      "organization": widget.user?.organization,
      "picture": widget.user?.picture,
    };

    _base64Image = _initialValue['picture'];
  }

  @override
  Widget build(BuildContext context) {
    //if user is not logged in
    if(AuthProvider.id == null)
    {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Center(child: Text("Niste logirani!"),),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => LoginPage()),
          );
            }, child: const Text("Prijavi se"))
        ],
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text("Postavke profila", style: TextStyle(fontSize: 15),),
        actions: const [LogoutButton()],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _buildProfilePicture(),
            const SizedBox(height: 16),
            _buildForm(),
            const SizedBox(height: 16),
            _saveButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildProfilePicture() {
    return Column(
      children: [
        ClipOval(
          child: _base64Image != null
              ? Image.memory(
                  base64Decode(_base64Image!),
                  width: 120,
                  height: 120,
                  fit: BoxFit.cover,
                )
              : Image.asset(
                  'assets/images/default_profile_image.jpg',
                  width: 120,
                  height: 120,
                  fit: BoxFit.cover,
                ),
        ),
        const SizedBox(height: 8),
        TextButton.icon(
          onPressed: () async {
            final result = await _pickImage();
            if (result != null) {
              setState(() {
                _base64Image = result;
              });
            }
          },
          icon: const Icon(Icons.image),
          label: Text(_base64Image == null ? "Odaberi sliku" : "Promijeni sliku"),
        ),
      ],
    );
  }

  Widget _buildForm() {
    return FormBuilder(
      key: _formKey,
      initialValue: _initialValue,
      child: Column(
        children: [
          FormBuilderTextField(
            name: 'firstName',
            decoration: const InputDecoration(labelText: "Ime"),
            validator: FormBuilderValidators.compose([
              FormBuilderValidators.required(errorText: 'Ime je obavezno'),
              FormBuilderValidators.minLength(3, errorText: 'Prekratko ime'),
            ]),
          ),
          const SizedBox(height: 10),
          FormBuilderTextField(
            name: 'lastName',
            decoration: const InputDecoration(labelText: "Prezime"),
            validator: FormBuilderValidators.compose([
              FormBuilderValidators.required(errorText: 'Prezime je obavezno'),
              FormBuilderValidators.minLength(3, errorText: 'Prekratko prezime'),
            ]),
          ),
          const SizedBox(height: 10),
          FormBuilderTextField(
            name: 'email',
            decoration: const InputDecoration(labelText: "Email"),
            enabled: false,
          ),
          const SizedBox(height: 10),
          FormBuilderTextField(
            name: 'userName',
            decoration: const InputDecoration(labelText: "Korisničko ime"),
            validator: FormBuilderValidators.compose([
              FormBuilderValidators.required(errorText: 'Korisničko ime je obavezno'),
              FormBuilderValidators.minLength(3, errorText: 'Prekratko korisničko ime'),
              FormBuilderValidators.match(
                r'^[a-zA-Z0-9_]+$',
                errorText: 'Samo slova, brojevi i donje crte (_)',
              ),
            ]),
          ),
          const SizedBox(height: 10),
          FormBuilderTextField(
            name: 'organization',
            decoration: const InputDecoration(labelText: "Organizacija"),
            validator: (val) {
              if (val == null || val.isEmpty) return null;
              if (val.length < 3) return 'Prekratko ime organizacije';
              if (!RegExp(r'^[a-zA-ZčćžšđČĆŽŠĐ\s]+$').hasMatch(val)) {
                return 'Samo slova i razmaci';
              }
              return null;
            },
          ),
          const SizedBox(height: 10),
          FormBuilderTextField(
            name: 'phoneNumber',
            decoration: const InputDecoration(labelText: "Telefon"),
            validator: FormBuilderValidators.compose([
              FormBuilderValidators.required(errorText: 'Broj telefona je obavezan'),
              FormBuilderValidators.match(
                r'^\+?[0-9]+([ -]?[0-9]+)*$',
                errorText: 'Unesite ispravan broj',
              ),
            ]),
          ),
          const SizedBox(height: 10),
          // Change password toggle
          Align(
            alignment: Alignment.centerLeft,
            child: TextButton.icon(
              onPressed: () {
                setState(() => _showPasswordFields = !_showPasswordFields);
              },
              icon: Icon(_showPasswordFields ? Icons.lock_open : Icons.lock),
              label: Text(_showPasswordFields ? "Otkaži promjenu lozinke" : "Promijeni lozinku"),
            ),
          ),
          if (_showPasswordFields) ...[
            FormBuilderTextField(
              name: 'password',
              decoration: const InputDecoration(labelText: 'Nova lozinka'),
              obscureText: true,
              validator: FormBuilderValidators.compose([
                FormBuilderValidators.required(errorText: "Nova lozinka je obavezna"),
                FormBuilderValidators.minLength(6, errorText: "Lozinka mora biti najmanje 6 znakova"),
              ]),
            ),
            const SizedBox(height: 10),
            FormBuilderTextField(
              name: 'passwordConfirmation',
              decoration: const InputDecoration(labelText: 'Potvrda lozinke'),
              obscureText: true,
              validator: (val) {
                if (_formKey.currentState?.fields['password']?.value != val) {
                  return 'Lozinke se ne podudaraju';
                }
                return null;
              },
            ),
          ]
        ],
      ),
    );
  }

  Widget _saveButton() {
    return ElevatedButton(
      onPressed: () async {
        final isValid = _formKey.currentState?.saveAndValidate();
        if (isValid == true) {
          var request = Map<String, dynamic>.from(_formKey.currentState!.value);
          request["picture"] = _base64Image;
          try {
            await userProvider.update(widget.user!.id!, request);
            if (context.mounted) {
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (_) => const SuccessPopup(message: "Profil uspješno ažuriran!"),
              );
              // update auth locally
              AuthProvider.firstName = request['firstName'];
              AuthProvider.lastName = request['lastName'];
              AuthProvider.userName = request['userName'];
              AuthProvider.picture = request['picture'];
              AuthProvider.phoneNumber = request['phoneNumber'];
              AuthProvider.organization = request['organization'];
            }
          } catch (e) {
            if (context.mounted) {
              showDialog(
                context: context,
                builder: (ctx) => AlertDialog(
                  title: const Text("Greška"),
                  content: Text(e.toString()),
                  actions: [
                    TextButton(onPressed: () => Navigator.pop(ctx), child: const Text("Ok"))
                  ],
                ),
              );
            }
          }
        }
      },
      child: const Text("Sačuvaj"),
    );
  }

  File? _image;
  Future<String?> _pickImage() async {
    var result = await FilePicker.platform.pickFiles(type: FileType.image);
    if (result != null && result.files.single.path != null) {
      _image = File(result.files.single.path!);
      return base64Encode(_image!.readAsBytesSync());
    }
    return null;
  }
}
