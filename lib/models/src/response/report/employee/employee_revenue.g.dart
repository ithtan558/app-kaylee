// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'employee_revenue.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EmployeeRevenue _$EmployeeRevenueFromJson(Map<String, dynamic> json) {
  return EmployeeRevenue(
    amount: json['amount'] as int,
    firstName: json['first_name'] as String,
    lastName: json['last_name'] as String,
    phone: json['phone'] as String,
  );
}

Map<String, dynamic> _$EmployeeRevenueToJson(EmployeeRevenue instance) =>
    <String, dynamic>{
      'amount': instance.amount,
      'first_name': instance.firstName,
      'last_name': instance.lastName,
      'phone': instance.phone,
    };
