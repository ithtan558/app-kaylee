import 'package:kaylee/models/models.dart';

class PhoneLoginScrErrorEvent {
  final String message;

  PhoneLoginScrErrorEvent(this.message);
}

class PassLoginScrErrorEvent {
  final String message;

  PassLoginScrErrorEvent(this.message);
}

class DoSignInLoginScrEvent {
  final LoginBody body;

  DoSignInLoginScrEvent({this.body});
}
