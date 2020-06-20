import 'package:anth_package/anth_package.dart';
import 'package:kaylee/models/models.dart';

class VerifyPhoneResetPassScrEvent {
  final String phone;

  VerifyPhoneResetPassScrEvent(this.phone);
}

class SuccessResetPassScrEvent {
  final VerifyPhoneResult result;

  SuccessResetPassScrEvent(this.result);
}

class PhoneErrorResetPassScrEvent extends MessageErrorEvent {
  PhoneErrorResetPassScrEvent(String message) : super(message);
}

class LoadContactResetPassScrEvent {}

class SuccessLoadContactResetPassScrEvent {
  Content content;

  SuccessLoadContactResetPassScrEvent(this.content);
}
