import 'package:core_plugin/core_plugin.dart';

///nên provide trước ở main
class RefreshBloc extends Cubit<ReloadState> {
  RefreshBloc() : super(ReloadState());

  void reload({required Type widget, Bundle? bundle}) {
    emit(ReloadState(
      widget: widget,
      bundle: bundle,
    ));
  }
}

class ReloadState {
  final Type? widget;
  final Bundle? bundle;

  ReloadState({this.widget, this.bundle});
}
