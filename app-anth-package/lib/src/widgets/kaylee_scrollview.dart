import 'package:anth_package/anth_package.dart';
import 'package:flutter/material.dart';

class KayleeScrollview extends StatefulWidget {
  final KayleeAppBar? appBar;
  final Widget? child;
  final EdgeInsets? padding;
  final Widget? bottom;

  const KayleeScrollview(
      {Key? key, this.appBar, this.child, this.padding, this.bottom})
      : super(key: key);

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
              physics: const BouncingScrollPhysics(),
              child: widget.child,
            ),
          ),
          if (widget.bottom != null) widget.bottom!,
        ],
      ),
    );
  }
}
