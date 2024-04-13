import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:studenthub/models/student/student_create_profile/skillset_model.dart';

class ProjectResume {
  int? id;
  dynamic studentId;
  String? title;
  String? startMonth;
  String? endMonth;
  String? description;
  List<SkillSet>? skillSets;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;
  ProjectResume({
    this.id,
    this.studentId,
    this.title,
    this.startMonth,
    this.endMonth,
    this.description,
    this.skillSets,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  ProjectResume copyWith({
    int? id,
    String? studentId,
    String? title,
    String? startMonth,
    String? endMonth,
    String? description,
    List<SkillSet>? skillSets,
    String? createdAt,
    String? updatedAt,
    String? deletedAt,
  }) {
    return ProjectResume(
      id: id ?? this.id,
      studentId: studentId ?? this.studentId,
      title: title ?? this.title,
      startMonth: startMonth ?? this.startMonth,
      endMonth: endMonth ?? this.endMonth,
      description: description ?? this.description,
      skillSets: skillSets ?? this.skillSets,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (id != null) {
      result.addAll({'id': id});
    }
    if (studentId != null) {
      result.addAll({'studentId': studentId});
    }
    if (title != null) {
      result.addAll({'title': title});
    }
    if (startMonth != null) {
      result.addAll({'startMonth': startMonth});
    }
    if (endMonth != null) {
      result.addAll({'endMonth': endMonth});
    }
    if (description != null) {
      result.addAll({'description': description});
    }
    if (skillSets != null) {
      result.addAll({'skillSets': skillSets!.map((x) => x.toMap()).toList()});
    }
    if (createdAt != null) {
      result.addAll({'createdAt': createdAt});
    }
    if (updatedAt != null) {
      result.addAll({'updatedAt': updatedAt});
    }
    if (deletedAt != null) {
      result.addAll({'deletedAt': deletedAt});
    }

    return result;
  }

  factory ProjectResume.fromMap(Map<String, dynamic> map) {
    return ProjectResume(
      id: map['id']?.toInt(),
      studentId: map['studentId'],
      title: map['title'],
      startMonth: map['startMonth'],
      endMonth: map['endMonth'],
      description: map['description'],
      skillSets:
          map['skillSets'] != null ? List<SkillSet>.from(map['skillSets']?.map((x) => SkillSet.fromMap(x))) : null,
      createdAt: map['createdAt'],
      updatedAt: map['updatedAt'],
      deletedAt: map['deletedAt'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ProjectResume.fromJson(String source) => ProjectResume.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ProjectResume(id: $id, studentId: $studentId, title: $title, startMonth: $startMonth, endMonth: $endMonth, description: $description, skillSets: $skillSets, createdAt: $createdAt, updatedAt: $updatedAt, deletedAt: $deletedAt)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ProjectResume &&
        other.id == id &&
        other.studentId == studentId &&
        other.title == title &&
        other.startMonth == startMonth &&
        other.endMonth == endMonth &&
        other.description == description &&
        listEquals(other.skillSets, skillSets) &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt &&
        other.deletedAt == deletedAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        studentId.hashCode ^
        title.hashCode ^
        startMonth.hashCode ^
        endMonth.hashCode ^
        description.hashCode ^
        skillSets.hashCode ^
        createdAt.hashCode ^
        updatedAt.hashCode ^
        deletedAt.hashCode;
  }
}
