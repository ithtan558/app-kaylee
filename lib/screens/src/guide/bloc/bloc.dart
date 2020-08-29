import 'package:anth_package/anth_package.dart';
import 'package:kaylee/models/models.dart';
import 'package:kaylee/services/services.dart';

class GuideScreenBloc extends Cubit<SingleModel<Content>> {
  final CommonService commonService;

  GuideScreenBloc({this.commonService}) : super(SingleModel());

  void loadContent() {
    emit(SingleModel.copy(state..loading = true));
    RequestHandler(
      request: commonService.getContent(Content.USER_GUIDE_HASHTAG),
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
