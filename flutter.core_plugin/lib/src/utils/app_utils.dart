import 'package:flutter/foundation.dart';
import 'package:url_launcher/url_launcher.dart' as url_launcher;

bool isMobileOS() {
  return defaultTargetPlatform == TargetPlatform.android ||
      defaultTargetPlatform == TargetPlatform.iOS ||
      defaultTargetPlatform == TargetPlatform.fuchsia;
}

bool isDesktopOS() {
  return defaultTargetPlatform != TargetPlatform.android &&
      defaultTargetPlatform != TargetPlatform.iOS &&
      defaultTargetPlatform != TargetPlatform.fuchsia;
}

void mobileLaunchUrl(url) async {
  try {
    if (await url_launcher.canLaunch(url)) {
      await url_launcher.launch(url);
    } else {
      throw 'Could not launch $url';
    }
  } catch (e) {
    if (kDebugMode) {
      print(e.toString());
    }
  }
}

void makeCall(phoneNumber) async {
  try {
    if (await url_launcher.canLaunch('tel:$phoneNumber')) {
      await url_launcher.launch('tel:$phoneNumber');
    } else {
      throw 'Could not launch $phoneNumber';
    }
  } catch (e) {
    if (kDebugMode) {
      print(e.toString());
    }
  }
}

void sendEmail(email) async {
  try {
    if (await url_launcher.canLaunch('mailto:$email')) {
      await url_launcher.launch('mailto:$email');
    } else {
      throw 'Could not launch $email';
    }
  } catch (e) {
    if (kDebugMode) {
      print(e.toString());
    }
  }
}
