import 'package:anth_package/anth_package.dart';

class ReloadBloc extends Cubit<ReloadState> {
  ReloadBloc() : super(ReloadState());

  void reload({Type widget, Bundle bundle}) {
    emit(ReloadState(
      widget: widget,
      bundle: bundle,
    ));
  }
}

class ReloadState {
  final Type widget;
  final Bundle bundle;

  ReloadState({this.widget, this.bundle});
}
