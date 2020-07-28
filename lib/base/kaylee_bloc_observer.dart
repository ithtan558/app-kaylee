import 'package:anth_package/anth_package.dart';

class KayleeBlocObserver extends BlocObserver {
  final void Function(dynamic currentState, dynamic nextState) transition;

  KayleeBlocObserver({this.transition});

  @override
  void onTransition(Cubit cubit, Transition transition) {
    this.transition?.call(transition.currentState, transition?.nextState);
    super.onTransition(cubit, transition);
  }
}
