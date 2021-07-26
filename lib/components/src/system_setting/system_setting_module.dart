import 'dart:io';

import 'package:anth_package/anth_package.dart';
import 'package:app_settings/app_settings.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:kaylee/res/res.dart';
import 'package:kaylee/utils/utils.dart';
import 'package:kaylee/widgets/widgets.dart';
import 'package:permission_handler/permission_handler.dart';

abstract class SystemSettingModule {
  factory SystemSettingModule.init() = _SystemSettingModuleImpl._;

  Future<void> showKayleeGo2SettingDialog({
    @required BuildContext context,
    bool barrierDismissible = true,
  });

  Future<void> showKayleeBluetoothSettingDialog({
    @required BuildContext context,
    bool barrierDismissible = true,
  });

  ///android sẽ gọi location permission
  ///ios sẽ gọi bluetooth permission
  Future<void> showKayleeBluetoothPermissionSettingDialog({
    @required BuildContext context,
    bool barrierDismissible = true,
  });

  Future<void> showKayleeLocationPermissionExplainsDialog({
    @required BuildContext context,
    bool barrierDismissible = true,
    VoidCallback allowCallback,
  });

  SystemSettingModule._();
}

class _SystemSettingModuleImpl extends SystemSettingModule {
  _SystemSettingModuleImpl._() : super._();

  @override
  Future<void> showKayleeGo2SettingDialog(
      {BuildContext context, bool barrierDismissible = true}) {
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
    @required BuildContext context,
    bool barrierDismissible = true,
    String title,
    String message,
    String guides,
    VoidCallback onGoToSetting,
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
      {BuildContext context, bool barrierDismissible = true}) {
    return showKayleeRequestSettingDialog(
      context: context,
      barrierDismissible: barrierDismissible,
      title: Strings.thietBiChuaBatBluetooth,
      message: Strings.vuiLongBatBluetoothContent,
      guides: Platform.isAndroid
          ? Strings.androidBluetoothSettingGuide
          : Strings.iOsBluetoothSettingGuide,
      onGoToSetting: AppSettings.openBluetoothSettings,
    );
  }

  @override
  Future<void> showKayleeBluetoothPermissionSettingDialog(
      {BuildContext context, bool barrierDismissible = true}) {
    return showKayleeRequestSettingDialog(
      context: context,
      barrierDismissible: barrierDismissible,
      title: Platform.isAndroid
          ? Strings.quyenTruyCapViTri
          : Strings.quyenTruyCapBluetooth,
      message: Platform.isAndroid
          ? Strings.quyenTruyCapViTriContent
          : Strings.quyenTruyCapBluetoothContent,
      guides: Platform.isAndroid
          ? Strings.androidLocationPermissionGuide
          : Strings.iOsBluetoothPermissionGuide,
      onGoToSetting: openAppSettings,
    );
  }

  @override
  Future<void> showKayleeLocationPermissionExplainsDialog({
    BuildContext context,
    bool barrierDismissible = true,
    VoidCallback allowCallback,
  }) {
    return showKayleeDialog(
        context: context,
        child: Column(
          children: [
            SizedBox(height: Dimens.px24),
            Padding(
              padding: const EdgeInsets.only(
                  right: Dimens.px16, left: Dimens.px16, bottom: Dimens.px8),
              child: Text.rich(
                TextSpan(text: 'Kaylee sử dụng ', children: [
                  TextSpan(
                      text: Strings.quyenTruyCapViTri + ' ở chế độ chạy nền',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  TextSpan(
                      text:
                          ' cho việc tìm kiếm các thiết bị máy in bluetooth.'),
                ]),
                style: TextStyles.normal16W400,
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  right: Dimens.px16, left: Dimens.px16, bottom: Dimens.px8),
              child: Text.rich(
                TextSpan(
                    text: 'Kaylee sử dụng quyền này cho chức năng: ',
                    children: [
                      TextSpan(
                          text: Strings.caiDatMayIn,
                          style: TextStyle(fontWeight: FontWeight.bold)),
                    ]),
                style: TextStyles.normal16W400,
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
                padding: const EdgeInsets.only(
                    right: Dimens.px16, left: Dimens.px16, bottom: Dimens.px16),
                child: Text.rich(
                  TextSpan(text: 'Kaylee sẽ sử dụng ', children: [
                    TextSpan(
                        text: Strings.quyenTruyCapViTri,
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    TextSpan(
                        text: ' này kể cả khi app đã đóng hoặc không sử dụng'),
                  ]),
                  style: TextStyles.normal16W400,
                  textAlign: TextAlign.center,
                )),
            GestureDetector(
              onTap: () {
                mobileLaunchUrl(context.appConfig.policyUrl);
              },
              child: Container(
                padding: const EdgeInsets.only(
                    right: Dimens.px16, left: Dimens.px16, bottom: Dimens.px16),
                child: KayleeText.hyper16W400(
                  Strings.dieuKhoanCuaKaylee,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            Container(
              width: double.infinity,
              height: Dimens.px1,
              color: ColorsRes.divider,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: Dimens.px16),
              child: Row(
                children: [
                  Expanded(
                    child: KayLeeRoundedButton.button2(
                      text: Strings.boQua,
                      onPressed: () {
                        context.pop();
                        allowCallback.call();
                      },
                      margin: const EdgeInsets.only(
                          right: Dimens.px8, left: Dimens.px16),
                    ),
                  ),
                  Expanded(
                    child: KayLeeRoundedButton.normal(
                      text: Strings.choPhep,
                      onPressed: () {
                        context.pop();
                        allowCallback.call();
                      },
                      margin: const EdgeInsets.only(
                          left: Dimens.px8, right: Dimens.px16),
                    ),
                  ),
                ],
              ),
            )
          ],
        ));
  }
}
