import 'package:flutter/material.dart';

class ActionButton extends StatelessWidget {
  final Widget child;

  ActionButton({@required this.child});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: kToolbarHeight,
      width: kToolbarHeight,
      child: InkWell(
        onTap: () {},
        customBorder: CircleBorder(),
        child: Center(
          child: child,
        ),
      ),
    );
  }
}
