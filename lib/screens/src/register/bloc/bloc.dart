import 'package:anth_package/anth_package.dart';
import 'package:kaylee/services/services.dart';

class RegisterScreenBloc extends BaseBloc {
  UserService userService;

  RegisterScreenBloc({this.userService});

  @override
  Stream mapEventToState(e) async* {}
}
