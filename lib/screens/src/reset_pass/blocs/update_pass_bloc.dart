import 'package:anth_package/anth_package.dart';
import 'package:kaylee/apis/apis.dart';
import 'package:kaylee/models/src/request/update_pass/update_pass_body.dart';

class UpdatePassBloc extends Cubit<SingleModel> {
  UserService userService;
  final String? resetPassToken;
  final int? userId;

  UpdatePassBloc({
    required this.userService,
    this.resetPassToken,
    this.userId,
  }) : super(SingleModel());

  void updatePass({required String newPass}) {
    emit(SingleModel.copy(state..loading = true));

    RequestHandler(
      request: userService.updatePass(
          body: UpdatePassBody(
        userId: userId,
        password: newPass,
        tokenResetPassword: resetPassToken,
      )),
      onSuccess: ({message, result}) {
        emit(SingleModel.copy(state
          ..loading = false
          ..message = message
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
