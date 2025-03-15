import 'package:anth_package/anth_package.dart';
import 'package:flutter/foundation.dart';

class RadioActiveIcon extends BaseIcon {
  const RadioActiveIcon({Key? key, double? size})
      : super(
          icon: IconAssets.icRadioActive,
          package: anthPackage,
          size: size,
          color: ColorsRes.hyper,
          key: key,
        );
}
