// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:anth_package/anth_package.dart';

void main() {
  print('[TUNG] ===> ${(1370 / 343).round()}');
  final dateTime =
      DateFormat('${'h' * 2}:${'m' * 2}:${'s' * 2}').parse('08:00:00');

  dateTime.hour;
}
