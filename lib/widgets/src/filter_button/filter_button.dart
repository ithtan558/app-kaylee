import 'package:core_plugin/core_plugin.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kaylee/base/kaylee_filter_interface.dart';
import 'package:kaylee/models/models.dart';
import 'package:kaylee/res/res.dart';
import 'package:kaylee/screens/screens.dart';
import 'package:kaylee/widgets/widgets.dart';

class FilterButton<T extends Filter> extends StatefulWidget {
  final KayleeFilterInterface<T>? controller;

  FilterButton({this.controller});

  @override
  _FilterButtonState<T> createState() => _FilterButtonState<T>();
}

class _FilterButtonState<T extends Filter> extends BaseState<FilterButton<T>> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return KayleeAppBarAction.iconButton(
      icon: widget.controller?.isEmptyFilter ?? true
          ? Images.icSearch
          : Images.icSearchActive,
      iconColor:
          (widget.controller?.isEmptyFilter ?? true) ? null : ColorsRes.hyper,
      onTap: () {
        Navigator.push<Bundle>(
          context,
          MaterialPageRoute(
            builder: (context) => FilterScreen<T>(
              controller: widget.controller,
            ),
          ),
        ).then((value) {
          if (value is Bundle && (value.args ?? false)) {
            widget.controller?.loadFilter();
            setState(() {});
          }
        });
      },
    );
  }
}
