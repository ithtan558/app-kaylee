import 'package:anth_package/anth_package.dart';

class ReloadBloc extends Cubit {
  ReloadBloc() : super(InitState());

  void reload({Type type, Bundle bundle}) {
    emit(ReloadState(
      type: type,
      bundle: bundle,
    ));
  }
}

class ReloadState {
  final Type type;
  final Bundle bundle;

  ReloadState({this.type, this.bundle});
}
