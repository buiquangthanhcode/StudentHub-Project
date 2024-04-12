import 'package:flutter/material.dart';
import 'package:studenthub/models/company/company_model.dart';
import 'package:studenthub/models/common/project_model.dart';

@immutable
abstract class AllProjectEvent {}

class GetAllDataEvent extends AllProjectEvent {
  GetAllDataEvent();
}

class GetProjectDetail extends AllProjectEvent {
  final String id;
  GetProjectDetail({required this.id});
}
