import 'package:anth_package/anth_package.dart';
import 'package:kaylee/apis/apis.dart';
import 'package:kaylee/models/models.dart';
import 'package:kaylee/res/res.dart';

class RegisterScreenBloc extends Cubit<SingleModel<RegisterBody>> {
  UserService userService;

  RegisterScreenBloc({required this.userService})
      : super(SingleModel(item: RegisterBody()));

  void register(
      {String? name,
      String? phone,
      String? email,
      String? password,
      String? code,
      bool isAcceptPolicy = false}) {
    if (isAcceptPolicy) {
      emit(SingleModel.copy(state..loading = true));
      RequestHandler(
        request: userService.register(RegisterBody(
          name: name,
          phone: phone,
          email: email,
          password: password,
          code: code,
        )),
        onSuccess: ({message, result}) {
          emit(RegisterSuccessModel.copy(
              state
                ..loading = false
                ..message = message,
              result: result));
        },
        onFailed: (code, {error}) {
          if (error != null) {
            switch (error.code) {
              case ErrorCode.nameCode:
                return emit(NameErrorModel.copy(state
                  ..loading = false
                  ..error = error
                  ..code = code));
              case ErrorCode.phoneCode:
                return emit(PhoneErrorModel.copy(state
                  ..loading = false
                  ..error = error
                  ..code = code));
              case ErrorCode.emailCode:
                return emit(EmailErrorModel.copy(state
                  ..loading = false
                  ..error = error
                  ..code = code));
              case ErrorCode.passwordCode:
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

  RegisterSuccessModel.copy(SingleModel old, {required this.result}) {
    this
      ..loading = old.loading
      ..item = old.item
      ..message = old.message;
  }
}

class NameErrorModel extends SingleModel<RegisterBody> {
  NameErrorModel.copy(SingleModel old) {
    this
      ..loading = old.loading
      ..item = old.item
      ..error = old.error
      ..code = old.code;
  }
}

class PhoneErrorModel extends SingleModel<RegisterBody> {
  PhoneErrorModel.copy(SingleModel old) {
    this
      ..loading = old.loading
      ..item = old.item
      ..error = old.error
      ..code = old.code;
  }
}

class EmailErrorModel extends SingleModel<RegisterBody> {
  EmailErrorModel.copy(SingleModel old) {
    this
      ..loading = old.loading
      ..item = old.item
      ..error = old.error
      ..code = old.code;
  }
}

class PasswordErrorModel extends SingleModel<RegisterBody> {
  PasswordErrorModel.copy(SingleModel old) {
    this
      ..loading = old.loading
      ..item = old.item
      ..error = old.error
      ..code = old.code;
  }
}
