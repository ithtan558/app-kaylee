import 'package:anth_package/anth_package.dart';
import 'package:cubit/cubit.dart';
import 'package:kaylee/models/models.dart';

class AppBloc extends Cubit {
  AppBloc() : super(InitState());

  void loggedIn(LoginResult result) {
    emit(LoggedInState(result: result));
  }

  void loggedOut() => emit(LoggedOutState());
}

class LoggedInState {
  LoginResult result;

  LoggedInState({this.result});
}

class LoggedOutState {}
