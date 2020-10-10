import 'package:anth_package/anth_package.dart';
import 'package:flutter/material.dart';
import 'package:kaylee/components/components.dart';

extension KayleeBuildContextExtension on BuildContext {
  NetworkModule get network => this.repository<NetworkModule>();

  UserModule get user => this.repository<UserModule>();

  CartModule get cart => this.repository<CartModule>();
}

extension DateTimeExtension on DateTime {
  DateTime combineWithTime({DateTime time}) {
    return DateTime(year, month, day, time.hour, time.minute);
  }

  DateTime toDate12AM() => DateTime(year, month, day);

  DateTime toDate12PM() => DateTime(year, month, day, 23, 59, 59);
}
