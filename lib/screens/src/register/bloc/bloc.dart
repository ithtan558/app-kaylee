import 'package:anth_package/anth_package.dart';
import 'package:kaylee/models/models.dart';
import 'package:kaylee/screens/src/register/bloc/event.dart';
import 'package:kaylee/services/services.dart';

class RegisterScreenBloc extends BaseBloc {
  UserService userService;

  RegisterScreenBloc({this.userService});

  @override
  Stream mapEventToState(e) async* {
    if (e is DoSignUpRegisterScrEvent) {
      yield LoadingState();
      RequestHandler(
        request: userService.register(e.body),
        onSuccess: ({result}) {},
        onFailed: (code, {error}) {},
      );
    } else if (e is ErrorEvent) {
      yield* errorState(e);
    }
  }

  void register(RegisterBody body) {
    add(DoSignUpRegisterScrEvent(body));
  }
}
