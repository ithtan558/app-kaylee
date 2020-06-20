import 'package:anth_package/anth_package.dart';
import 'package:kaylee/models/models.dart';

class SuccessResetPassScrState {
  final VerifyPhoneResult result;

  SuccessResetPassScrState(this.result);
}

class PhoneErrorResetPassScrState extends MessageErrorState {
  PhoneErrorResetPassScrState(String message) : super(message);
}

class SuccessLoadContactResetPassScrState {
  Content content;

  SuccessLoadContactResetPassScrState(this.content);
}
