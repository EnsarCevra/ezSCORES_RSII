import 'dart:convert';
import 'dart:io';
import 'package:ezscores_mobile/dialogs/success_dialog.dart';
import 'package:ezscores_mobile/models/roles.dart';
import 'package:ezscores_mobile/models/search_result.dart';
import 'package:ezscores_mobile/providers/RolesProvider.dart';
import 'package:ezscores_mobile/providers/UserProvider.dart';
import 'package:ezscores_mobile/providers/auth_provider.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:provider/provider.dart';

class RegisterScreen extends StatefulWidget {
  final int? selectedIndex;
  const RegisterScreen({super.key, this.selectedIndex});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  String? _base64Image;
  File? _image;
  final _formKey = GlobalKey<FormBuilderState>();
  SearchResult<Roles>? roleResult; 
  late RolesProvider roleProvider; 

  @override
  void initState() {
    roleProvider = context.read<RolesProvider>();
    

    super.initState();
    initForm();
  }
  Future initForm() async{
    var roleData = await roleProvider.get();
    final allowedRoles = {"Manager", "Spectator"};

    roleData.result = roleData.result
        .where((role) => allowedRoles.contains(role.name))
        .toList();

    setState(() {
      roleResult = roleData;
    });
   }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Registracija")),
      body: _buildContent()
    );
  }
  Widget _buildTextField(
  String name,
  String label, [
  bool required = false,
  bool obscure = false,
]) {
  return FormBuilderTextField(
    name: name,
    obscureText: obscure,
    decoration: InputDecoration(
      labelText: label,
      labelStyle: const TextStyle(
        fontWeight: FontWeight.w500,
        color: Colors.grey,
      ),
      filled: true,
      fillColor: Colors.grey.shade100,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Colors.grey.shade300),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Colors.blue.shade400, width: 1.6),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Colors.red),
      ),
      errorMaxLines: 3
    ),
    autovalidateMode: AutovalidateMode.onUserInteraction,
    validator: (value) =>  _validateFormField(name, value),
  );
}



  Widget _buildImagePicker() {
    return FormBuilderField<String>(
      name: "picture",
      builder: (field) {
        return InputDecorator(
          decoration: InputDecoration(
            labelText: "Profilna slika",
            errorText: field.errorText,
          ),
          child: Column(
            children: [
              ClipOval(
                child: _base64Image != null
                    ? Image.memory(
                        base64Decode(_base64Image!),
                        width: 150,
                        height: 150,
                        fit: BoxFit.cover,
                      )
                    : Image.asset(
                        'assets/images/default_profile_image.jpg',
                        width: 150,
                        height: 150,
                        fit: BoxFit.cover,
                      ),
              ),
              ListTile(
                leading: const Icon(Icons.image),
                title: Text(_base64Image == null ? "Odaberi sliku" : "Promijeni sliku"),
                trailing: const Icon(Icons.file_upload),
                onTap: () async {
                  final image = await _getImage();
                  if (image != null) {
                    field.didChange(image);
                    setState(() {
                      _base64Image = image;
                    });
                  }
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Future<String?> _getImage() async {
    final result = await FilePicker.platform.pickFiles(type: FileType.image);
    if (result != null && result.files.single.path != null) {
      _image = File(result.files.single.path!);
      return base64Encode(_image!.readAsBytesSync());
    }
    return null;
  }

  Future<void> _register() async {
    final isValid = _formKey.currentState?.saveAndValidate();
    if (isValid != true) return;

    var request = Map.from(_formKey.currentState!.value);
    request['picture'] = _base64Image;
    request['roleId'] = _formKey.currentState?.fields['roleId']?.value;

    try {
      final userProvider = context.read<UserProvider>();
      await userProvider.insert(request);
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) => const SuccessPopup(message: "Uspjesna registracija"),
      );
      Future.delayed(const Duration(seconds: 2), () {
        if (context.mounted) {
          Navigator.of(context).pop(true);
        }
      });
    } catch (e) {
      if (!mounted) return;
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: const Text("Greška"),
          content: Text(e.toString()),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text("OK"),
            ),
          ],
        ),
      );
    }
  }
  
  String? _validateFormField(String name, String? value) {
  final validators = <String? Function(String?)>[];

    switch (name) {
      case 'firstName':
        validators.addAll([
          FormBuilderValidators.required(errorText: 'Ime je obavezno'),
          FormBuilderValidators.minLength(3, errorText: 'Prekratko ime'),
          FormBuilderValidators.maxLength(20, errorText: 'Maksimalno 20 karaktera'),
          FormBuilderValidators.match(
            r'^[A-ZČĆŽŠĐ][a-zčćžšđA-ZČĆŽŠĐ]*$',
            errorText: 'Ime mora početi velikim slovom\nSadržava samo slova',
          ),
        ]);
        break;

      case 'lastName':
        validators.addAll([
          FormBuilderValidators.required(errorText: 'Prezime je obavezno'),
          FormBuilderValidators.minLength(3, errorText: 'Prekratko prezime'),
          FormBuilderValidators.maxLength(20, errorText: 'Maksimalno 20 karaktera'),
          FormBuilderValidators.match(
            r'^[A-ZČĆŽŠĐ][a-zčćžšđA-ZČĆŽŠĐ]*$',
            errorText: 'Prezime mora početi velikim slovom\nSadržava samo slova',
          ),
        ]);
        break;

      case 'email':
        validators.addAll([
          FormBuilderValidators.required(errorText: 'Email je obavezan'),
          FormBuilderValidators.email(errorText: 'Neispravan email format'),
          FormBuilderValidators.maxLength(40, errorText: 'Maksimalno 40 karaktera'),
        ]);
        break;

      case 'userName':
        validators.addAll([
          FormBuilderValidators.required(errorText: 'Korisničko ime je obavezno'),
          FormBuilderValidators.minLength(3, errorText: 'Prekratko korisničko ime'),
          FormBuilderValidators.maxLength(20, errorText: 'Maksimalno 20 karaktera'),
          FormBuilderValidators.match(
            r'^[a-zA-Z0-9_]+$',
            errorText: 'Korisničko ime smije sadržavati samo slova,\n brojeve i donje crte (_)',
          ),
        ]);
        break;

      case 'organization':
        if (value == null || value.isEmpty) return null;

        if (value.length < 3) {
          return 'Prekratko ime organizacije';
        }
        if (value.length > 30) {
          return 'Predugo ime, maksimalno je 30 karaktera';
        }

        final regex = RegExp(r'^[a-zA-ZčćžšđČĆŽŠĐ\s]+$');
        if (!regex.hasMatch(value)) {
          return 'Ime organizacije smije sadržavati samo slova i razmake.';
        }

        return null;

      case 'phoneNumber':
        validators.addAll([
          FormBuilderValidators.required(errorText: 'Broj telefona je obavezan'),
           FormBuilderValidators.maxLength(20, errorText: 'Maksimalno 20 karaktera'),
           FormBuilderValidators.match(
             r'^\+?[0-9](?:[0-9]|[ -](?=[0-9])){0,19}$',
             errorText: 'Broj telefona mora sadržavati samo brojeve, razmake ili "-"',
           ),
        ]);
        break;

      case 'password':
        validators.addAll([
          FormBuilderValidators.required(errorText: "Lozinka je obavezna"),
          FormBuilderValidators.minLength(6, errorText: "Lozinka mora imati barem 6 znakova"),
        ]);
        break;

      case 'passwordConfirmation':
        final password = _formKey.currentState?.fields['password']?.value;
        if (value != password) {
          return 'Lozinke se ne podudaraju';
        }
        return null;

      default:
        return null;
    }
    return FormBuilderValidators.compose(validators)(value);
  }
  
  Widget _buildContent() {
  return SingleChildScrollView(
    padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
    child: Center(
      child: FormBuilder(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildImagePicker(),
            const SizedBox(height: 20),
                        if (roleResult != null)
              FormBuilderDropdown(
                name: "roleId",
                decoration: InputDecoration(
                  labelText: "Uloga/Vrsta korisnika *",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                validator: FormBuilderValidators.required(
                    errorText: 'Uloga je obavezna'),
                items: roleResult?.result
                        .map((item) => DropdownMenuItem(
                              value: item.id.toString(),
                              child: Text(item.name ?? ""),
                            ))
                        .toList() ??
                    [],
              ),
              const SizedBox(height: 20),

            _buildTextField('firstName', 'Ime', true),
            const SizedBox(height: 15),
            _buildTextField('lastName', 'Prezime', true),
            const SizedBox(height: 15),
            _buildTextField('email', 'Email', true),
            const SizedBox(height: 15),
            _buildTextField('userName', 'Korisničko ime', true),
            const SizedBox(height: 15),
            _buildTextField('organization', 'Organizacija'),
            const SizedBox(height: 15),
            _buildTextField('phoneNumber', 'Telefon', true),
            const SizedBox(height: 15),
            _buildTextField('password', 'Unesi lozinku', true, true),
            const SizedBox(height: 15),
            _buildTextField('passwordConfirmation', 'Potvrdi lozinku', true, true),
            const SizedBox(height: 30),
            
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: _register,
              child: Text(
                AuthProvider.roleID == 3
                    ? "Registracija korisnika"
                    : "Registruj se",
                style: const TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}


}