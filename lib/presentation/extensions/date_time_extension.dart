import 'package:intl/intl.dart';

extension DateTimeExtension on DateTime {
  String formatToYMDHM() {
    return DateFormat('yyyy-MM-dd kk:mm').format(this);
  }

  bool isFuture() {
    return isAfter(DateTime.now());
  }
}
