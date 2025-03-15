import 'package:core_plugin/src/base_state.dart';
import 'package:flutter/material.dart';

import 'constants.dart';

class ResponsiveLayout extends StatefulWidget {
  final Widget? mobile;
  final Widget? tablet;
  final Widget? desktop;

  const ResponsiveLayout({Key? key, this.desktop, this.tablet, this.mobile})
      : super(key: key);

  @override
  _ResponsiveLayoutState createState() => _ResponsiveLayoutState();
}

class _ResponsiveLayoutState extends BaseState<ResponsiveLayout> {
  @override
  Widget build(BuildContext context) {
    return buildContent(Scaffold(
      body: LayoutBuilder(builder: (context, constraint) {
        if (constraint.maxWidth < tabletWidthMin) {
          return widget.mobile ??
              Center(
                child: Text('no mobile screen'.toUpperCase()),
              );
        } else if (constraint.maxWidth >= tabletWidthMin &&
            constraint.maxWidth < desktopWidthMin) {
          return widget.tablet ??
              Center(
                child: Text('no tablet screen'.toUpperCase()),
              );
        } else {
          return widget.desktop ??
              Center(
                child: Text('no desktop screen'.toUpperCase()),
              );
        }
      }),
    ));
  }
}
