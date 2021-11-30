import 'package:kaylee/apis/apis.dart';

abstract class ApiProvider {
  UserApi get user;

  CommonApi get common;

  SupplierApi get supplier;

  ProductApi get product;

  NotificationApi get notification;

  ServiceApi get service;

  BrandApi get brand;

  EmployeeApi get employee;

  CustomerApi get customer;

  RoleApi get role;

  OrderApi get order;

  CommissionApi get commission;

  ReportApi get report;

  ReservationApi get reservation;

  CampaignApi get campaign;

  AdvertiseApi get advertise;
}
