import 'package:intl/intl.dart';

extension DateTimeEx on DateTime {
  static const weekdays = ['', '月', '火', '水', '木', '金', '土', '日'];

  /// DateTime => YYYY/MM/DD(W)
  String get formatYMDW {
    final ymd = DateFormat("yyyy/MM/dd").format(this);
    final w = weekdays[weekday];
    return '$ymd($w)';
  }

  /// DateTime => YYYY/MM/DD(W) HH:MM
  String get formatYMDWHM {
    final ymd = DateFormat("yyyy/MM/dd").format(this);
    final hm = DateFormat("HH:mm").format(this);
    final w = weekdays[weekday];
    return '$ymd($w) $hm';
  }
}
