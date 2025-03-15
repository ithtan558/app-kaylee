import 'package:anth_package/anth_package.dart';
import 'package:flutter/foundation.dart';

class RadioInactiveIcon extends BaseIcon {
  const RadioInactiveIcon({Key? key, double? size})
      : super(
          icon: IconAssets.icRadioInactive,
          package: anthPackage,
          size: size,
          color: ColorsRes.radioInActive,
          key: key,
        );
}
