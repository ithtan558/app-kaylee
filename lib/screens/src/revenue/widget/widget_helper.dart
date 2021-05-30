import 'package:anth_package/anth_package.dart';
import 'package:flutter/material.dart';
import 'package:kaylee/base/kaylee_state.dart';
import 'package:kaylee/res/res.dart';
import 'package:kaylee/widgets/widgets.dart';

mixin WidgetHelper<T extends StatefulWidget> on KayleeState<T> {
  KayleeDatePickerTextController datePickerController =
      KayleeDatePickerTextController(
    value: DateTimeRange(start: DateTime.now(), end: DateTime.now()),
  );

  Widget buildLoading() {
    return Container(
        padding: const EdgeInsets.symmetric(vertical: Dimens.px16),
        child: KayleeLoadingIndicator());
  }

  void showErrorDialog({ErrorType code, Error error}) {
    if (error != null) {
      showKayleeAlertErrorYesDialog(
          context: context, error: error, onPressed: popScreen);
    }
  }
}
