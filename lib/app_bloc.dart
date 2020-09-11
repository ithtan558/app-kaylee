import 'package:anth_package/anth_package.dart';
import 'package:kaylee/models/models.dart';
import 'package:kaylee/services/services.dart';

class AppBloc extends Cubit {
  final UserService userService;

  AppBloc({this.userService}) : super(InitState());
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

  void notifyUpdateProfile({UserInfo userInfo}) {
    RequestHandler(
      request: userService.getProfile(),
      onSuccess: ({message, result}) {
        emit(UpdateProfileState(
          userInfo: result,
        ));
      },
      onFailed: (code, {error}) {
        emit(UpdateProfileState(
          userInfo: userInfo,
        ));
      },
    );
  }

  void doneLoggedInSetup() => emit(DoneSetupLoggedInState());

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

class DoneSetupLoggedInState {}

class UnauthorizedState {
  Error error;

  UnauthorizedState({this.error});
}

class CartBloc extends Cubit<CartState> {
  CartBloc() : super(CartState());

  void updateCart() => emit(CartState());
}

class CartState {}

class UpdateProfileState {
  final UserInfo userInfo;

  UpdateProfileState({this.userInfo});
}
