// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'commission_detail.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CommissionDetail _$CommissionDetailFromJson(Map<String, dynamic> json) {
  return CommissionDetail(
    total: json['total'] as int,
    commission: json['commission'] as int,
  );
}

Map<String, dynamic> _$CommissionDetailToJson(CommissionDetail instance) =>
    <String, dynamic>{
      'total': instance.total,
      'commission': instance.commission,
    };
