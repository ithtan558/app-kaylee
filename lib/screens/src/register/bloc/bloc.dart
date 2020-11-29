import 'package:anth_package/anth_package.dart';
import 'package:kaylee/models/models.dart';
import 'package:kaylee/res/res.dart';
import 'package:kaylee/services/services.dart';

class RegisterScreenBloc extends Cubit<SingleModel<RegisterBody>> {
  UserService userService;

  RegisterScreenBloc({this.userService})
      : super(SingleModel(item: RegisterBody()));

  void register(
      {String firstName,
      String lastName,
      String phone,
      String email,
      String password,
      bool isAcceptPolicy = false}) {
    if (isAcceptPolicy) {
      emit(SingleModel.copy(state..loading = true));
      RequestHandler(
        request: userService.register(RegisterBody(
          firstName: firstName,
          lastName: lastName,
          phone: phone,
          email: email,
          password: password,
        )),
        onSuccess: ({message, result}) {
          emit(RegisterSuccessModel.copy(
              state
                ..loading = false
                ..message = message,
              result: result));
        },
        onFailed: (code, {error}) {
          switch (error.code) {
            case ErrorCode.FIRST_NAME_CODE:
              return emit(NameErrorModel.copy(state
                ..loading = false
                ..error = error
                ..code = code));
            case ErrorCode.LAST_NAME_CODE:
              return emit(LastNameErrorModel.copy(state
                ..loading = false
                ..error = error
                ..code = code));
            case ErrorCode.PHONE_CODE:
              return emit(PhoneErrorModel.copy(state
                ..loading = false
                ..error = error
                ..code = code));
            case ErrorCode.EMAIL_CODE:
              return emit(EmailErrorModel.copy(state
                ..loading = false
                ..error = error
                ..code = code));
            case ErrorCode.PASSWORD_CODE:
              return emit(PasswordErrorModel.copy(state
                ..loading = false
                ..error = error
                ..code = code));
            default:
              return emit(SingleModel.copy(state
                ..loading = false
                ..error = error
                ..code = code));
          }
        },
      );
    } else {
      emit(SingleModel.copy(state
        ..code = ErrorType.FAILED
        ..error = Error(message: Strings.vuiLongChapNhanDieuKhoan)));
    }
  }
}

class RegisterSuccessModel extends SingleModel<RegisterBody> {
  final RegisterResult result;

  RegisterSuccessModel.copy(SingleModel old, {this.result}) {
    this
      ..loading = old?.loading
      ..item = old?.item
      ..message = old?.message;
  }
}

class NameErrorModel extends SingleModel<RegisterBody> {
  NameErrorModel.copy(SingleModel old) {
    this
      ..loading = old?.loading
      ..item = old?.item
      ..error = old?.error
      ..code = old?.code;
  }
}

class LastNameErrorModel extends SingleModel<RegisterBody> {
  LastNameErrorModel.copy(SingleModel old) {
    this
      ..loading = old?.loading
      ..item = old?.item
      ..error = old?.error
      ..code = old?.code;
  }
}

class PhoneErrorModel extends SingleModel<RegisterBody> {
  PhoneErrorModel.copy(SingleModel old) {
    this
      ..loading = old?.loading
      ..item = old?.item
      ..error = old?.error
      ..code = old?.code;
  }
}

class EmailErrorModel extends SingleModel<RegisterBody> {
  EmailErrorModel.copy(SingleModel old) {
    this
      ..loading = old?.loading
      ..item = old?.item
      ..error = old?.error
      ..code = old?.code;
  }
}

class PasswordErrorModel extends SingleModel<RegisterBody> {
  PasswordErrorModel.copy(SingleModel old) {
    this
      ..loading = old?.loading
      ..item = old?.item
      ..error = old?.error
      ..code = old?.code;
  }
}
