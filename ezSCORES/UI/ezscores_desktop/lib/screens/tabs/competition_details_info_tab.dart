import 'dart:convert';
import 'dart:io';
import 'package:ezscores_desktop/dialogs/competition_recommendation_dialog.dart';
import 'package:ezscores_desktop/helpers/state_machine/competition_state_transitions.dart';
import 'package:ezscores_desktop/models/cities.dart';
import 'package:ezscores_desktop/models/competitions.dart';
import 'package:ezscores_desktop/models/enums/competitionStatus.dart';
import 'package:ezscores_desktop/models/enums/competitionType.dart';
import 'package:ezscores_desktop/models/search_result.dart';
import 'package:ezscores_desktop/models/selections.dart';
import 'package:ezscores_desktop/providers/CitiesProvider.dart';
import 'package:ezscores_desktop/providers/CompetitionsProvider.dart';
import 'package:ezscores_desktop/providers/SelectionProvider.dart';
import 'package:ezscores_desktop/providers/auth_provider.dart';
import 'package:ezscores_desktop/providers/base_provider.dart';
import 'package:ezscores_desktop/providers/utils.dart';
import 'package:ezscores_desktop/screens/tabs/competitions_aditidional_settings_tab.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class CompetitionDetailsTab extends StatefulWidget {
  Competitions? competition;
  final void Function()? onStateChanged;
  CompetitionDetailsTab({super.key, this.competition, this.onStateChanged});

  @override
  _CompetitionDetailsTabState createState() => _CompetitionDetailsTabState();
}

class _CompetitionDetailsTabState extends State<CompetitionDetailsTab> {
  final _formKey = GlobalKey<FormBuilderState>();
  late CompetitionProvider competitionProvider;
  late SelectionProvider selectionProvider;
  late CityProvider cityProvider;
  SearchResult<Selections>? selectionResult = null;
  Map<String, dynamic> _initialValue = {};
  String? _base64Image;
  Cities? _selectedCity = null;
  String? _selectedSelectionID;
  int? _selectedCompetitionType;
  int? _selectedStatus;
  bool hasFee = false;
  bool _isFormEditable = false;

  late Competitions? _competition;

