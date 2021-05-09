import 'package:anth_package/anth_package.dart';

class ReloadBloc extends Cubit<ReloadState?> {
  ReloadBloc() : super(null);

  void reload({required Type widget, Bundle? bundle}) {
    emit(ReloadOneState(
      widget: widget,
      bundle: bundle,
    ));
  }

  void forceReloadAllState() {
    emit(ReloadAllState());
  }
}

abstract class ReloadState {}

class ReloadOneState extends ReloadState {
  final Type widget;
  final Bundle? bundle;

  ReloadOneState({required this.widget, this.bundle});
}

class ReloadAllState extends ReloadState {}
