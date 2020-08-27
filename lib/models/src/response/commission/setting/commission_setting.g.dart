// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'commission_setting.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CommissionSetting _$CommissionSettingFromJson(Map<String, dynamic> json) {
  return CommissionSetting(
    id: json['id'] as int,
    commissionProduct: json['commission_product'] as int,
    commissionService: json['commission_service'] as int,
  );
}

Map<String, dynamic> _$CommissionSettingToJson(CommissionSetting instance) =>
    <String, dynamic>{
      'id': instance.id,
      'commission_product': instance.commissionProduct,
      'commission_service': instance.commissionService,
    };
