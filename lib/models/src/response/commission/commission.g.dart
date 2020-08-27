// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'commission.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Commission _$CommissionFromJson(Map<String, dynamic> json) {
  return Commission(
    commissionTotal: json['commission_total'] as int,
    commissionProduct: json['commission_product'] == null
        ? null
        : CommissionDetail.fromJson(
            json['commission_product'] as Map<String, dynamic>),
    commissionService: json['commission_service'] == null
        ? null
        : CommissionDetail.fromJson(
            json['commission_service'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$CommissionToJson(Commission instance) =>
    <String, dynamic>{
      'commission_total': instance.commissionTotal,
      'commission_product': instance.commissionProduct?.toJson(),
      'commission_service': instance.commissionService?.toJson(),
    };
