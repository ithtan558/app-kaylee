import 'package:flutter/material.dart';

import '../widgets.dart';

class KayleeScrollview extends StatefulWidget {
  final KayleeAppBar appBar;
  final Widget child;
  final EdgeInsets padding;
  final Widget bottom;

  KayleeScrollview({this.appBar, this.child, this.padding, this.bottom});

  @override
  _KayleeScrollviewState createState() => _KayleeScrollviewState();
}

class _KayleeScrollviewState extends State<KayleeScrollview> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: widget.appBar,
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: widget.padding ?? EdgeInsets.zero,
              physics: BouncingScrollPhysics(),
              child: widget.child,
            ),
          ),
          widget.bottom ?? Container(),
        ],
      ),
    );
  }
}
