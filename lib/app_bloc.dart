import 'package:anth_package/anth_package.dart';
import 'package:cubit/cubit.dart';
import 'package:kaylee/models/models.dart';

class AppBloc extends Cubit {
  AppBloc() : super(InitState());
  bool isShowingLoginDialog = false;

  void loggedIn(LoginResult result) {
    emit(UnauthorizedState(error: null));
  }

  void loggedOut() => emit(LoggedOutState());

  void unauthorized({Error error}) {
    if (state is! UnauthorizedState) {
      emit(UnauthorizedState(error: error));
    }
  }
}

class LoggedInState {
  LoginResult result;

  LoggedInState({this.result});
}

class LoggedOutState {}

class UnauthorizedState {
  Error error;

  UnauthorizedState({this.error});
}

class CartBloc extends Cubit<CartState> {
  CartBloc() : super(CartState());

  void updateCart() => emit(CartState());
}

class CartState {}
