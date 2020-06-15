import 'package:core_plugin/core_plugin.dart';
import 'package:flutter/material.dart';
import 'package:kaylee/res/res.dart';
import 'package:kaylee/widgets/kaylee_widgets.dart';

class GuideScreen extends StatefulWidget {
  factory GuideScreen.newInstance() = GuideScreen._;

  GuideScreen._();

  @override
  _GuideScreenState createState() => new _GuideScreenState();
}

class _GuideScreenState extends BaseState<GuideScreen> {
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
    return Scaffold(
      appBar: KayleeAppBar(
        title: Strings.huongDanSd,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(Dimens.px16),
        child: KayleeText.normal16W400(
          'Mauris tristique enim elementum, rhoncus lorem nec, finibus ipsum. Integer iaculis, '
          'neque non varius mollis, neque quam finibus enim, non mattis dolor dui eu urna. '
          'In scelerisque magna eu euismod rutrum. Sed sit amet nisi a lorem accumsan porttitor. '
          'Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. '
          'Praesent gravida blandit mi non tempor. Cras sed nisl porta purus pharetra hendrerit interdum at neque.',
          overflow: TextOverflow.visible,
        ),
      ),
    );
  }
}
