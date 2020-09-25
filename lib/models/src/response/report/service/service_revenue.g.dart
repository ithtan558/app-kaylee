// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'service_revenue.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ServiceRevenue _$ServiceRevenueFromJson(Map<String, dynamic> json) {
  return ServiceRevenue(
    price: json['price'] as int,
    quantity: json['quantity'] as String,
    name: json['name'] as String,
    amount: json['amount'] as int,
  );
}

Map<String, dynamic> _$ServiceRevenueToJson(ServiceRevenue instance) =>
    <String, dynamic>{
      'price': instance.price,
      'quantity': instance.quantity,
      'name': instance.name,
      'amount': instance.amount,
    };
