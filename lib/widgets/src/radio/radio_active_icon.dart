import 'package:flutter/foundation.dart';
import 'package:kaylee/res/res.dart';
import 'package:kaylee/widgets/src/base/base_icon.dart';

class RadioActiveIcon extends BaseIcon {
  const RadioActiveIcon({Key? key, double? size})
      : super(
          icon: Images.icRadioActive,
          size: size,
          color: ColorsRes.hyper,
          key: key,
        );
}