  @override
  void initState() {
    super.initState();
    competitionProvider = context.read<CompetitionProvider>();
    selectionProvider = context.read<SelectionProvider>();
    cityProvider = context.read<CityProvider>();
    _initialValue = {
      "name": widget.competition?.name,
      "startDate": widget.competition?.startDate,
      "applicationEndDate": widget.competition?.applicationEndDate,
      "selectionId" : widget.competition?.selectionId,
      "cityId" : widget.competition?.cityId,
      "season" : widget.competition?.season,
      "description" : widget.competition?.description,
      "competitionType" : widget.competition?.competitionType?.index,
      "status" : widget.competition?.status?.index,
      "maxTeamCount" : widget.competition?.maxTeamCount.toString(),
      "maxPlayersPerTeam" : widget.competition?.maxPlayersPerTeam.toString(),
      "fee" : widget.competition?.fee.toString(),
      "imageId": widget.competition?.picture,
    };
    _competition = widget.competition;
    initForm();
  }
  
Future<void> _showRecommendationDialog() async {
  showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => CompetitionRecommendationDialog(
        getRecommendation: () => competitionProvider.recommendCompetitionSetup(AuthProvider.id!),
        onAccept: (recommendation) {
          _selectedCompetitionType = recommendation.competitionType!.index;
          _formKey.currentState?.fields['competitionType']?.didChange(recommendation.competitionType!.index);
          _formKey.currentState?.fields['maxTeamCount']?.didChange(recommendation.maxTeamCount.toString());
          _formKey.currentState?.fields['maxPlayersPerTeam']?.didChange(recommendation.maxPlayersPerTeam.toString());
          setState(() {});
        },
      ),
    ); 
}
  Future initForm() async {
    var selectionData = await selectionProvider.get();
    setState(() {
      _isFormEditable = _competition == null || _competition?.status == CompetitionStatus.preparation;
      hasFee = _competition?.fee != null;
      selectionResult = selectionData;
      _base64Image = _competition?.picture;
      _selectedCity = _competition?.city;
      _selectedCompetitionType = _competition?.competitionType!.index;
      _selectedStatus = _competition?.status!.index;
      if(_selectedCity != null)
      {
        _cityController.text = _selectedCity!.name ?? '';
      } 
    });
    if(_competition == null)
    {
      _showRecommendationDialog();
    }
  }

  @override
  Widget build(BuildContext context) {
     if (selectionResult == null) {
      return const Expanded(child: Align(alignment: Alignment.center, child: CircularProgressIndicator(),),);
    }
    return Expanded(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: SizedBox(
            width: 900,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                if(_competition != null && _competition?.status != CompetitionStatus.finished)_buildStateNavigation(),
                _buildForm(),
                _saveRow(),
              ],
            ),
          ),
        ),
      ),
    );
  }
  final TextEditingController _cityController = TextEditingController();
  Widget _buildForm() {
    return Column(
      children: [
        Padding(
      padding: const EdgeInsets.all(12.0),
      child: Text(
        _isFormEditable
            ? "Osnovni podaci"
            : "Uređivanje je moguće samo u stanju pripreme!",
        style: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.bold,
          color: _isFormEditable ? Colors.black : Colors.redAccent,
        ),
      ),
    ),
        FormBuilder(
            key: _formKey,
            enabled: _isFormEditable,
            initialValue: _initialValue,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: FormBuilderField<String>(
                          enabled: _isFormEditable,
                          name: "imageId",
                          builder: (field) {
                            return AbsorbPointer(
                              absorbing: !_isFormEditable,
                              child: Opacity(
                                opacity: _isFormEditable ? 1.0 : 0.8,
                                child: Column(
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
                                            child: _base64Image != null
                                                ? Image.memory(
                                                    base64Decode(_base64Image!),
                                                    height: 150,
                                                    fit: BoxFit.cover,
                                                  )
                                                : const Icon(
                                                    Icons.sports_soccer,
                                                    size: 150,
                                                  ),
                                          ),
                                          ListTile(
                                            leading: const Icon(Icons.image),
                                            title: Text(
                                              _base64Image == null
                                                  ? "Odaberi sliku"
                                                  : "Promijeni sliku",
                                            ),
                                            trailing: const Icon(Icons.file_upload),
                                            onTap: _isFormEditable
                                                ? () async {
                                                    final result = await getImage();
                                                    if (result != null) {
                                                      field.didChange(result);
                                                      setState(() {
                                                        _base64Image = result;
                                                      });
                                                    }
                                                  }
                                                : null,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(width: 30),
                  Row(
                    children: [
                      Expanded(
                        child: FormBuilderTextField(
                          name: 'name',
                          decoration: const InputDecoration(labelText: "Naziv takmičenja"),
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: FormBuilderValidators.compose([
                            FormBuilderValidators.required(errorText: 'Naziv je obavezan'),
                            FormBuilderValidators.minLength(3, errorText: 'Naziv mora imati barem 3 slova'),
                          ]),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(width: 30),
                  Row(
                    children: [
                      Expanded(
                        child: buildCityTypeAheadField(
                          context: context,
                          name: "city",
                          controller: _cityController,
                          selectedCity: _selectedCity,
                          direction: AxisDirection.up,
                          isRequired: true,
                          isEnabled: _isFormEditable,
                          onChanged: (city) {
                            setState(() {
                              _selectedCity = city;
                            });
                          },
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: FormBuilderDropdown(
                          name: "selectionId",
                          decoration: const InputDecoration(
                            labelText: "Selekcija",
                          ),
                          validator: FormBuilderValidators.compose(
                            [
                              FormBuilderValidators.required(errorText: 'Selekcija je obavezna'),
                            ]
                          ),
                          focusColor: Colors.transparent,
                          items: (selectionResult != null)
                            ? selectionResult!.result.map((item) =>
                                DropdownMenuItem(
                                  value: item.id,
                                  child: Text(item.name ?? ""),
                                ),
                              ).toList()
                            : [],
                          )),
                    ],
                  ),
                  const SizedBox(width: 30),
                  Row(
                    children: [
                      Expanded(
                        child: FormBuilderDateTimePicker(
                          name: 'startDate',
                          format: DateFormat('dd.MM.yyyy'),
                          inputType: InputType.date,
                          decoration: const InputDecoration(
                            labelText: 'Početak takmičenja',
                            suffixIcon: Icon(Icons.calendar_today),
                          ),
                          firstDate: DateTime.now(),
                          lastDate: DateTime(DateTime.now().year + 100),
                          validator: FormBuilderValidators.required(errorText: 'Obavezno polje')
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: FormBuilderField<DateTime>(
                          name: 'applicationEndDate',
                          validator: (value) {
                            if (value == null) {
                              return 'Obavezno polje';
                            }

                            final startDate = _formKey.currentState?.fields['startDate']?.value;
                            if (startDate != null && value.isAfter(startDate) || value == startDate) {
                              return 'Prijave se moraju zatvoriti prije početka takmičenja!';
                            }

                            return null;
                          },
                          builder: (field) {
                            final value = field.value;
                            final errorText = field.errorText;
                            return GestureDetector(
                              onTap: () async {
                                final pickedDate = await showDatePicker(
                                  context: field.context,
                                  initialDate: value ?? DateTime.now(),
                                  firstDate: DateTime.now(),
                                  lastDate: DateTime(DateTime.now().year + 100),
                                );

                                if (pickedDate != null) {
                                  field.didChange(pickedDate);
                                }
                              },
                              child: AbsorbPointer(
                                child: TextFormField(
                                  controller: TextEditingController(
                                    text: value == null
                                        ? ''
                                        : DateFormat('dd.MM.yyyy').format(value),
                                  ),
                                  decoration: InputDecoration(
                                    labelText: 'Kraj prijava',
                                    suffixIcon: const Icon(Icons.calendar_today),
                                    errorText: errorText,
                                    enabled: _isFormEditable
                                  ),
                                  readOnly: true,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(width: 30),
                  Row(
                    children: [
                      Expanded(
                        child: FormBuilderDropdown<int>(
                          name: 'competitionType',
                          decoration: const InputDecoration(
                            labelText: 'Tip/Vrsta',
                          ),
                          focusColor: Colors.transparent,
                          items: CompetitionType.values
                              .map((type) => DropdownMenuItem<int>(
                                    value: type.value,
                                    child: Text(type.displayName),
                                  ))
                              .toList(),
                          onChanged: (value) {
                            setState(() {
                              _selectedCompetitionType = value;
                            });
                          },
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: FormBuilderTextField(
                          name: 'season',
                          decoration: const InputDecoration(
                            labelText: "Sezona (npr. 2024/2025)",
                          ),
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: FormBuilderValidators.compose([
                            FormBuilderValidators.required(errorText: 'Sezona je obavezna'),
                            FormBuilderValidators.match(
                              r'^(\d{4}|\d{2}\/\d{2}|\d{4}\/\d{2}|\d{4}\/\d{4})$',
                              errorText: 'Format mora biti npr. 2025, 24/25, 2024/25 ili 2024/2025',
                            ),
                          ]),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                    Expanded(
                         child: FormBuilderTextField(
                           name: 'maxTeamCount',
                           decoration: const InputDecoration(labelText: 'Maksimalan broj timova'),
                           keyboardType: TextInputType.number,
                           autovalidateMode: AutovalidateMode.onUserInteraction,
                           validator: FormBuilderValidators.compose([
                             FormBuilderValidators.required(errorText: 'Obavezno'),
                             FormBuilderValidators.integer(errorText: 'Mora biti cijeli broj'),
                             FormBuilderValidators.min(1, errorText: 'Minimalno 1'),
                             FormBuilderValidators.max(40, errorText: 'Maksimalno 40'),
                           ]),
                         ),
                       ),
                       const SizedBox(width: 16),
                       Expanded(
                         child: FormBuilderTextField(
                           name: 'maxPlayersPerTeam',
                           decoration: const InputDecoration(labelText: 'Maksimalno igrača po timu'),
                           keyboardType: TextInputType.number,
                           autovalidateMode: AutovalidateMode.onUserInteraction,
                           validator: FormBuilderValidators.compose([
                             FormBuilderValidators.required(errorText: 'Obavezno'),
                             FormBuilderValidators.integer(errorText: 'Mora biti cijeli broj'),
                             FormBuilderValidators.min(5, errorText: 'Minimalno 5'),
                             FormBuilderValidators.max(20, errorText: 'Maksimalno 20'),
                           ]),
                         ),
                       ),
                    ],
                  ),
                  const SizedBox(width: 30),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: AbsorbPointer(
                      absorbing: !_isFormEditable,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          FormBuilderField<bool>(
                            name: 'hasFee',
                            initialValue: hasFee,
                            builder: (field) {
                              return Row(
                                children: [
                                  const Text('Kotizacija?'),
                                  Switch(
                                    value: field.value ?? false,
                                    onChanged: (value) {
                                      field.didChange(value);
                                      setState(() {
                                        hasFee = value;
                                      });
                                    },
                                  ),
                                ],
                              );
                            },
                          ),
                          if (hasFee)
                            Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: FormBuilderTextField(
                                name: 'fee',
                                initialValue: _competition?.fee != null ? _competition!.fee.toString() : '',
                                decoration: const InputDecoration(
                                  labelText: 'Kotizacija (KM)',
                                ),
                                keyboardType: TextInputType.number,
                                validator: FormBuilderValidators.compose([
                                  FormBuilderValidators.required(errorText: 'Unesite iznos kotizacije'),
                                  FormBuilderValidators.numeric(errorText: 'Iznos mora biti broj'),
                                  FormBuilderValidators.min(0, errorText: 'Iznos mora biti pozitivan'),
                                  FormBuilderValidators.max(1000, errorText: 'Maksimalno 1000 KM'),
                                ]),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: FormBuilderTextField(
                          name: 'description',
                          decoration: const InputDecoration(
                            labelText: "Opis takmičenja",
                            alignLabelWithHint: true,
                          ),
                          maxLines: 5,
                          minLines: 3,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: FormBuilderValidators.compose([
                            FormBuilderValidators.required(errorText: 'Opis je obavezan'),
                            FormBuilderValidators.minLength(10, errorText: 'Opis mora imati barem 10 karaktera'),
                          ]),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
          ),
        ),
      ],
    );
  }

  Widget _saveRow() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          if (_isAllowed()) ElevatedButton(
            onPressed: () async {
              await Navigator.of(context).push(PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) => CompetitionAditionalSettingsScreen(selectedIndex: 1, competitionId: _competition!.id!,),
              transitionsBuilder: (context, animation, secondaryAnimation, child) {
                return FadeTransition(
                  opacity: animation,
                  child: child,
                );
                  },
                ));
            },
            child: const Text("Dodatne postavke")),
          const SizedBox(width: 10,),
          if(_isFormEditable)ElevatedButton(
            onPressed: () async {
              FocusScope.of(context).unfocus();
              final isValid = _formKey.currentState?.saveAndValidate();
              if (isValid == true) {
                final originalFormData = _formKey.currentState?.value;
                final formData = Map<String, dynamic>.from(originalFormData!);
                DateTime applicationEndDate = formData['applicationEndDate'];
                DateTime startDate = formData['startDate'];
                formData['startDate'] = startDate.toIso8601String();
                formData['applicationEndDate'] = applicationEndDate.toIso8601String();
                var request = Map.from(formData);
                request["picture"] = _base64Image;
                request["cityId"] = _selectedCity!.id!;
                request["fee"] = hasFee ? formData["fee"] : null;
                try {
                  final bool isNewCompetition = _competition == null;
                  if (_competition == null) {
                    _competition = await competitionProvider.insert(request);
                  } else {
                    _competition = await competitionProvider.update(_competition!.id!, request);
                  }
                  if (context.mounted) {
                    if(isNewCompetition)
                    {
                      _showInsertSuccessDialog(context);
                    }
                    else
                    {
                      showBottomRightNotification(context, 'Takmičenje uspješno ažurirano.');
                    }
                    setState(() {
                      
                    });
                  }
                } on Exception catch (exception) {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text("Error"),
                      actions: [TextButton(onPressed: () => Navigator.pop(context), child: const Text("Ok"))],
                      content: Text(exception.toString()),
                    ),
                  );
                }
              }
            },
            child: const Text("Sačuvaj"),
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
  
  _isAllowed() {//should be allowed as soon as competition is created and user should be notified that he can edit this as well after he creates competition
    if(_competition != null)
    {
      if(_competition!.status! == CompetitionStatus.preparation || _competition!.status! == CompetitionStatus.applicationsOpen || _competition!.status! == CompetitionStatus.applicationsClosed || _competition!.status! == CompetitionStatus.underway ||_competition!.status! == CompetitionStatus.finished)
      {
        return true;
      }
    }
    return false;
  }
  
  _showInsertSuccessDialog(BuildContext context) {
     showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Takmičenje uspješno kreirano"),
        content: const Text(
          "Uspješno ste kreirali takmičenje koje je sada u fazi pripreme.\n"
          "Sada možete pristupiti dodatnim postavkama za upravaljanje sudijama, sponzorima i nagradama!",
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Uredu", style: TextStyle(color: Colors.blue),),
          ),
          ElevatedButton(
            onPressed: () async {
              Navigator.pop(context);
              await Navigator.of(context).push(PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) => CompetitionAditionalSettingsScreen(selectedIndex: 1, competitionId: _competition!.id!,),
              transitionsBuilder: (context, animation, secondaryAnimation, child) {
                return FadeTransition(
                  opacity: animation,
                  child: child,
                );
                  },
                ));
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
            child: const Text("Dodatne postavke"),
          ),
        ],
      ),
    );
  }
  
Widget _buildStateNavigation() {
  if (_competition == null || _competition!.status == null) return const SizedBox();

  final current = _competition!.status!;
  final availableTransitions = transitionActions[current] ?? {};
  CompetitionStatus? previousState;
  TransitionCallback? previousCallback;
  CompetitionStatus? nextState;
  TransitionCallback? nextCallback;

  for (final entry in availableTransitions.entries) {
  final target = entry.key;

  // Choose the closest lower index for previous
  if (target.index < current.index) {
    if (previousState == null || target.index > previousState.index) {
      previousState = target;
      previousCallback = entry.value;
    }
  }

  // Choose the closest higher index for next
  if (target.index > current.index) {
    if (nextState == null || target.index < nextState.index) {
      nextState = target;
      nextCallback = entry.value;
    }
  }
}
void _goToNextStage() async {
    try {
      await nextCallback!(_competition!.id!, context);
      setState(() {
        _competition = Competitions(
        id: _competition!.id,
        userId: _competition!.userId,
        selectionId: _competition!.selectionId,
        season: _competition!.season,
        cityId: _competition!.cityId,
        name: _competition!.name,
        description: _competition!.description,
        maxTeamCount: _competition!.maxTeamCount,
        picture: _competition!.picture,
        startDate: _competition!.startDate,
        applicationEndDate: _competition!.applicationEndDate,
        fee: _competition!.fee,
        maxPlayersPerTeam: _competition!.maxPlayersPerTeam,
        competitionType: _competition!.competitionType,
        status: nextState!, // updated status
        city: _competition!.city,
        selection: _competition!.selection,
        competitionsReferees: _competition!.competitionsReferees,
        competitionsSponsors: _competition!.competitionsSponsors,
        rewards: _competition!.rewards,
        reviews: _competition!.reviews,
      );
        if(_isFormEditable == true)_isFormEditable = false;
      });
      widget.onStateChanged?.call();
      showBottomRightNotification(context, 'Status promijenjen na "${nextState!.displayName}".');
    } on UserException catch(exception){
      showDialog(
        context: context, 
        builder: (context) => AlertDialog(
          title: const Text("Greška"), 
          actions: [TextButton(onPressed: () => Navigator.pop(context), child: const Text("Ok"))], 
          content: Text(exception.toString()),));
    }
}
Future<void> _showConfirmStateChangeDialog(String message) async
{
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text("Upozorenje"),
      content: Text(message),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text("Odustani"),
        ),
        ElevatedButton( 
          onPressed: (){
            Navigator.pop(context);
            _goToNextStage();
          },
          child: const Text("Nastavi"),
        ),
      ],
    ),
  );
}
  return Padding(
    padding: const EdgeInsets.only(top: 24.0),
    child: Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(bottom: 12.0),
            child: Text(
              "Upravljanje stanjem takmičenja",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (previousState != null && previousCallback != null)
                ElevatedButton.icon(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () async {
                    try {
                      await previousCallback!(_competition!.id!, context);
                      if(previousState == CompetitionStatus.preparation)_isFormEditable = true;
                      setState(() {
                        _competition!.status = previousState!;
                      });
                      widget.onStateChanged?.call();
                      showBottomRightNotification(context, 'Status vraćen na "${previousState!.displayName}".');
                    } catch (e) {
                      _showErrorDialog("Greška pri vraćanju statusa", e.toString());
                    }
                  },
                  label: Text(previousState.displayName),
                )
              else
                const SizedBox(width: 120),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  decoration: BoxDecoration(
                    color: Colors.yellow[100],
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.orange),
                  ),
                  child: Text(
                    current.displayName,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                ),
              ),

              if (nextState != null && nextCallback != null)
                ElevatedButton.icon(
                  icon: const Icon(Icons.arrow_forward),
                  onPressed: () async {
                    try {
                      if(nextState == CompetitionStatus.finished)
                      {
                        var message = 'Jeste li sigurni da želite završiti takmičenje?\nOvo je nepovratna akcija!';
                        _showConfirmStateChangeDialog(message);
                        
                      }
                      else if(nextState == CompetitionStatus.underway)
                      {
                        var message = 'Jeste li sigurni da želite započeti takmičenje?\n\nUređivanje osnovnih infomacija neće biti dozvoljeno!\n\nOvo je nepovratna akcija!';
                        _showConfirmStateChangeDialog(message);
                      }
                      else
                      {
                        _goToNextStage();
                      }
                    } catch (e) {
                      _showErrorDialog("Greška pri promjeni statusa", e.toString());
                    }
                  },
                  label: Text(nextState.displayName),
                )
              else
                const SizedBox(width: 120),
            ],
          ),
        ],
      ),
    ),
  );
}

void _showErrorDialog(String title, String content) {
  showDialog(
    context: context,
    builder: (_) => AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: [
        TextButton(onPressed: () => Navigator.pop(context), child: const Text("OK")),
      ],
    ),
  );
}
}
