import 'dart:convert';
import 'dart:io';

import 'package:ezscores_desktop/layouts/master_screen.dart';
import 'package:ezscores_desktop/models/referees.dart';
import 'package:ezscores_desktop/providers/RefereesProvider.dart';
import 'package:ezscores_desktop/providers/utils.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:provider/provider.dart';

class RefereesDetailsScreen extends StatefulWidget
{
  int selectedIndex;
  Referees? referee;
  RefereesDetailsScreen({super.key, this.referee, required this.selectedIndex});
  
  @override
  State<RefereesDetailsScreen> createState() => _RefereesDetailsScreenState();
}

class _RefereesDetailsScreenState extends State<RefereesDetailsScreen>{
  late RefereeProvider refereeProvider;
  String? _base64Image;
  Map<String, dynamic> _initialValue = {};
  final _formKey = GlobalKey<FormBuilderState>();
  @override
  void didChangeDependencies()
  {
    super.didChangeDependencies();
  }
  @override
  void initState() {
    refereeProvider = context.read<RefereeProvider>();
    super.initState();
    _initialValue = {
      "firstName" : widget.referee?.firstName,
      "lastName" : widget.referee?.lastName,
      "picture" : widget.referee?.picture
    };
    initForm();
  }
  Future initForm() async{
    setState(() {
      _base64Image = widget.referee?.picture;
    });
   }
  @override
  Widget build(BuildContext context) {
    return MasterScreen("Detalji", selectedIndex: widget.selectedIndex,
    Column(
      children: [
        _buildForm(),
        _saveRow()
      ],
    ));
  }
  
  _buildForm() {
    return Padding(
        padding: const EdgeInsets.all(25.0),
        child: FormBuilder(key: _formKey, initialValue: _initialValue,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
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
                                      Image.asset('assets/images/default_profile_image.jpg', height: 150, fit: BoxFit.cover,),
                                    ),),
                                      
                                  ListTile(
                                    leading: const Icon(Icons.image),
                                    title: Text(_base64Image == null ? "Odaberi sliku" : "Promijeni sliku"),
                                    trailing: const Icon(Icons.file_upload),
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
              const SizedBox(width: 30,),
              Row(
                children: [
                  Expanded(
                    child: FormBuilderTextField(
                      decoration: const InputDecoration(labelText: "Ime"),
                       name: 'firstName',
                       autovalidateMode: AutovalidateMode.onUserInteraction,
                       valueTransformer: (text) => text?.trim(),
                       validator: FormBuilderValidators.compose(
                        [
                          FormBuilderValidators.required(errorText: 'Ime je obavezno'),
                          FormBuilderValidators.minLength(3, errorText: 'Ime mora imati barem 3 slova'),
                          FormBuilderValidators.match(
                            r'^[A-ZČĆŽŠĐ][a-zčćžšđA-ZČĆŽŠĐ\s]*$',
                            errorText: 'Naziv mora početi velikim slovom i sadržavati samo slova',
                          ),
                        ]
                       ),),
                    ),
                ],
              ),
              const SizedBox(width: 30,),
              Row(
                children: [
                  Expanded(
                    child: FormBuilderTextField(
                      decoration: const InputDecoration(labelText: "Prezime"),
                       name: 'lastName',
                       autovalidateMode: AutovalidateMode.onUserInteraction,
                       valueTransformer: (text) => text?.trim(),
                       validator: FormBuilderValidators.compose(
                        [
                          FormBuilderValidators.match(
                            r'^[A-ZČĆŽŠĐ][a-zčćžšđA-ZČĆŽŠĐ\s]*$',
                            errorText: 'Naziv mora početi velikim slovom i sadržavati samo slova',
                          ),
                          FormBuilderValidators.required(errorText: 'Prezime je obavezno'),
                          FormBuilderValidators.minLength(3, errorText: 'Prezime mora imati barem 3 slova'),
                        ]
                       ),),
                    ),
                ],
              ),
            ],
          ),
        ),
             ),
      );
  }
  
  _saveRow() {
     return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            ElevatedButton(onPressed: () async {
              final isValid = _formKey.currentState?.saveAndValidate();
              if(isValid == true)
              {
                final originalFormData = _formKey.currentState?.value;
                final formData = Map<String, dynamic>.from(originalFormData!);

                var request = Map.from(formData);
                request["picture"] = _base64Image; 

                try{
                if(widget.referee == null)
                {
                  await refereeProvider.insert(request);
                }
                else
                {
                  await refereeProvider.update(widget.referee!.id!, request);
                }
                if(context.mounted)
                {
                  widget.referee == null ? showBottomRightNotification(context, 'Sudac uspješno dodan.') : showBottomRightNotification(context, 'Sudac uspješno ažuriran.');
                  Navigator.pop(context, true);
                }
              }on Exception catch(exception)
              {
                showDialog(
                context: context, 
                builder: (context) => AlertDialog(
                  title: const Text("Error"), 
                  actions: [TextButton(onPressed: () => Navigator.pop(context), child: const Text("Ok"))], 
                  content: Text(exception.toString()),));
              }
              }
            }, child: const Text("Sačuvaj"))
          ],
        ),
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