import 'package:anth_package/anth_package.dart';
import 'package:kaylee/apis/apis.dart';
import 'package:kaylee/models/models.dart';

class GuideScreenBloc extends Cubit<SingleModel<Content>> {
  final CommonApi commonService;

  GuideScreenBloc({required this.commonService}) : super(SingleModel());

  void loadContent() {
    emit(SingleModel.copy(state..loading = true));
    RequestHandler(
      request: commonService.getContent(Content.userGuideHashtag),
      onSuccess: ({message, result}) {
        emit(SingleModel.copy(state
          ..loading = false
          ..item = result
          ..error = null
          ..code = null));
      },
      onFailed: (code, {error}) {
        emit(SingleModel.copy(state
          ..loading = false
          ..error = error
          ..code = code));
      },
    );
  }
}
