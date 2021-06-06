import 'package:anth_package/anth_package.dart';
import 'package:kaylee/models/models.dart';

class PhoneLoginScrErrorState {
  final String? message;

  PhoneLoginScrErrorState(this.message);
}

class PassLoginScrErrorState {
  final String? message;

  PassLoginScrErrorState(this.message);
}

class SuccessLoginScrState {
  Message? message;
  LoginResult result;

  SuccessLoginScrState(this.message, this.result);
}
