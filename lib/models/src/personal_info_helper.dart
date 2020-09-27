import 'package:anth_package/anth_package.dart';

mixin PersonalInfoHelper {
  String firstName;
  String lastName;

  String get name =>
      (lastName.isNullOrEmpty ? '' : (lastName + ' ')) + (firstName ?? '');
}
