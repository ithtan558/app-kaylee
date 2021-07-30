import 'package:flutter/cupertino.dart';
import 'package:kaylee/res/res.dart';

class KayleeLoadingIndicator extends StatelessWidget {
  const KayleeLoadingIndicator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const CupertinoActivityIndicator(
      radius: Dimens.px16,
    );
  }
}
