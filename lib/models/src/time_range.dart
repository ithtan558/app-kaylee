import 'package:anth_package/anth_package.dart';

class StartTime {
  String time;

  DateTime get datetime {
    final date = DateFormat('${'HH' * 2}:${'m' * 2}').parse(this.time);
    return date;
  }

  StartTime({this.time});
}

class EndTime {
  String time;

  DateTime get datetime {
    final date = DateFormat('${'HH' * 2}:${'m' * 2}').parse(this.time);
    return date;
  }

  EndTime({this.time});
}
