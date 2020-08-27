// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'commission_products.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CommissionProducts _$CommissionProductsFromJson(Map<String, dynamic> json) {
  return CommissionProducts()
    ..page = json['page'] as int
    ..limit = json['limit'] as int
    ..total = json['total'] as int
    ..pages = json['pages'] as int
    ..items = (json['items'] as List)
        ?.map((e) => e == null
            ? null
            : CommissionProduct.fromJson(e as Map<String, dynamic>))
        ?.toList();
}

Map<String, dynamic> _$CommissionProductsToJson(CommissionProducts instance) =>
    <String, dynamic>{
      'page': instance.page,
      'limit': instance.limit,
      'total': instance.total,
      'pages': instance.pages,
      'items': instance.items?.map((e) => e?.toJson())?.toList(),
    };
