import 'package:flutter/material.dart';
import 'package:studenthub/models/company/company_model.dart';

@immutable
abstract class CompanyEvent {}

class GetAllDataEvent extends CompanyEvent {
  final Company data;
  final int id;
  final Function? onSuccess;
  GetAllDataEvent({
    required this.onSuccess,
    required this.data,
    required this.id,
  });
}

class AddAllDataEvent extends CompanyEvent {
  final Company data;
  final Function? onSuccess;
  AddAllDataEvent({required this.data, required this.onSuccess});
}

class UpdateAllDataEvent extends CompanyEvent {
  final Company data;
  final int id;
  final Function? onSuccess;
  UpdateAllDataEvent(
      {required this.id, required this.data, required this.onSuccess});
}

class SetEmployeeQuantityEvent extends CompanyEvent {
  final Function? onSuccess;
  SetEmployeeQuantityEvent({this.onSuccess});
}

class RemoveEmployeeQuantityEvent extends CompanyEvent {
  final Function? onSuccess;
  RemoveEmployeeQuantityEvent({this.onSuccess});
}

class SetNameEvent extends CompanyEvent {
  final Function? onSuccess;
  SetNameEvent({this.onSuccess});
}

class RemoveNameEvent extends CompanyEvent {
  final Function? onSuccess;
  RemoveNameEvent({this.onSuccess});
}

class SetWebsiteEvent extends CompanyEvent {
  final Function? onSuccess;
  SetWebsiteEvent({this.onSuccess});
}

class RemoveWebsiteEvent extends CompanyEvent {
  final Function? onSuccess;
  RemoveWebsiteEvent({this.onSuccess});
}

class SetDescriptionEvent extends CompanyEvent {
  final Function? onSuccess;
  SetDescriptionEvent({this.onSuccess});
}

class RemoveDescriptionEvent extends CompanyEvent {
  final Function? onSuccess;
  RemoveDescriptionEvent({this.onSuccess});
}
