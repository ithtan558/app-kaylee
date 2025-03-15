import 'package:core_plugin/core_plugin.dart';
import 'package:flutter/material.dart';

extension ObjectUtils on Object? {
  bool get isNull => this == null;

  bool get isNotNull => !isNull;
}

extension StringExtension on String? {
  bool get isNullOrEmpty => isNull || this!.isEmpty;

  bool get isNotNullAndEmpty => !isNullOrEmpty;

  String plus(String s) => (this ?? '') + s;

  String? removeVnAccent() {
    const aRegex = '[á,à,ả,ã,ạ,â,ấ,ầ,ẩ,ẫ,ậ,ă,ắ,ằ,ẳ,ẵ,ặ]';
    const dRegex = '[đ]';
    const eRegex = '[é,è,ẻ,ẽ,ẹ,ê,ế,ề,ể,ễ,ệ]';
    const iRegex = '[í,ì,ỉ,ĩ,ị]';
    const oRegex = '[ó,ò,ỏ,õ,ọ,ô,ố,ồ,ổ,ỗ,ộ,ơ,ớ,ờ,ở,ỡ,ợ]';
    const uRegex = '[ú,ù,ủ,ũ,ụ,ư,ứ,ừ,ử,ữ,ự]';
    const yRegex = '[ý,ỳ,ỷ,ỹ,ỵ]';

    String? result = isNull
        ? null
        : this!
            .replaceAll(RegExp(aRegex), 'a')
            .replaceAll(RegExp(aRegex.toUpperCase()), 'A')
            .replaceAll(RegExp(dRegex), 'd')
            .replaceAll(RegExp(dRegex.toUpperCase()), 'D')
            .replaceAll(RegExp(eRegex), 'e')
            .replaceAll(RegExp(eRegex.toUpperCase()), 'E')
            .replaceAll(RegExp(iRegex), 'i')
            .replaceAll(RegExp(iRegex.toUpperCase()), 'I')
            .replaceAll(RegExp(oRegex), 'o')
            .replaceAll(RegExp(oRegex.toUpperCase()), 'O')
            .replaceAll(RegExp(uRegex), 'u')
            .replaceAll(RegExp(uRegex.toUpperCase()), 'U')
            .replaceAll(RegExp(yRegex), 'y')
            .replaceAll(RegExp(yRegex.toUpperCase()), 'Y');

    return result;
  }

  ///chuỗi string này có tồn tại [keyword] hay ko
  bool contain(String keyword) {
    return removeVnAccent()
            ?.trim()
            .toLowerCase()
            .contains(keyword.removeVnAccent()?.trim().toLowerCase() ?? '') ??
        false;
  }
}

extension ListExtension on List? {
  bool get isNullOrEmpty => isNull || this!.isEmpty;

  bool get isNotNullAndEmpty => !isNullOrEmpty;
}

extension IntExtension on int? {
  DateTime get toDateTimeFromServer =>
      DateTime.fromMillisecondsSinceEpoch((this ?? 0) * 1000);

  DateTime get toDateTime => DateTime.fromMillisecondsSinceEpoch(this ?? 0);
}

extension BuildContextExtension on BuildContext {
  Size get screenSize => MediaQuery.of(this).size;

  ThemeData get theme => Theme.of(this);

  TextTheme get textTheme => theme.textTheme;

  double scaleWidth(double width) {
    return width * screenSize.width / designWidth;
  }

  double scaleHeight(double height) {
    return height * screenSize.height / designHeight;
  }

  double get screenWidthRatio => screenSize.width / designWidth;

  double get screenHeightRatio => screenSize.height / designHeight;

  double screenWidthFraction(double percent) {
    return screenSize.width * percent / 100;
  }

  double screenHeightFraction(double percent) {
    return screenSize.height * percent / 100;
  }

  RefreshBloc? get refresh => read<RefreshBloc>();
}

extension NumExtension on num {
  bool get isOdd => this % 2 != 0;

  bool get isEven => this % 2 == 0;
}

extension DateTimeExtension on DateTime {
  String toFormatString({String? pattern}) {
    return DateFormat(pattern ?? 'yyyy/MM/dd HH:mm:ss').format(this);
  }

  DateTime setTime(Duration time) => DateTime(year, month, day).add(time);

  DateTime setTimeToStartOfDay() => setTime(Duration.zero);

  DateTime setTimeToEndOfDay() =>
      setTime(const Duration(hours: 23, minutes: 59, seconds: 59));
}

extension DurationExtension on Duration {
  double get days => inHours / Duration.hoursPerDay;

  double get hours => (days - days.floorToDouble()) * Duration.hoursPerDay;

  double get minutes => double.parse(_splitTime[1]);

  double get seconds => double.parse(_splitTime.last);

  List<String> get _splitTime => toString().split('.').first.split(':');
}

extension DoubleExtension on double {
  String format(String pattern) => NumberFormat(pattern).format(this);
}

extension BlocExtension on BuildContext {
  C? bloc<C extends BlocBase<Object?>>() {
    try {
      return read<C>();
    } catch (_) {
      try {
        return watch<C>();
      } catch (_) {
        return null;
      }
    }
  }
}

extension RepositoryExtension on BuildContext {
  T? repository<T>() {
    try {
      return read<T>();
    } catch (_) {
      try {
        return watch<T>();
      } catch (_) {
        return null;
      }
    }
  }
}

extension MapExtension<K, V> on Map<K, V> {
  V? value(K key, {V? defaultValue}) => isNotNull ? this[key] : defaultValue;

  ///reverse Map<K,V> => Map<V,K>
  Map<V, K> reverse() {
    return map<V, K>((key, value) => MapEntry(value, key));
  }
}
