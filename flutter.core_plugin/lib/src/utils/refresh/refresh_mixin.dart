import 'dart:async';

import 'package:core_plugin/core_plugin.dart';
import 'package:flutter/material.dart';

mixin RefreshMixin<T extends StatefulWidget> on State<T> {
  StreamSubscription? _reloadBlocSub;

  ///ko cần thiết phải gọi super khi override lại ở sub-class
  void onRefreshWidget(Type widget, Bundle? bundle);

  @override
  void initState() {
    super.initState();
    _reloadBlocSub = context.read<RefreshBloc>().stream.listen((state) {
      onRefreshWidget(state.widget!, state.bundle);
    });
  }

  @override
  void dispose() {
    _reloadBlocSub?.cancel();
    super.dispose();
  }
}
