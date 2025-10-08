import 'dart:convert';
import 'dart:io';

import 'package:ezscores_desktop/layouts/master_screen.dart';
import 'package:ezscores_desktop/main.dart';
import 'package:ezscores_desktop/models/roles.dart';
import 'package:ezscores_desktop/models/search_result.dart';
import 'package:ezscores_desktop/providers/RolesProvider.dart';
import 'package:ezscores_desktop/providers/UserProvider.dart';
import 'package:ezscores_desktop/providers/auth_provider.dart';
import 'package:ezscores_desktop/providers/utils.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:provider/provider.dart';

class RegisterScreen extends StatefulWidget {
  int? selectedIndex;
  RegisterScreen({super.key, this.selectedIndex});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  String? _base64Image;
  File? _image;
  final _formKey = GlobalKey<FormBuilderState>();
  SearchResult<Roles>? roleResult = null; 
  late RolesProvider roleProvider; 

  @override
  void initState() {
    roleProvider = context.read<RolesProvider>();
    

    super.initState();
    initForm();
  }
  Future initForm() async{
    var roleData = await roleProvider.get();
    setState(() {
      roleResult = roleData;
    });
   }
  @override
  Widget build(BuildContext context) {
    return AuthProvider.roleID == 3 ? 
    MasterScreen("Registracija korisnika", _buildContent(), selectedIndex: widget.selectedIndex!) : Scaffold(
      appBar: AppBar(title: const Text("Registracija")),
      body: _buildContent()
    );
  }
  Widget _buildTextField(String name, String label,
    [bool required = false, bool isPassword = false]) {
  return SizedBox(
    width: 350,
    child: FormBuilderTextField(
      name: name,
      obscureText: isPassword,
      decoration: InputDecoration(errorStyle: const TextStyle(fontSize: 12),
        label: RichText(
          text: TextSpan(
            text: label,
            style: const TextStyle(color: Colors.black), // Label color
            children: required
                ? const [
                    TextSpan(
                      text: ' *',
                      style: TextStyle(color: Colors.red),
                    )
                  ]
                : [],
          ),
        ),
      ),
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: (value) =>  _validateFormField(name, value),
    ),
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
    request['roleId'] = AuthProvider.roleID == 3 ? _formKey.currentState?.fields['roleId']?.value : 1; //when registering on desktop user can only create "organizer" account while admin can add new admin account

    try {
      final userProvider = context.read<UserProvider>();
      await userProvider.insert(request);
      if(AuthProvider.roleID == 3)
      {
        showBottomRightNotification(context, "Uspješno registrovan novi korisnik");
        Navigator.of(context).pop();
      }
      else
      {
        await showDialog(
          context: context,
          builder: (_) => AlertDialog(
            title: const Text("Registracija uspješna"),
            content: const Text("Uspješno ste se registrovali."),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    Navigator.of(context, rootNavigator: true).pushReplacement(
                      MaterialPageRoute(builder: (_) => const MyApp()),
                    );
                  });
                },
                child: const Text("Idi na prijavu"),
              ),
            ],
          ),
        );
        // Navigator.of(parentContext).pushReplacement(
        //       MaterialPageRoute(builder: (context) => const MyApp()),
        //     );
      }
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
        ]);
        break;

      case 'userName':
        validators.addAll([
          FormBuilderValidators.required(errorText: 'Korisničko ime je obavezno'),
          FormBuilderValidators.minLength(3, errorText: 'Prekratko korisničko ime'),
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

        final regex = RegExp(r'^[a-zA-ZčćžšđČĆŽŠĐ\s]+$');
        if (!regex.hasMatch(value)) {
          return 'Ime organizacije smije sadržavati samo slova i razmake.';
        }

        return null;

      case 'phoneNumber':
        validators.addAll([
          FormBuilderValidators.required(errorText: 'Broj telefona je obavezan'),
          FormBuilderValidators.match(
            r'^\+?[0-9]+([ -]?[0-9]+)*$',
            errorText: 'Unesite ispravan broj \n(razmaci i crtice moraju biti pojedinačni i između brojeva)',
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

    // Run composed validators and return the result
    return FormBuilderValidators.compose(validators)(value);
  }
  
  Widget _buildContent() {
    return SingleChildScrollView(
        padding: const EdgeInsets.all(32),
        child: Center(
          child: Container(
            width: 800,
            padding: const EdgeInsets.all(32),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 12,
                  offset: Offset(0, 6),
                )
              ],
            ),
            child: FormBuilder(
              key: _formKey,
              child: Column(
                children: [
                  _buildImagePicker(),
                  Row(
                    children: [
                      Expanded(
                        child: FormBuilderDropdown(
                          name: "roleId",
                          decoration: InputDecoration(
                            errorStyle: const TextStyle(fontSize: 12),
                            label: RichText(
                              text: const TextSpan(
                                text: 'Uloga/Vrsta korisnika',
                                style: TextStyle(color: Colors.black),
                                children: [
                                  TextSpan(
                                    text: ' *',
                                    style: TextStyle(color: Colors.red),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          validator: FormBuilderValidators.compose([
                            FormBuilderValidators.required(errorText: 'Uloga je obavezna'),
                          ]),
                          focusColor: Colors.transparent,
                          items: roleResult?.result.map(
                                (item) => DropdownMenuItem(
                                  value: item.id.toString(),
                                  child: Text(item.name ?? ""),
                                ),
                              ).toList() ??
                              [],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Wrap(
                    spacing: 20,
                    runSpacing: 20,
                    children: [
                      _buildTextField('firstName', 'Ime', true),
                      _buildTextField('lastName', 'Prezime', true),
                      _buildTextField('email', 'Email', true),
                      _buildTextField('userName', 'Korisničko ime', true),
                      
                      _buildTextField('organization', 'Organizacija'),
                      _buildTextField('phoneNumber', 'Telefon', true),
                      _buildTextField('password', 'Unesi lozinku', true, true),
                      _buildTextField('passwordConfirmation', 'Potvrdi lozinku', true, true),
                    ],
                  ),
                  const SizedBox(height: 30),
                  Align(
                    alignment: Alignment.centerRight,
                    child: ElevatedButton(
                      onPressed: _register,
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 12),
                        child: AuthProvider.roleID == 3 ? Text("Registracija korisnika") : Text("Registruj se"),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
  }

}
