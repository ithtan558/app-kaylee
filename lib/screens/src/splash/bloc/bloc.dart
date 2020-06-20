import 'package:anth_package/anth_package.dart';

class SplashScreenBloc extends BaseBloc {
  @override
  Stream mapEventToState(e) async* {
    if (e is LoadedSharedPrefSplashScrEvent) {
      yield LoadedSharedPrefSplashScrState();
    } else if (e is GoToHomeScreenSplashScrEvent) {
      yield GoToHomeScreenSplashScrState();
    }
  }

  void config() async {
    await SharedRef.init().then((value) {
      add(LoadedSharedPrefSplashScrEvent());
      return 1;
    });
  }

  void pushToHomeScreen() async {
    await Future.delayed(Duration(seconds: 2)).then((value) {
      add(GoToHomeScreenSplashScrEvent());
    });
  }
}

class LoadedSharedPrefSplashScrEvent {}

class GoToHomeScreenSplashScrEvent {}

class GoToHomeScreenSplashScrState {}

class LoadedSharedPrefSplashScrState {}
