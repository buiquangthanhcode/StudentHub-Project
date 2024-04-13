import 'package:flutter/material.dart';

@immutable
abstract class AllProjectEvent {}

class GetAllDataEvent extends AllProjectEvent {
  GetAllDataEvent();
}

class GetProjectDetail extends AllProjectEvent {
  final String id;
  GetProjectDetail({required this.id});
}

class GetFavoriteProject extends AllProjectEvent {
  final String studentId;
  GetFavoriteProject({required this.studentId});
}
