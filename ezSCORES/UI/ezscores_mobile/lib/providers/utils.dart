import 'dart:convert';
import 'package:ezscores_mobile/models/cities.dart';
import 'package:ezscores_mobile/providers/CitiesProvider.dart';
import 'package:ezscores_mobile/providers/auth_provider.dart';
import 'package:ezscores_mobile/screens/login_screen.dart';
import 'package:flutter/material.dart';
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

void showMobileNotification(BuildContext context, String message) {
  final overlay = Overlay.of(context);
  late OverlayEntry overlayEntry;
  late AnimationController controller;
  late Animation<Offset> offsetAnimation;

  controller = AnimationController(
    duration: const Duration(milliseconds: 300),
    vsync: Navigator.of(context), // Use Navigator's TickerProvider
  );

  offsetAnimation = Tween<Offset>(
    begin: const Offset(0, 1), // starts just below screen
    end: const Offset(0, 0),   // slides into place
  ).animate(CurvedAnimation(
    parent: controller,
    curve: Curves.easeOut,
  ));

  overlayEntry = OverlayEntry(
    builder: (context) => Positioned(
      bottom: 40,
      left: 20,
      right: 20,
      child: Material(
        color: Colors.transparent,
        child: SlideTransition(
          position: offsetAnimation,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: Colors.green,
              borderRadius: BorderRadius.circular(12),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 8,
                  offset: Offset(2, 2),
                ),
              ],
            ),
            child: Text(
              message,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
              ),
            ),
          ),
        ),
      ),
    ),
  );

  overlay.insert(overlayEntry);
  controller.forward(); // start the animation

  // Remove after 3 seconds with reverse animation
  Future.delayed(const Duration(seconds: 3), () async {
    await controller.reverse();
    overlayEntry.remove();
    controller.dispose();
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
            duration: const Duration(milliseconds: 300),
            opacity: 1,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(8),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 8,
                    offset: Offset(2, 2),
                  ),
                ],
              ),
              child: Text(
                message,
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ),
        ),
      ),
    );

  overlay.insert(overlayEntry);

  // Remove it after 3 seconds
  Future.delayed(const Duration(seconds: 5), () {
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
                        icon: const Icon(Icons.clear),
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
        showMobileNotification(context, 'Stavka uspješno obrisana');
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

class LogoutButton extends StatelessWidget {
  const LogoutButton({Key? key}) : super(key: key);

  void _logout(BuildContext context) {
    AuthProvider.username = "";
    AuthProvider.password = "";
    AuthProvider.id = null;
    AuthProvider.firstName = null;
    AuthProvider.lastName = null;
    AuthProvider.userName = null;
    AuthProvider.picture = null;
    AuthProvider.email = null;
    AuthProvider.phoneNumber = null;
    AuthProvider.organization = null;
    AuthProvider.roleID = null;
    AuthProvider.roleDecription = null;
    AuthProvider.roleName = null;

    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => const LoginPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AuthProvider.isLoggedIn()
      ? IconButton(
          icon: const Icon(Icons.logout),
          tooltip: "Logout",
          onPressed: () => _logout(context),
        )
      : const SizedBox.shrink();
  }
}



