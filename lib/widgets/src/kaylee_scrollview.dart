import 'package:flutter/material.dart';

import '../widgets.dart';

class KayleeScrollview extends StatefulWidget {
  final KayleeAppBar appBar;
  final Widget child;
  final EdgeInsets padding;

  KayleeScrollview({this.appBar, this.child, this.padding});

  @override
  _KayleeScrollviewState createState() => _KayleeScrollviewState();
}

class _KayleeScrollviewState extends State<KayleeScrollview> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: widget.appBar,
      body: SingleChildScrollView(
        padding: widget.padding ?? EdgeInsets.zero,
        child: widget.child,
      ),
    );
  }
}
