import 'package:anth_package/anth_package.dart';
import 'package:cubit/cubit.dart';
import 'package:kaylee/models/models.dart';

class AppBloc extends Cubit {
  AppBloc() : super(InitState());
  bool isShowingLoginDialog = false;
  final _unauthorizedController = PublishSubject<UnauthorizedState>();

  Stream get unauthorizedStream => _unauthorizedController.stream;

  void loggedIn(LoginResult result) {
    emit(LoggedInState(result: result));
  }

  void loggedOut() => emit(LoggedOutState());

  void unauthorized({Error error}) {
    _unauthorizedController.add(UnauthorizedState(error: error));
  }

  @override
  Future<void> close() {
    _unauthorizedController.close();
    return super.close();
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
