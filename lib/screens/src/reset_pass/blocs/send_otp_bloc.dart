import 'package:anth_package/anth_package.dart';
import 'package:kaylee/models/models.dart';
import 'package:kaylee/services/services.dart';

class SendOtpBloc extends Cubit<SingleModel<VerifyPhoneResult>> {
  UserService userService;

  SendOtpBloc({required this.userService}) : super(SingleModel());

  void verifyPhone({required String phone}) {
    emit(SingleModel.copy(state..loading = true));
    RequestHandler(
      request: userService.verifyPhone(VerifyPhoneBody(phone: phone)),
      onSuccess: ({message, result}) {
        emit(SingleModel.copy(state
          ..loading = false
          ..item = result
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
