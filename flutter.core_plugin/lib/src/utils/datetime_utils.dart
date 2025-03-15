import 'package:intl/intl.dart';

class DataTimeUtils {
  static const String formatDefault =
      '${DateFormat.HOUR24 + DateFormat.HOUR24}:${DateFormat.MINUTE + DateFormat.MINUTE}:${DateFormat.SECOND + DateFormat.SECOND}';
  static const String format1 =
      '${DateFormat.HOUR24 + DateFormat.HOUR24}:${DateFormat.MINUTE + DateFormat.MINUTE} '
      '${DateFormat.DAY + DateFormat.DAY}/${DateFormat.NUM_MONTH + DateFormat.NUM_MONTH}/${DateFormat.YEAR + DateFormat.YEAR + DateFormat.YEAR + DateFormat.YEAR}';

  static String milliSecondToDateString(int milliseconds,
          {String format = formatDefault}) =>
      DateFormat(format).format(
          DateTime.fromMillisecondsSinceEpoch(milliseconds, isUtc: true));
}
