// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Product _$ProductFromJson(Map<String, dynamic> json) => Product(
      id: json['id'] as int?,
      code: json['code'] as String?,
      name: json['name'] as String?,
      image: json['image'] as String? ?? '',
      price: json['price'] as int?,
      description: json['description'] as String?,
      brands: (json['brands'] as List<dynamic>?)
          ?.map((e) => Brand.fromJson(e as Map<String, dynamic>))
          .toList(),
      category: json['category'] == null
          ? null
          : ProdCate.fromJson(json['category'] as Map<String, dynamic>),
      quantity: json['quantity'] as int?,
      images: (json['images'] as List<dynamic>?)
              ?.map((e) => ProductImage.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      oldPrice: json['old_price'] as int?,
      percent: json['percent'] as int?,
      type: json['type'] as int?,
      supplier: json['supplier'] == null
          ? null
          : Supplier.fromJson(json['supplier'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ProductToJson(Product instance) => <String, dynamic>{
      'id': instance.id,
      'code': instance.code,
      'name': instance.name,
      'image': instance.image,
      'price': instance.price,
      'description': instance.description,
      'brands': instance.brands,
      'images': instance.images,
      'old_price': instance.oldPrice,
      'percent': instance.percent,
      'type': instance.type,
      'supplier': instance.supplier,
      'category': instance.category,
      'quantity': instance.quantity,
    };
