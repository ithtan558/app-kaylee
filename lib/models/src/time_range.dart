import 'package:anth_package/anth_package.dart';

const String _timeFormat = 'HH:mm';

abstract class _RangTime {
  String? time;

  _RangTime({this.time});

  String? get formattedTime => time == null || time!.isEmpty
      ? null
      : DateFormat(_timeFormat).format(DateFormat(_timeFormat).parse(time!));

  DateTime? get datetime {
    if (time == null || time!.isEmpty) return null;
    final date = DateFormat(_timeFormat).parse(time!);
    return date;
  }
}

class StartTime extends _RangTime {
  StartTime({String? time}) : super(time: time);
}

class EndTime extends _RangTime {
  EndTime({String? time}) : super(time: time);
}
