import 'package:anth_package/anth_package.dart';

class ErrorEvent {
  ErrorType code;
  Error? error;

  ErrorEvent(this.code, {this.error});
}

class MessageErrorEvent {
  String message;

  MessageErrorEvent(this.message);
}
