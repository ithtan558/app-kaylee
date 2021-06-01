import 'package:anth_package/anth_package.dart';
import 'package:kaylee/models/models.dart';
import 'package:kaylee/services/services.dart';

class ExpirationScreenBloc extends Cubit<SingleModel<Content>> {
  final CommonService commonService;
  final UserService userService;

  ExpirationScreenBloc({
    this.commonService,
    this.userService,
  }) : super(SingleModel());

  void loadContent() {
    emit(SingleModel.copy(state..loading = true));
    RequestHandler(
      request: commonService.getContent(Content.EXPIRATION_HASHTAG),
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

  void checkExpirationAgain() {
    emit(SingleModel.copy(state..loading = true));
    RequestHandler(
      request: userService.checkExpire(),
      onSuccess: ({message, result}) {
        emit(CheckExpirationSuccessModel.copy(state
          ..loading = false
          ..error = null
          ..code = null));
      },
      onFailed: (code, {error}) {
        emit(SingleModel.copy(state
          ..loading = false
          ..error = error
          ..code = ErrorType.FAILED));
      },
    );
  }
}

class CheckExpirationSuccessModel extends SingleModel<Content> {
  CheckExpirationSuccessModel.copy(SingleModel old) {
    this
      ..loading = old?.loading
      ..item = old?.item
      ..message = old?.message;
  }
}
