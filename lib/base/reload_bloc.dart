import 'package:anth_package/anth_package.dart';

class ReloadBloc extends Cubit<ReloadState> {
  ReloadBloc() : super(ReloadState());

  void reload({Type type, Bundle bundle}) {
    emit(ReloadState(
      screen: type,
      bundle: bundle,
    ));
  }
}

class ReloadState {
  final Type screen;
  final Bundle bundle;

  ReloadState({this.screen, this.bundle});
}
