import 'package:anth_package/anth_package.dart';

class NameRegisterScrErrorState extends MessageErrorState {
  NameRegisterScrErrorState(String message) : super(message);
}

class LastNameRegisterScrErrorState extends MessageErrorState {
  LastNameRegisterScrErrorState(String message) : super(message);
}

class EmailRegisterScrErrorState extends MessageErrorState {
  EmailRegisterScrErrorState(String message) : super(message);
}

class PhoneRegisterScrErrorState extends MessageErrorState {
  PhoneRegisterScrErrorState(String message) : super(message);
}

class PassRegisterScrErrorState extends MessageErrorState {
  PassRegisterScrErrorState(String message) : super(message);
}

class SuccessRegisterScrState {
  Message message;

  SuccessRegisterScrState(this.message);
}
