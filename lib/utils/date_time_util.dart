import 'package:intl/intl.dart';

class DateTimeUtil {
  static String ddMMYYYY(DateTime date) {
    return DateFormat('dd-MM-yyyy').format(date);
  }
}
