import 'package:anth_package/anth_package.dart';

class ReloadBloc extends Cubit<ReloadState> {
  ReloadBloc() : super(ReloadState());

  void reload({Type screen, Bundle bundle}) {
    emit(ReloadState(
      screen: screen,
      bundle: bundle,
    ));
  }
}

class ReloadState {
  final Type screen;
  final Bundle bundle;

  ReloadState({this.screen, this.bundle});
}
