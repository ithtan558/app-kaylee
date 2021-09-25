// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'employee_revenue.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EmployeeRevenue _$EmployeeRevenueFromJson(Map<String, dynamic> json) =>
    EmployeeRevenue(
      amount: json['amount'] as int?,
      name: json['name'] as String?,
      phone: json['phone'] as String?,
    );

Map<String, dynamic> _$EmployeeRevenueToJson(EmployeeRevenue instance) =>
    <String, dynamic>{
      'amount': instance.amount,
      'name': instance.name,
      'phone': instance.phone,
    };
