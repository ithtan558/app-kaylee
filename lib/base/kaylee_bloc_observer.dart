import 'package:anth_package/anth_package.dart';

class KayleeBlocObserver extends BlocObserver {
  final void Function(dynamic currentState, dynamic nextState) transition;
  final void Function(Cubit cubit, Change change) change;

  KayleeBlocObserver({this.transition, this.change});

  @override
  void onTransition(Cubit cubit, Transition transition) {
    this.transition?.call(transition.currentState, transition?.nextState);
    super.onTransition(cubit, transition);
  }

  @override
  void onChange(Cubit cubit, Change change) {
    this.change?.call(cubit, change);
    super.onChange(cubit, change);
  }
}
