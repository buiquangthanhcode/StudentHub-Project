// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:studenthub/models/common/project_scope.dart';
import 'package:studenthub/models/common/proposal_model.dart';
import 'package:studenthub/models/student/student_create_profile/skillset_model.dart';

class Project {
  int? id;
  String? companyId;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;
  int? projectScopeFlag;
  String? title;
  String? description;
  int? numberOfStudents;
  int? typeFlag;
  List<String>? proposal;
  int? countProposals;
  int? countMessages;
  int? countHired;
  int? projectId;
  Project({
    this.id,
    this.companyId,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.projectScopeFlag,
    this.title,
    this.description,
    this.numberOfStudents,
    this.typeFlag,
    this.proposal,
    this.countProposals,
    this.countMessages,
    this.countHired,
    this.projectId,
  });

  Project copyWith({
    int? id,
    String? companyId,
    String? createdAt,
    String? updatedAt,
    String? deletedAt,
    int? projectScopeFlag,
    String? title,
    String? description,
    int? numberOfStudents,
    int? typeFlag,
    List<String>? proposal,
    int? countProposals,
    int? countMessages,
    int? countHired,
    int? projectId,
  }) {
    return Project(
      id: id ?? this.id,
      companyId: companyId ?? this.companyId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      projectScopeFlag: projectScopeFlag ?? this.projectScopeFlag,
      title: title ?? this.title,
      description: description ?? this.description,
      numberOfStudents: numberOfStudents ?? this.numberOfStudents,
      typeFlag: typeFlag ?? this.typeFlag,
      proposal: proposal ?? this.proposal,
      countProposals: countProposals ?? this.countProposals,
      countMessages: countMessages ?? this.countMessages,
      countHired: countHired ?? this.countHired,
      projectId: projectId ?? this.projectId,
    );
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (id != null) {
      data['id'] = id;
    }
    if (companyId != null) {
      data['companyId'] = companyId;
    }
    if (createdAt != null) {
      data['createdAt'] = createdAt;
    }
    if (updatedAt != null) {
      data['updatedAt'] = updatedAt;
    }
    if (deletedAt != null) {
      data['deletedAt'] = deletedAt;
    }
    if (projectScopeFlag != null) {
      data['projectScopeFlag'] = projectScopeFlag;
    }
    if (title != null) {
      data['title'] = title;
    }
    if (description != null) {
      data['description'] = description;
    }
    if (numberOfStudents != null) {
      data['numberOfStudents'] = numberOfStudents;
    }
    if (typeFlag != null) {
      data['typeFlag'] = typeFlag;
    }
    if (proposal != null) {
      data['proposal'] = proposal;
    }
    if (countProposals != null) {
      data['countProposals'] = countProposals;
    }
    if (countMessages != null) {
      data['countMessages'] = countMessages;
    }
    if (countHired != null) {
      data['countHired'] = countHired;
    }

    return data;
  }

  factory Project.fromMap(Map<String, dynamic> map) {
    return Project(
      id: map['id'] != null ? map['id'] as int : null,
      companyId: map['companyId'] != null ? map['companyId'] as String : null,
      createdAt: map['createdAt'] != null ? map['createdAt'] as String : null,
      updatedAt: map['updatedAt'] != null ? map['updatedAt'] as String : null,
      deletedAt: map['deletedAt'] != null ? map['deletedAt'] as String : null,
      projectScopeFlag: map['projectScopeFlag'] != null
          ? map['projectScopeFlag'] as int
          : null,
      title: map['title'] != null ? map['title'] as String : null,
      description:
          map['description'] != null ? map['description'] as String : null,
      numberOfStudents: map['numberOfStudents'] != null
          ? map['numberOfStudents'] as int
          : null,
      typeFlag: map['typeFlag'] != null ? map['typeFlag'] as int : null,
      proposal: map['proposal'] != null
          ? List<String>.from((map['proposal'] as List<String>))
          : null,
      countProposals:
          map['countProposals'] != null ? map['countProposals'] as int : null,
      countMessages:
          map['countMessages'] != null ? map['countMessages'] as int : null,
      countHired: map['countHired'] != null ? map['countHired'] as int : null,
      projectId: map['projectId'] != null ? map['projectId'] as int : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Project.fromJson(String source) =>
      Project.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Project(id: $id, companyId: $companyId, createdAt: $createdAt, updatedAt: $updatedAt, deletedAt: $deletedAt, projectScopeFlag: $projectScopeFlag, title: $title, description: $description, numberOfStudents: $numberOfStudents, typeFlag: $typeFlag, proposal: $proposal, countProposals: $countProposals, countMessages: $countMessages, countHired: $countHired)';
  }

  @override
  bool operator ==(covariant Project other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.companyId == companyId &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt &&
        other.deletedAt == deletedAt &&
        other.projectScopeFlag == projectScopeFlag &&
        other.title == title &&
        other.description == description &&
        other.numberOfStudents == numberOfStudents &&
        other.typeFlag == typeFlag &&
        listEquals(other.proposal, proposal) &&
        other.countProposals == countProposals &&
        other.countMessages == countMessages &&
        other.countHired == countHired;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        companyId.hashCode ^
        createdAt.hashCode ^
        updatedAt.hashCode ^
        deletedAt.hashCode ^
        projectScopeFlag.hashCode ^
        title.hashCode ^
        description.hashCode ^
        numberOfStudents.hashCode ^
        typeFlag.hashCode ^
        proposal.hashCode ^
        countProposals.hashCode ^
        countMessages.hashCode ^
        countHired.hashCode;
  }
}
