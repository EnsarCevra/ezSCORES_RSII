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

String formatDateTime(String date) {
  return DateFormat('dd.MM.yyyy HH:mm').format(DateTime.parse(date).toLocal());
}


void showSuccessSnackBar(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
      backgroundColor: Colors.green,
      duration: Duration(seconds: 3),
    ),
  );
}

void showErrorSnackBar(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
      backgroundColor: Colors.red,
      duration: Duration(seconds: 3),
    ),
  );
}
