import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

Future<String> selectDate(BuildContext context) async {
  final DateTime? picked = await showDatePicker(context: context, initialDate: DateTime.now(), firstDate: DateTime(1990, 1), lastDate: DateTime.now());
  if (picked != null) {
    return DateFormat('yyyy-MM-dd').format(picked);
  }
  return '';
}
