import 'package:flutter/foundation.dart';
import 'package:kaylee/res/res.dart';
import 'package:kaylee/widgets/src/base/base_icon.dart';

class RadioInactiveIcon extends BaseIcon {
  const RadioInactiveIcon({Key? key, double? size})
      : super(
          icon: Images.icRadioInactive,
          size: size,
          color: ColorsRes.radioInActive,
          key: key,
        );
}
