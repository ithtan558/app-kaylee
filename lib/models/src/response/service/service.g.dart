// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'service.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Service _$ServiceFromJson(Map<String, dynamic> json) {
  return Service(
    id: json['id'] as int,
    name: json['name'] as String,
    time: json['time'] as int,
    price: json['price'] as int,
    description: json['description'] as String,
    image: json['image'] as String,
    brands: (json['brands'] as List)
        ?.map(
            (e) => e == null ? null : Brand.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    category: json['category'] == null
        ? null
        : ServiceCate.fromJson(json['category'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$ServiceToJson(Service instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'time': instance.time,
      'price': instance.price,
      'description': instance.description,
      'image': instance.image,
      'brands': instance.brands,
      'category': instance.category,
    };
