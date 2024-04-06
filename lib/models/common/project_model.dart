// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:studenthub/models/common/project_scope.dart';
import 'package:studenthub/models/common/proposal_model.dart';
import 'package:studenthub/models/student/student_create_profile/skillset_model.dart';

class Project {
  String? companyId;
  int? projectScopeFlag;
  String? title;
  int? numberOfStudents;
  String? description;
  int? typeFlag;
  Project({
    this.companyId,
    this.projectScopeFlag,
    this.title,
    this.numberOfStudents,
    this.description,
    this.typeFlag,
  });

  Project copyWith({
    String? companyId,
    int? projectScopeFlag,
    String? title,
    int? numberOfStudent,
    String? description,
    int? typeFlag,
  }) {
    return Project(
      companyId: companyId ?? this.companyId,
      projectScopeFlag: projectScopeFlag ?? this.projectScopeFlag,
      title: title ?? this.title,
      numberOfStudents: numberOfStudents ?? this.numberOfStudents,
      description: description ?? this.description,
      typeFlag: typeFlag ?? this.typeFlag,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'companyId': companyId,
      'projectScopeFlag': projectScopeFlag,
      'title': title,
      'numberOfStudents': numberOfStudents,
      'description': description,
      'typeFlag': typeFlag,
    };
  }

  factory Project.fromMap(Map<String, dynamic> map) {
    return Project(
      companyId: map['companyId'] != null ? map['companyId'] as String : null,
      projectScopeFlag: map['projectScopeFlag'] != null
          ? map['projectScopeFlag'] as int
          : null,
      title: map['title'] != null ? map['title'] as String : null,
      numberOfStudents: map['numberOfStudents'] != null
          ? map['numberOfStudents'] as int
          : null,
      description:
          map['description'] != null ? map['description'] as String : null,
      typeFlag: map['typeFlag'] != null ? map['typeFlag'] as int : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Project.fromJson(String source) =>
      Project.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Project(companyId: $companyId, projectScopeFlag: $projectScopeFlag, title: $title, numberOfStudent: $numberOfStudents, description: $description, typeFlag: $typeFlag)';
  }

  @override
  bool operator ==(covariant Project other) {
    if (identical(this, other)) return true;

    return other.companyId == companyId &&
        other.projectScopeFlag == projectScopeFlag &&
        other.title == title &&
        other.numberOfStudents == numberOfStudents &&
        other.description == description &&
        other.typeFlag == typeFlag;
  }

  @override
  int get hashCode {
    return companyId.hashCode ^
        projectScopeFlag.hashCode ^
        title.hashCode ^
        numberOfStudents.hashCode ^
        description.hashCode ^
        typeFlag.hashCode;
  }
}
