import 'package:kaylee/models/models.dart';
import 'package:kaylee/res/res.dart';

extension PaymentMethodExtension on PaymentMethod {
  String get text {
    switch (this) {
      case PaymentMethod.cash:
        return Strings.tienMat;
      case PaymentMethod.credit:
        return Strings.theTinDung;
      case PaymentMethod.atm:
        return Strings.theAtm;
      case PaymentMethod.momo:
        return Strings.momo;
      default:
        return '';
    }
  }

  String get icon {
    switch (this) {
      case PaymentMethod.cash:
        return Images.icCash;
      case PaymentMethod.credit:
      case PaymentMethod.atm:
      return Images.icCard;
      case PaymentMethod.momo:
        return Images.icMomo;
      default:
        return '';
    }
  }
}
