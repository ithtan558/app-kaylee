import 'package:anth_package/anth_package.dart';
import 'package:kaylee/components/components.dart';
import 'package:kaylee/components/src/printer/bluetooth_printer_module.dart';
import 'package:kaylee/models/models.dart';
import 'package:kaylee/services/services.dart';

class SplashScreenBloc extends BaseBloc {
  SplashScreenBloc();

  @override
  Stream mapEventToState(e) async* {
    if (e is LoadedSharedPrefSplashScrEvent) {
      yield LoadedSharedPrefSplashScrState();
    } else if (e is GoToHomeScreenSplashScrEvent) {
      yield GoToHomeScreenSplashScrState();
    } else if (e is LoadedUserInfoEvent) {
      yield LoadedUserInfoState(userInfo: e.userInfo);
    } else if (e is ErrorLoadInfoEvent) {
      yield ErrorLoadInfoState(e.code, error: e.error);
    }
  }

  void config() async {
    await Future.wait([
      SharedRef.init(),
      PrinterModule.init(),
      BluetoothPrinterModule.init(),
    ]);
    add(LoadedSharedPrefSplashScrEvent());
  }

  void pushToHomeScreen() {
    add(GoToHomeScreenSplashScrEvent());
  }

  void loadUserInfo({UserService userService}) {
    RequestHandler(
      request: userService.getProfile(),
      onSuccess: ({message, result}) {
        add(LoadedUserInfoEvent(userInfo: result));
      },
      onFailed: (code, {error}) {
        add(ErrorLoadInfoEvent(code, error: error));
      },
    );
  }
}

class LoadedSharedPrefSplashScrEvent {}

class GoToHomeScreenSplashScrEvent {}

class GoToHomeScreenSplashScrState {}

class LoadedSharedPrefSplashScrState {}

class LoadedUserInfoEvent {
  final UserInfo userInfo;

  LoadedUserInfoEvent({this.userInfo});
}

class LoadedUserInfoState {
  final UserInfo userInfo;

  LoadedUserInfoState({this.userInfo});
}

class ErrorLoadInfoEvent extends ErrorEvent {
  ErrorLoadInfoEvent(ErrorType code, {Error error}) : super(code, error: error);
}

class ErrorLoadInfoState extends ErrorState {
  ErrorLoadInfoState(ErrorType code, {Error error}) : super(code, error: error);
}
