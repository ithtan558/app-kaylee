import 'package:core_plugin/src/navigator/bundle.dart';
import 'package:core_plugin/src/navigator/page_intent.dart';
import 'package:flutter/widgets.dart';

extension NavigatorBuildContextExtension on BuildContext {
  NavigatorState _navState({bool? rootNavigator}) =>
      Navigator.of(this, rootNavigator: rootNavigator ?? false);

  Future<Bundle?> push(PageIntent intent) {
    return _navState(rootNavigator: intent.rootNavigator)
        .pushNamed<Bundle>(intent.screen.toString(), arguments: intent);
  }

  ///replace screen hiện tại bởi [intent.screen]
  ///[resultBundle] là result trả về của old route đã bị replace
  Future<Bundle?> pushReplacement(PageIntent intent, {Bundle? resultBundle}) {
    return _navState(rootNavigator: intent.rootNavigator)
        .pushReplacementNamed<Bundle, Bundle>(intent.screen.toString(),
            result: resultBundle, arguments: intent);
  }

  void pop({Bundle? resultBundle, bool? rootNavigator}) {
    if (_navState(rootNavigator: rootNavigator).canPop()) {
      _navState(rootNavigator: rootNavigator).pop<Bundle>(resultBundle);
    }
  }

  ///push screen mới và pop các screen trước đó nếu thoả điều kiện [predicate]
  Future<Bundle?> pushAndRemoveUntil(
      PageIntent intent, RoutePredicate predicate) {
    return _navState(rootNavigator: intent.rootNavigator)
        .pushNamedAndRemoveUntil<Bundle>(intent.screen.toString(), predicate,
            arguments: intent);
  }

  ///push screen và pop đến khi gặp screen đầu tiên thì không pop nữa
  Future<Bundle?> pushToFirst(PageIntent intent) {
    return pushAndRemoveUntil(intent, (route) => route.isFirst);
  }

  ///push screen mới lên top of stack và clear tất cả những screen bên dưới nó
  Future<Bundle?> pushToTop(PageIntent intent) {
    return pushAndRemoveUntil(intent, (route) => false);
  }

  ///pop screen đến khi gặp [intent.screen] thì ko pop nữa
  void popUntilScreen(PageIntent intent) {
    popUntil(ModalRoute.withName(intent.screen.toString()),
        rootNavigator: intent.rootNavigator);
  }

  ///pop screen đến khi gặp [intent.screen] thì ko pop nữa
  ///nếu [intent.screen] == null, thì sẽ pop tới trang đầu tiên
  void popUntilScreenOrFirst({PageIntent? intent}) {
    popUntil(
      (route) {
        return '${intent?.screen}' == route.settings.name || route.isFirst;
      },
      rootNavigator: intent?.rootNavigator,
    );
  }

  ///pop screen đến khi gặp [intent.screen] thì thoả điều kiện của [predicate] thì mới dừng pop
  void popUntil(RoutePredicate predicate, {bool? rootNavigator}) {
    _navState(rootNavigator: rootNavigator).popUntil(predicate);
  }
}
