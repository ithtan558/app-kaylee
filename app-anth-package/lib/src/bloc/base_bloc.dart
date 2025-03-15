import 'package:anth_package/anth_package.dart';

abstract class BaseBloc<Event, State> extends Bloc<Event, State> {
  BaseBloc() : super(InitState() as State);

  void errorEvent(ErrorType code, {Error? error}) {
    add(ErrorEvent(code, error: error) as Event);
  }

  State errorState(ErrorEvent e) {
    return ErrorState(e.code, error: e.error) as State;
  }
}
