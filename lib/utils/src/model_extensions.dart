import 'package:kaylee/models/models.dart';
import 'package:kaylee/res/res.dart';

extension CancellationReasonExtension on CancellationReason {
  String get text {
    switch (this) {
      case CancellationReason.noNeed:
        return Strings.khongCoNhuCau;
      case CancellationReason.reOrdered:
        return Strings.datLaiDonKhac;
      case CancellationReason.changeReceivedInfo:
        return Strings.thayDoiThongTinGiaoHang;
      case CancellationReason.other:
        return Strings.lyDoKhac;
      default:
        return '';
    }
  }
}

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
        return Images.ic_cash;
      case PaymentMethod.credit:
      case PaymentMethod.atm:
        return Images.ic_card;
      case PaymentMethod.momo:
        return Images.ic_momo;
      default:
        return '';
    }
  }
}
