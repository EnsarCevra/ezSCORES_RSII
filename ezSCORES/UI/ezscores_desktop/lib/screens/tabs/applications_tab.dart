import 'package:ezscores_desktop/dialogs/applications_dialog.dart';
import 'package:ezscores_desktop/models/applications.dart';
import 'package:ezscores_desktop/models/search_result.dart';
import 'package:ezscores_desktop/providers/ApplicationsProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ApplicationsTab extends StatefulWidget
{
  final int competitionId;
  const ApplicationsTab({super.key, required this.competitionId});

  @override
  State<ApplicationsTab> createState() => _ApplicationsTabState();
}

class _ApplicationsTabState extends State<ApplicationsTab> {
  late ApplicationProvider applicationProvider;
  SearchResult<Applications>? applicationResult = null;
   @override
  void didChangeDependencies()
  {
    super.didChangeDependencies();
    applicationProvider = context.read<ApplicationProvider>();
  }
  @override
  void initState() {
    // TODO: implement initState
    applicationProvider = context.read<ApplicationProvider>();
    super.initState();
    initForm();
  }
  Future initForm() async{
    var filter = {
       "competitionId" : widget.competitionId
       };
    var applicationData = await applicationProvider.get(filter: filter);
    setState(() {
      applicationResult = applicationData;
    });
   }
  @override
  Widget build(BuildContext context)
  {
    return Container(
      child: Column(
        children: [
          _buildResultView()
        ],
      ),
    );
  }

// Widget _buildSearch()
// {
//   return selectionResult == null ? const SizedBox.shrink() : Padding(
//     padding: const EdgeInsets.all(15),
//     child: Row(
//     children: [
//       Expanded(child: TextField(controller: _ftsEditingController,decoration: InputDecoration(labelText: "Naziv"),)),
//       SizedBox(width: 8,),
//       Expanded(
//                   child: FormBuilderDropdown(
//                     name: "selectionId",
//                     decoration: InputDecoration(
//                       labelText: "Selekcija",
//                     ),
//                     focusColor: Colors.transparent,
//                     items: [DropdownMenuItem(value: "all", child: Text("Sve"),), ...selectionResult?.result.map((item) => 
//                     DropdownMenuItem(value: item.id.toString(), child: Text(item.name ?? ""),)).toList() ?? [],],
//                     onChanged: (value){
//                       setState(() {
//                         value == "all" ? selectedSelectionID = null : selectedSelectionID = value.toString();
//                       });
//                     },
//                     )
//                   ),
//       SizedBox(width: 8,),            
//       ElevatedButton(onPressed: () async{
//         var filter = {
//           "name" : _ftsEditingController.text,
//           "selectionId" : selectedSelectionID
//         };
//         var data = await teamProvider.get(filter: filter);
//         setState(() {
//           teamsResult = data;
//         });
//       }, child: Icon(Icons.search)),
//       SizedBox(width: 8,),
//       ElevatedButton(onPressed: () async{
//        final actionResult = await Navigator.of(context).push(PageRouteBuilder(
//         pageBuilder: (context, animation, secondaryAnimation) => TeamsDetailsScreen(),
//         transitionsBuilder: (context, animation, secondaryAnimation, child) {
//           return FadeTransition(
//             opacity: animation,
//             child: child,
//           );
//             },
//           ));
//           if(actionResult == true)
//           {
//             initForm();
//           }
//       }, child: Text("Dodaj"))
//     ],
//   )
//   );
// }
Widget _buildResultView() {
  if (applicationResult != null) {
    if (applicationResult!.count != 0) {
      return SingleChildScrollView(
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(8.0),
          child: DataTable(
            columnSpacing: 16.0,
            horizontalMargin: 8.0,
            showCheckboxColumn: false,
            columns: const [
              DataColumn(label: Text("Tim")),
              DataColumn(label: Text("Menadžer")),
              DataColumn(label: Text("Status uplate")),
              DataColumn(label: Text("Status prijave")),
            ],
            rows: applicationResult!.result.map((e) => DataRow(
              onSelectChanged: (_) => _handleRowTap(e),
              cells: [
                DataCell(Text(e.team?.name ?? "")),
                DataCell(Text('${e.team?.user?.firstName ?? ''} ${e.team?.user?.lastName ?? ''}'),),
                DataCell(Text(
                  e.isPaId != null ? (e.isPaId == true ? 'Uplaćeno' : 'Nije uplaćeno') : 'Na obradi',
                )),
                DataCell(Text(
                  e.isAccepted != null ? (e.isAccepted == true ? 'Prihvaćena' : 'Odbijena') : 'Na obradi',
                )),
              ],
            )).toList(),
          ),
        ),
      );
    } else {
      return const Align(alignment: Alignment.center, child: Text('Nema podataka'),);
    }
  } else {
    return Container(
      height: MediaQuery.of(context).size.height * 0.7,
      width: double.infinity,
      alignment: Alignment.center,
      child: const CircularProgressIndicator(),
    );
  }
}


  _handleRowTap(Applications selectedApplication) async{
    final shouldReload = await showDialog<bool>(
    context: context,
    builder: (context) => ApplicationDialog(application: selectedApplication,),
    );

    if (shouldReload == true) {
      initForm();
    }
  }
}

