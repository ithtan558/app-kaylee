// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_image.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductImage _$ProductImageFromJson(Map<String, dynamic> json) => ProductImage(
      type: $enumDecodeNullable(_$ProductImageTypeEnumMap, json['type']),
      value: json['value'] as String?,
    );

Map<String, dynamic> _$ProductImageToJson(ProductImage instance) =>
    <String, dynamic>{
      'type': _$ProductImageTypeEnumMap[instance.type],
      'value': instance.value,
    };

const _$ProductImageTypeEnumMap = {
  ProductImageType.image: 1,
  ProductImageType.video: 2,
};
