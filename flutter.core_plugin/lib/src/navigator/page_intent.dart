import 'package:core_plugin/src/navigator/bundle.dart';

class PageIntent {
  final Type screen;

  ///khi muốn dùng context từ thằng root navigator của app
  final bool rootNavigator;

  final Bundle? bundle;

  PageIntent({required this.screen, this.bundle, this.rootNavigator = false});

  PageIntent copyWith({Type? screen, Bundle? bundle, bool? rootNavigator}) {
    return PageIntent(
      screen: screen ?? this.screen,
      bundle: bundle ?? this.bundle,
      rootNavigator: rootNavigator ?? this.rootNavigator,
    );
  }
}
