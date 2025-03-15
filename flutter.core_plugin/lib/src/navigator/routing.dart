import 'package:core_plugin/core_plugin.dart';
import 'package:flutter/material.dart';

abstract class Routing {
  ///override ở main, để get screen trong app theo [Type]
  Widget getRoutes(Type? screen) => screenNotFound;

  ///gọi để set ở [MaterialApp.onGenerateRoute]
  Route<Bundle> onGenerateRoute(RouteSettings settings) {
    final intent = settings.arguments as PageIntent?;
    final bundle = intent?.bundle ?? Bundle.empty();

    return MaterialPageRoute(
      builder: (context) {
        return RepositoryProvider<Bundle>.value(
            value: bundle, child: getRoutes(intent?.screen));
      },
      settings: settings.copyWith(
        arguments: intent?.copyWith(bundle: bundle),
      ),
    );
  }
}

Widget screenNotFound = const Material(
  child: Center(
    child: Text('Screen is not found!'),
  ),
);

extension RoutingBuildContextExtension on BuildContext {
  Bundle? get bundle {
    try {
      return read<Bundle>();
    } catch (_) {
      return null;
    }
  }

  T? getArguments<T>() {
    try {
      return bundle?.args as T?;
    } catch (_) {
      return null;
    }
  }
}
