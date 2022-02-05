import 'dart:io';

import 'package:flutter/material.dart';
import 'package:kaylee/utils/utils.dart';
import 'package:permission_handler/permission_handler.dart';

mixin BluetoothHelper<T extends StatefulWidget> on State<T> {
  void checkBluetoothPermission() async {
    const permission = Permission.locationWhenInUse;
    //handle cho android trc, ios đợi lên flutter sẽ handle sau
    if (Platform.isAndroid) {
      PermissionStatus status = await permission.request();
      if (status.isGranted) {
        //có thể dùng scan hoặc connect bluetooth
        return onGranted();
      } else if (status.isDenied) {
        //gọi request lại 1 lần nữa khi user chỉ chọn `Deny`
        return checkBluetoothPermission();
      } else if (status.isRestricted || status.isPermanentlyDenied) {
        //để user vào app infor tự bật lến
        context.systemSetting
            .showKayleeBluetoothPermissionSettingDialog(context: context);
      }
    } else if (Platform.isIOS) {
      onGranted();
    }
  }

  void onGranted();
}
