import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

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
  return Image.memory(base64Decode(input));
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

