import 'package:anth_package/anth_package.dart';
import 'package:kaylee/apis/apis.dart';
import 'package:kaylee/components/components.dart';
import 'package:kaylee/components/src/printer/bluetooth_printer_module.dart';
import 'package:kaylee/models/models.dart';

class SplashScreenBloc extends BaseBloc {
  SplashScreenBloc();

  @override
  Stream mapEventToState(event) async* {
    if (event is LoadedSharedPrefSplashScrEvent) {
      yield LoadedSharedPrefSplashScrState();
    } else if (event is GoToHomeScreenSplashScrEvent) {
      yield GoToHomeScreenSplashScrState();
    } else if (event is LoadedUserInfoEvent) {
      yield LoadedUserInfoState(userInfo: event.userInfo);
    } else if (event is ErrorLoadInfoEvent) {
      yield ErrorLoadInfoState(event.code, error: event.error);
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

  void loadUserInfo({required UserApi userService}) {
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

  LoadedUserInfoEvent({required this.userInfo});
}

class LoadedUserInfoState {
  final UserInfo userInfo;

  LoadedUserInfoState({required this.userInfo});
}

class ErrorLoadInfoEvent extends ErrorEvent {
  ErrorLoadInfoEvent(ErrorType code, {Error? error})
      : super(code, error: error);
}

class ErrorLoadInfoState extends ErrorState {
  ErrorLoadInfoState(ErrorType code, {Error? error})
      : super(code, error: error);
}
