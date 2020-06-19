import 'package:anth_package/anth_package.dart';
import 'package:kaylee/models/models.dart';

class DoSignUpRegisterScrEvent {
  RegisterBody body;

  DoSignUpRegisterScrEvent(this.body);
}

class SuccessRegisterScrEvent {
  Message message;

  SuccessRegisterScrEvent(this.message);
}

class NameRegisterScrErrorEvent extends MessageErrorEvent {
  NameRegisterScrErrorEvent(String message) : super(message);
}

class LastNameRegisterScrErrorEvent extends MessageErrorEvent {
  LastNameRegisterScrErrorEvent(String message) : super(message);
}

class EmailRegisterScrErrorEvent extends MessageErrorEvent {
  EmailRegisterScrErrorEvent(String message) : super(message);
}

class PhoneRegisterScrErrorEvent extends MessageErrorEvent {
  PhoneRegisterScrErrorEvent(String message) : super(message);
}

class PassRegisterScrErrorEvent extends MessageErrorEvent {
  PassRegisterScrErrorEvent(String message) : super(message);
}
