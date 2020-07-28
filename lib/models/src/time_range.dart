import 'package:anth_package/anth_package.dart';

const String _timeFormat = 'HH:mm';

class StartTime {
  String time;

  String get formattedTime =>
      DateFormat(_timeFormat).format(DateFormat(_timeFormat).parse(time));

  DateTime get datetime {
    final date = DateFormat(_timeFormat).parse(this.time);
    return date;
  }

  StartTime({this.time});
}

class EndTime {
  String time;

  String get formattedTime =>
      DateFormat(_timeFormat).format(DateFormat(_timeFormat).parse(time));

  DateTime get datetime {
    final date = DateFormat(_timeFormat).parse(this.time);
    return date;
  }

  EndTime({this.time});
}
