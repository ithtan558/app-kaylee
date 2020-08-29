import 'package:flutter/cupertino.dart';
import 'package:kaylee/res/res.dart';

class KayleeLoadingIndicator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoActivityIndicator(
      radius: Dimens.px16,
    );
  }
}
