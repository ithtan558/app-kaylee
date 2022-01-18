import 'package:anth_package/anth_package.dart';
import 'package:kaylee/apis/apis.dart';
import 'package:kaylee/models/models.dart';

class ExpirationScreenBloc extends Cubit<SingleModel<Content>> {
  final CommonApi commonService;
  final UserApi userService;

  ExpirationScreenBloc({
    required this.commonService,
    required this.userService,
  }) : super(SingleModel());

  void loadContent() {
    emit(SingleModel.copy(state..loading = true));
    RequestHandler(
      request: commonService.getContent(Content.expirationHashtag),
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
          ..code = ErrorType.failed));
      },
    );
  }
}

class CheckExpirationSuccessModel extends SingleModel<Content> {
  CheckExpirationSuccessModel.copy(SingleModel old) {
    this
      ..loading = old.loading
      ..item = old.item
      ..message = old.message;
  }
}
