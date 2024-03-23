import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:studenthub/models/common/project_scope.dart';
import 'package:studenthub/models/common/proposal_model.dart';
import 'package:studenthub/models/student_create_profile/skillset_model.dart';

class Project {
  String? id;
  String? title;
  ProjectScope? projectScope;
  String? type;
  String? description;
  List<SkillSet>? requiredSkillSet;
  List<Proposal>? proposals;
  int? numberOfStudent;
  Project({
    this.id,
    this.title,
    this.type,
    this.description,
    this.requiredSkillSet,
    this.proposals,
  });

  Project copyWith({
    String? id,
    String? title,
    String? type,
    String? description,
    List<SkillSet>? requiredSkillSet,
    List<Proposal>? proposals,
  }) {
    return Project(
      id: id ?? this.id,
      title: title ?? this.title,
      type: type ?? this.type,
      description: description ?? this.description,
      requiredSkillSet: requiredSkillSet ?? this.requiredSkillSet,
      proposals: proposals ?? this.proposals,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (id != null) {
      result.addAll({'id': id});
    }
    if (title != null) {
      result.addAll({'title': title});
    }
    if (type != null) {
      result.addAll({'type': type});
    }
    if (description != null) {
      result.addAll({'description': description});
    }
    if (requiredSkillSet != null) {
      result.addAll({'requiredSkillSet': requiredSkillSet!.map((x) => x?.toMap()).toList()});
    }
    if (proposals != null) {
      result.addAll({'proposals': proposals!.map((x) => x?.toMap()).toList()});
    }

    return result;
  }

  factory Project.fromMap(Map<String, dynamic> map) {
    return Project(
      id: map['id'],
      title: map['title'],
      type: map['type'],
      description: map['description'],
      requiredSkillSet: map['requiredSkillSet'] != null
          ? List<SkillSet>.from(map['requiredSkillSet']?.map((x) => SkillSet.fromMap(x)))
          : null,
      proposals:
          map['proposals'] != null ? List<Proposal>.from(map['proposals']?.map((x) => Proposal.fromMap(x))) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Project.fromJson(String source) => Project.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Project(id: $id, title: $title, type: $type, description: $description, requiredSkillSet: $requiredSkillSet, proposals: $proposals)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Project &&
        other.id == id &&
        other.title == title &&
        other.type == type &&
        other.description == description &&
        listEquals(other.requiredSkillSet, requiredSkillSet) &&
        listEquals(other.proposals, proposals);
  }

  @override
  int get hashCode {
    return id.hashCode ^
        title.hashCode ^
        type.hashCode ^
        description.hashCode ^
        requiredSkillSet.hashCode ^
        proposals.hashCode;
  }
}
