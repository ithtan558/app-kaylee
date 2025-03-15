import 'package:core_plugin/core_plugin.dart';
import 'package:examples/navigator/screen1_bloc.dart';
import 'package:flutter/material.dart';

class Screen1Argument {
  final String message;

  Screen1Argument(this.message);
}

class Screen1 extends StatefulWidget {
  static Widget newInstance() => BlocProvider(
      create: (context) => Screen1Bloc(
          message: context.getArguments<Screen1Argument>()?.message),
      child: Screen1._());

  Screen1._();

  @override
  _Screen1State createState() => _Screen1State();
}

class _Screen1State extends State<Screen1> {
  Screen1Bloc get bloc => context.read<Screen1Bloc>();

  @override
  void initState() {
    super.initState();
    print('[TUNG] ===> initState ${bloc.message}');
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    print('[TUNG] ===> ${context.getArguments<Screen1Argument>()?.message}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
