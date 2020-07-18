import 'package:cubit/cubit.dart';

class KayleeCubitObserver extends CubitObserver {
  final void Function(dynamic currentState, dynamic nextState) transition;

  KayleeCubitObserver({this.transition});

  @override
  void onTransition(Cubit cubit, Transition transition) {
    this.transition?.call(transition.currentState, transition?.nextState);
    super.onTransition(cubit, transition);
  }
}
