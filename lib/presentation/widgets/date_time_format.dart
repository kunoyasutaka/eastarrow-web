import 'package:intl/intl.dart';

class DateTimeFormat {
  static const weekdays = ['', '月', '火', '水', '木', '金', '土', '日'];

  /// DateTime => YYYY/MM/DD(W)
  String formatYMDW(DateTime date) {
    final ymd = DateFormat("yyyy/MM/dd").format(date);
    final w = weekdays[date.weekday];
    return '$ymd($w)';
  }

  /// DateTime => YYYY/MM/DD(W) HH:MM
  String formatYMDWHM(DateTime date) {
    final ymd = DateFormat("yyyy/MM/dd").format(date);
    final hm = DateFormat("HH:mm").format(date);
    final w = weekdays[date.weekday];
    return '$ymd($w) $hm';
  }
}
