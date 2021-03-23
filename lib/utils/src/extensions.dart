import 'package:anth_package/anth_package.dart';
import 'package:flutter/material.dart';
import 'package:kaylee/application_config.dart';
import 'package:kaylee/components/components.dart';

extension KayleeBuildContextExtension on BuildContext {
  NetworkModule get network => this.repository<NetworkModule>();

  UserModule get user => this.repository<UserModule>();

  CartModule get cart => this.repository<CartModule>();

  FcmModule get fcm => this.repository<FcmModule>();

  RepositoriesModule get repos => this.repository<RepositoriesModule>();

  ApplicationConfig get appConfig => this.repository<ApplicationConfig>();

  SystemSettingModule get systemSetting =>
      this.repository<SystemSettingModule>();
}

extension DateTimeExtension on DateTime {
  DateTime combineWithTime({DateTime time}) {
    return DateTime(year, month, day, time.hour, time.minute);
  }

  DateTime toDate12AM() => DateTime(year, month, day);

  DateTime toDate12PM() => DateTime(year, month, day, 23, 59, 59);

  DateTime findLastDateOfMonthOfCurrent({int max = 31}) {
    final currentDate = this;
    final maxDate = DateTime(currentDate.year, currentDate.month, max);
    if (maxDate.month > currentDate.month) {
      return findLastDateOfMonthOfCurrent(max: max - 1);
    }
    return maxDate;
  }

  DateTime findFirstDayOfMonthOfCurrent() {
    return subtract(Duration(days: day - 1));
  }

  DateTime findLastDateOfLastMonthFromCurrent() {
    return subtract(Duration(days: day));
  }

  DateTime findFirstDayOfLastMonthFromCurrent({max}) {
    final lastDate = findLastDateOfLastMonthFromCurrent();
    return lastDate.subtract(Duration(days: lastDate.day - 1));
  }
}
