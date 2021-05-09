import 'dart:io';

import 'package:app_settings/app_settings.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:kaylee/res/res.dart';
import 'package:kaylee/widgets/widgets.dart';
import 'package:permission_handler/permission_handler.dart';

abstract class SystemSettingModule {
  factory SystemSettingModule.init() = _SystemSettingModuleImpl._;

  Future<void> showKayleeGo2SettingDialog({
    required BuildContext context,
    bool barrierDismissible = true,
  });

  Future<void> showKayleeBluetoothSettingDialog({
    required BuildContext context,
    bool barrierDismissible = true,
  });

  SystemSettingModule._();
}

class _SystemSettingModuleImpl extends SystemSettingModule {
  _SystemSettingModuleImpl._() : super._();

  @override
  Future<void> showKayleeGo2SettingDialog(
      {required BuildContext context, bool barrierDismissible = true}) {
    return showKayleeRequestSettingDialog(
      context: context,
      barrierDismissible: barrierDismissible,
      title: Strings.quyenTruyCapHinhAnh,
      message: Strings.quyenTruyCapHinhAnhContent,
      guides: Platform.isAndroid
          ? Strings.androidStoragePermissionGuide
          : Strings.iOsStoragePermissionGuide,
      onGoToSetting: openAppSettings,
    );
  }

  Future<void> showKayleeRequestSettingDialog({
    required BuildContext context,
    bool barrierDismissible = true,
    String? title,
    String? message,
    String? guides,
    VoidCallback? onGoToSetting,
  }) {
    return showKayleeDialog(
        context: context,
        barrierDismissible: barrierDismissible,
        child: RequestSettingDialog(
          title: title,
          message: message,
          guides: guides,
          onGoToSetting: onGoToSetting,
        ));
  }

  @override
  Future<void> showKayleeBluetoothSettingDialog(
      {required BuildContext context, bool barrierDismissible = true}) {
    return showKayleeRequestSettingDialog(
      context: context,
      barrierDismissible: barrierDismissible,
      title: Strings.thietBiChuaBatBluetooth,
      message: Strings.quyenTruyBluetoothContent,
      guides: Platform.isAndroid
          ? Strings.androidBluetoothSettingGuide
          : Strings.iOsBluetoothSettingGuide,
      onGoToSetting: AppSettings.openBluetoothSettings,
    );
  }
}
