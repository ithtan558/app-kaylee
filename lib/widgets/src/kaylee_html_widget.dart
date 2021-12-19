import 'dart:async';

import 'package:anth_package/anth_package.dart';
import 'package:flutter/material.dart';

class KayleeHtmlWidget extends StatelessWidget {
  final String html;
  final CustomWidgetBuilder? customWidgetBuilder;
  final FutureOr<bool> Function(String)? onTapUrl;

  const KayleeHtmlWidget({
    Key? key,
    required this.html,
    this.customWidgetBuilder,
    this.onTapUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return HtmlWidget(
      html,
      textStyle: TextStyles.normal16W400,
      customWidgetBuilder: customWidgetBuilder,
      onTapUrl: onTapUrl,
      factoryBuilder: () => _KayleeWidgetFactory(),
    );
  }
}

class _KayleeWidgetFactory extends WidgetFactory {
  @override
  bool get webViewJs => true;

  @override
  bool get webView => true;
}
