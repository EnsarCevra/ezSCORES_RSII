import 'dart:convert';
import 'package:ezscores_mobile/models/cities.dart';
import 'package:ezscores_mobile/providers/CitiesProvider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

String formatNumber(dynamic)
{
  var f = NumberFormat('###,00');
  if(dynamic == null)
  {
    return "";
  }
  return f.format(dynamic);
}

Image imageFromString(String input)
{
  return Image.memory(base64Decode(input), fit: BoxFit.contain,);
}

String formatDate(String date) {
  return DateFormat('dd.MM.yyyy').format(DateTime.parse(date).toLocal());
}

String formatDateTime(DateTime? date) {
  if (date == null) return "-";
  return DateFormat('dd.MM.yyyy HH:mm').format(date.toLocal());
}

String formatDateOnly(DateTime? date) {
  if (date == null) return "-";
  return DateFormat('dd.MM.yyyy').format(date.toLocal());
}

String formatTimeOnly(DateTime? date) {
  if (date == null) return "-";
  return DateFormat('HH:mm').format(date.toLocal());
}

void showBottomRightNotification(BuildContext context, String message) {
   final overlay = Overlay.of(context);
    final overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        bottom: 20,
        right: 20,
        child: Material(
          color: Colors.transparent,
          child: AnimatedOpacity(
            duration: Duration(milliseconds: 300),
            opacity: 1,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 8,
                    offset: Offset(2, 2),
                  ),
                ],
              ),
              child: Text(
                message,
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ),
      ),
    );

  overlay.insert(overlayEntry);

  // Remove it after 3 seconds
  Future.delayed(Duration(seconds: 5), () {
    overlayEntry.remove();
  });
}

void showErrorBottomNotification(BuildContext context, String message) {
  final overlay = Overlay.of(context);
    final overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        bottom: 20,
        right: 20,
        child: Material(
          color: Colors.transparent,
          child: AnimatedOpacity(
            duration: Duration(milliseconds: 300),
            opacity: 1,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 8,
                    offset: Offset(2, 2),
                  ),
                ],
              ),
              child: Text(
                message,
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ),
      ),
    );

  overlay.insert(overlayEntry);

  // Remove it after 3 seconds
  Future.delayed(Duration(seconds: 5), () {
    overlayEntry.remove();
  });
}

Widget buildCityTypeAheadField({
  required BuildContext context,
  required String name,
  required TextEditingController controller,
  required Cities? selectedCity,
  required ValueChanged<Cities?> onChanged,
  AxisDirection direction = AxisDirection.down,
  bool isRequired = false,
}) {
  final cityProvider = Provider.of<CityProvider>(context, listen: false);

  return FormBuilderField<Cities>(
    name: name,
    initialValue: selectedCity,
    validator: (value) {
      if (isRequired && value == null) {
        return 'Grad je obavezan';
      }
      return null;
    },
    builder: (FormFieldState<Cities?> field) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TypeAheadFormField<Cities>(
            suggestionsBoxDecoration: const SuggestionsBoxDecoration(
              constraints: BoxConstraints(maxHeight: 200),
            ),
            validator: (value) {
              if(value != null && value.isNotEmpty && selectedCity == null)
              {
                return 'Odaberite grad iz ponuđene liste';
              }
              return null;
            },
            suggestionsBoxVerticalOffset: -0.5,
            direction: direction,
            textFieldConfiguration: TextFieldConfiguration(
              controller: controller,
              decoration: InputDecoration(
                labelText: 'Grad',
                errorText: field.errorText,
                suffixIcon: selectedCity != null
                    ? IconButton(
                        icon: Icon(Icons.clear),
                        onPressed: () {
                          controller.clear();
                          onChanged(null);
                          field.didChange(null);
                        },
                      )
                    : null,
              ),
            ),
            autovalidateMode: AutovalidateMode.onUserInteraction,
            minCharsForSuggestions: 2,
            suggestionsCallback: (pattern) async {
              final data = await cityProvider.get(filter: {"name": pattern});
              return data.result;
            },
            itemBuilder: (context, city) =>
                ListTile(title: Text(city.name ?? '')),
            onSuggestionSelected: (city) {
              controller.text = city.name ?? '';
              onChanged(city);
              field.didChange(city); // Notify FormBuilder
            },
          ),
        ],
      );
    },
  );
}

Future<bool> showConfirmDeleteDialog(BuildContext context, {String? title, String? content, String? confirmMessage}) async {
  final result = await showDialog<bool>(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(title ?? 'Upozorenje'),
      content: Text(content ?? 'Jeste li sigurni da želite izbrisati ovaj zapis?'),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: const Text('Odustani'),
        ),
        ElevatedButton(
          onPressed: () => Navigator.of(context).pop(true),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red,
          ),
          child: Text(confirmMessage ?? 'Izbriši'),
        ),
      ],
    ),
  );

  return result ?? false;
}
Future<void> deleteEntity({
  required BuildContext context,
  required Future<void> Function(int id) deleteFunction,
  required int entityId,
  required VoidCallback onDeleted,
}) async {
  bool confirmed = await showConfirmDeleteDialog(
    context,
    content: 'Jeste li sigurni da želite izbrisati stavku?',
  );

  if (confirmed) {
    try {
      await deleteFunction(entityId);

      if (context.mounted) {
        showBottomRightNotification(context, 'Stavka uspješno obrisana');
        onDeleted();
      }
    } catch (e) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("Greška"),
          content: Text(e.toString()),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("OK"),
            )
          ],
        ),
      );
    }
  }
}
String capitalize(String s) => s.isNotEmpty ? '${s[0].toUpperCase()}${s.substring(1)}' : s;


