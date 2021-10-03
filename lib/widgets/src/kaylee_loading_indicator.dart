import 'package:anth_package/anth_package.dart';
import 'package:flutter/cupertino.dart';

class KayleeLoadingIndicator extends StatelessWidget {
  const KayleeLoadingIndicator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const CupertinoActivityIndicator(
      radius: Dimens.px16,
    );
  }
}
