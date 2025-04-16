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
      "selectionId" : widget.team?.selectionId.toString()
    };
    initForm();
  }
   Future initForm() async{
    var selectionData = await selectionProvider.get();
    setState(() {
      selectionResult = selectionData;
    });
   }
  @override
   Widget build(BuildContext context) {
    return MasterScreen("Detalji", 
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
            ),
            Row(
              children: [
                Expanded(
                  child: FormBuilderField(
                    name: "imageId",
                    builder: (field) {
                      return InputDecorator(
                        decoration: InputDecoration(labelText: "Odaberite sliku"),
                        child: ListTile(
                          leading: Icon(Icons.image),
                          title: Text("Select image"),
                          trailing: Icon(Icons.file_upload),
                          onTap: getImage,
                        ),
                      );
                    },
                  )
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
     void getImage() async{
        var result = await FilePicker.platform.pickFiles(type: FileType.image);

        if(result != null && result.files.single.path != null)
        {
          _image = File(result.files.single.path!);
          _base64Image = base64Encode(_image!.readAsBytesSync());
        }
      }
}