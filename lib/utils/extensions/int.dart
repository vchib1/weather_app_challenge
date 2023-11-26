import 'package:intl/intl.dart';

extension DateParse on DateTime {
  String toTimeString() {
    DateFormat format = DateFormat('h:mm a');

    return format.format(this);
  }

  String toDayMonth() {
    DateFormat format = DateFormat('MMM d');

    return format.format(this);
  }

  String toDateTimeString() {

    DateFormat format = DateFormat('d/MM/yyyy h:mm a');

    return format.format(this);
  }
}
