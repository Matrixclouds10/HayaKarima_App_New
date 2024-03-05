import 'package:intl/intl.dart';

class Utils {
  String getFormattedDate(int millis) {
    final DateFormat dateFormat = DateFormat.yMMMEd('ar');
    return dateFormat.format(DateTime.fromMillisecondsSinceEpoch(millis));
  }
}
