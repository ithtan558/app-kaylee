import 'package:anth_package/anth_package.dart';
import 'package:flutter/foundation.dart';
import 'package:kaylee/res/res.dart';

class RadioInactiveIcon extends BaseIcon {
  const RadioInactiveIcon({Key? key, double? size})
      : super(
    icon: Images.icRadioInactive,
    size: size,
    color: ColorsRes.radioInActive,
    key: key,
  );
}
