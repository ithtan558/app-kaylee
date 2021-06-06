import 'package:anth_package/anth_package.dart';
import 'package:kaylee/models/models.dart';

class PhoneLoginScrErrorEvent {
  final String? message;

  PhoneLoginScrErrorEvent(this.message);
}

class PassLoginScrErrorEvent {
  final String? message;

  PassLoginScrErrorEvent(this.message);
}

class DoSignInLoginScrEvent {
  final LoginBody body;

  DoSignInLoginScrEvent({required this.body});
}

class SuccessLoginScrEvent {
  Message? message;
  LoginResult result;

  SuccessLoginScrEvent(this.message, this.result);
}
