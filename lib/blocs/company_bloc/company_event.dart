import 'package:flutter/material.dart';


@immutable
abstract class CompanyEvent {}

  String? employeeQuantity;
  String? name;
  String? website;
  String? description;

class GetAllDataEvent extends CompanyEvent {
  final Function? onSuccess;
  GetAllDataEvent({this.onSuccess});
}

class SetEmployeeQuantityEvent extends CompanyEvent {
  final Function? onSuccess;
  SetEmployeeQuantityEvent({this.onSuccess});
}

class RemoveEmployeeQuantityEvent extends CompanyEvent{
  
}

