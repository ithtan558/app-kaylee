import 'package:core_plugin/core_plugin.dart';

class Screen1Bloc extends Cubit {
  final String? message;

  Screen1Bloc({this.message}) : super(InitState());
}

class InitState {}
