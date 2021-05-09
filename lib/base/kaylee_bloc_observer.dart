import 'package:anth_package/anth_package.dart';

class KayleeBlocObserver extends BlocObserver {
  //khi bloc extend Bloc
  final void Function(dynamic currentState, dynamic nextState)? transition;

  //khi bloc extend Cubit
  final void Function(BlocBase cubit, Change change)? change;

  KayleeBlocObserver({this.transition, this.change});

  @override
  void onTransition(Bloc bloc, Transition transition) {
    this.transition?.call(transition.currentState, transition.nextState);
    super.onTransition(bloc, transition);
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    this.change?.call(bloc, change);
    super.onChange(bloc, change);
  }
}
