import 'package:intl/intl.dart';

class Helpers {
  static String today() {
    var now = DateTime.now();
    var formatter = DateFormat("MMddyyyy");
    return formatter.format(now);
  }
}
