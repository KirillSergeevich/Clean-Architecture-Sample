import 'package:flutter/material.dart';

abstract class DatePicker {
  static Future<void> pickDate({
    required BuildContext context,
    required DateTime initialDate,
    required Function(DateTime) onDatePicked,
  }) async {
    var date = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: initialDate,
      lastDate: DateTime(initialDate.year + 5),
    );
    if (date != null) {
      final time = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.fromDateTime(date),
      );
      if (time != null) {
        date = DateTime(date.year, date.month, date.day, time.hour, time.minute);
        onDatePicked(date);
      }
    }
  }
}
