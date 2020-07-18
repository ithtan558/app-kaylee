import 'package:anth_package/anth_package.dart';
import 'package:flutter/material.dart';
import 'package:kaylee/components/components.dart';

extension KayleeBuildContextExtension on BuildContext {
  NetworkModule get network => this.repository<NetworkModule>();

  UserModule get user => this.repository<UserModule>();

  CartModule get cart => this.repository<CartModule>();
}
