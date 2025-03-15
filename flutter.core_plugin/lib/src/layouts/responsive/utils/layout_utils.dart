import 'package:flutter/material.dart';

import '../constants.dart';

bool isMobileScreen(BuildContext context) {
  return MediaQuery.of(context).size.width < tabletWidthMin;
}

bool isTabletScreen(BuildContext context) {
  return MediaQuery.of(context).size.width >= tabletWidthMin &&
      MediaQuery.of(context).size.width < desktopWidthMin;
}

bool isDesktopScreen(BuildContext context) {
  return MediaQuery.of(context).size.width >= desktopWidthMin;
}