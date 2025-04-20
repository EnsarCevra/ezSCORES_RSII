import 'dart:convert';
import 'dart:io';

import 'package:ezscores_desktop/layouts/master_screen.dart';
import 'package:ezscores_desktop/models/search_result.dart';
import 'package:ezscores_desktop/models/selections.dart';
import 'package:ezscores_desktop/models/teams.dart';
import 'package:ezscores_desktop/providers/SelectionProvider.dart';
import 'package:ezscores_desktop/providers/TeamProvider.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:provider/provider.dart';


class TeamsDetailsScreen extends StatefulWidget
{
  Teams? team;
  TeamsDetailsScreen({super.key, this.team});

   @override
    State<TeamsDetailsScreen> createState() => _TeamDetailsScreenState();
   
}
class _TeamDetailsScreenState extends State<TeamsDetailsScreen> {
  final _formKey = GlobalKey<FormBuilderState>();
  Map<String, dynamic> _initialValue = {};
  late TeamProvider teamProvider;
  late SelectionProvider selectionProvider;
  SearchResult<Selections>? selectionResult = null;
  bool isLoading = true;
  @override
  void didChangeDependencies()
  {
    super.didChangeDependencies();
  }
  @override
  void initState() {
    // TODO: implement initState
    teamProvider = context.read<TeamProvider>();
    selectionProvider = context.read<SelectionProvider>();
    super.initState();
    _initialValue = {
      "name" : widget.team?.name,
      "selectionId" : widget.team?.selection?.id.toString(),
      "picture" : widget.team?.picture
    };
    initForm();
  }
   Future initForm() async{
    var selectionData = await selectionProvider.get();
    setState(() {
      selectionResult = selectionData;
      _base64Image = widget.team?.picture;
    });
   }
  @override
   Widget build(BuildContext context) {
    return MasterScreen("Detalji", selectedIndex: 2,
    Column(
      children: [
        _buildForm(),
        _saveRow()
      ],
    ));
   }

   Widget _buildForm() {
    if(selectionResult != null)
    {
      return FormBuilder(key: _formKey, initialValue: _initialValue,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: FormBuilderTextField(decoration: InputDecoration(labelText: "Naziv"), name: 'name'),
                  ),
                  SizedBox(width: 10,),
                // Expanded(
                //   child: FormBuilderTextField(
                //     decoration: InputDecoration(labelText: "SelekcijaId"),
                //      name: 'selectionId',
                //     //  validator: FormBuilderValidators.compose([
                //     //   FormBuilderValidators.required(),
                //     //   FormBuilderValidators.email(),
                //      ),
                //   ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: FormBuilderDropdown(
                    name: "selectionId",
                    decoration: InputDecoration(labelText: "Selekcija"),
                    items: selectionResult?.result.map((item) => 
                    DropdownMenuItem(value: item.id.toString(), child: Text(item.name ?? ""),)).toList() ?? [],
                    )),
              ],
            ), //----
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
                                    child:
                                    _base64Image != null ?
                                     Image.memory(
                                      base64Decode(_base64Image!),
                                      height: 150,
                                      fit: BoxFit.cover,
                                    ) :
                                    Image.asset('assets/images/TeamPlaceholder.png', height: 150, fit: BoxFit.cover,),
                                  ),
                                ListTile(
                                  leading: Icon(Icons.image),
                                  title: Text(_base64Image == null ? "Select image" : "Change image"),
                                  trailing: Icon(Icons.file_upload),
                                  onTap: () async {
                                    final result = await getImage(); // Your custom function
                                    if (result != null) {
                                      field.didChange(result); // Update FormBuilder value3,
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
            )

          ],
        ),
      ),
     );
    }
    else
    {
    return const Center(child: CircularProgressIndicator());

    }
      
    }
    
    Widget _saveRow() {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            ElevatedButton(onPressed: () async {
              _formKey.currentState?.saveAndValidate();
              debugPrint(_formKey.currentState?.value.toString());
              var request = Map.from(_formKey.currentState!.value);
              request["picture"] = _base64Image;
              try{
                if(widget.team == null)
                {
                  await teamProvider.insert(request);
                }
                else
                {
                  await teamProvider.update(widget.team!.id!, request);
                }
              }on Exception catch(exception)
              {
                showDialog(
                                      context: context, 
                                      builder: (context) => AlertDialog(
                                        title: Text("Error"), 
                                        actions: [TextButton(onPressed: () => Navigator.pop(context), child: Text("Ok"))], 
                                        content: Text(exception.toString()),));
              }
            }, child: Text("Sačuvaj"))
          ],
        ),
      );
    }
    File? _image;
    String? _base64Image;
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