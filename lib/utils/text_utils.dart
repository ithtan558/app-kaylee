import 'package:anth_package/anth_package.dart';

class TextUtils {
  static String _currencyFormat(dynamic amount, String local, String pattern) =>
      NumberFormat.currency(
              locale: local, customPattern: pattern, decimalDigits: 0)
          .format(amount);

  static String formatVND(dynamic amount, {String unit = ''}) =>
      _currencyFormat(amount, 'vi', '#,###${unit.isNullOrEmpty ? '' : unit}');
}
