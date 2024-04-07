import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:studenthub/models/student/student_create_profile/education_model.dart';
import 'package:studenthub/models/student/student_create_profile/language_model.dart';
import 'package:studenthub/models/student/student_create_profile/project_model.dart';
import 'package:studenthub/models/student/student_create_profile/skillset_model.dart';

class Student {
  int? id;
  int? userId;
  String? fullname;
  String? email;
  int? techStackId;
  List<SkillSet>? skillSet;
  List<Language>? languages;
  List<ProjectResume>? projectResume;
  List<Education>? educations;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;
  Student({
    this.id,
    this.userId,
    this.fullname,
    this.email,
    this.techStackId,
    this.skillSet,
    this.languages,
    this.projectResume,
    this.educations,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  Student copyWith({
    int? id,
    int? userId,
    String? fullname,
    String? email,
    int? techStackId,
    List<SkillSet>? skillSet,
    List<Language>? languages,
    List<ProjectResume>? projectResume,
    List<Education>? educations,
    String? createdAt,
    String? updatedAt,
    String? deletedAt,
  }) {
    return Student(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      fullname: fullname ?? this.fullname,
      email: email ?? this.email,
      techStackId: techStackId ?? this.techStackId,
      skillSet: skillSet ?? this.skillSet,
      languages: languages ?? this.languages,
      projectResume: projectResume ?? this.projectResume,
      educations: educations ?? this.educations,
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
    if (userId != null) {
      result.addAll({'userId': userId});
    }
    if (fullname != null) {
      result.addAll({'fullname': fullname});
    }
    if (email != null) {
      result.addAll({'email': email});
    }
    if (techStackId != null) {
      result.addAll({'techStackId': techStackId});
    }
    if (skillSet != null) {
      result.addAll({'skillSet': skillSet!.map((x) => x.toMap()).toList()});
    }
    if (languages != null) {
      result.addAll({'languages': languages!.map((x) => x.toMap()).toList()});
    }
    if (projectResume != null) {
      result.addAll({'projectResume': projectResume!.map((x) => x.toMap()).toList()});
    }
    if (educations != null) {
      result.addAll({'educations': educations!.map((x) => x.toMap()).toList()});
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

  factory Student.fromMap(Map<String, dynamic> map) {
    return Student(
      id: map['id']?.toInt(),
      userId: map['userId']?.toInt(),
      fullname: map['fullname'],
      email: map['email'],
      techStackId: map['techStackId']?.toInt(),
      skillSet: map['skillSet'] != null ? List<SkillSet>.from(map['skillSet']?.map((x) => SkillSet.fromMap(x))) : null,
      languages:
          map['languages'] != null ? List<Language>.from(map['languages']?.map((x) => Language.fromMap(x))) : null,
      projectResume: map['projectResume'] != null
          ? List<ProjectResume>.from(map['projectResume']?.map((x) => ProjectResume.fromMap(x)))
          : null,
      educations:
          map['educations'] != null ? List<Education>.from(map['educations']?.map((x) => Education.fromMap(x))) : null,
      createdAt: map['createdAt'],
      updatedAt: map['updatedAt'],
      deletedAt: map['deletedAt'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Student.fromJson(String source) => Student.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Student(id: $id, userId: $userId, fullname: $fullname, email: $email, techStackId: $techStackId, skillSet: $skillSet, languages: $languages, projectResume: $projectResume, educations: $educations, createdAt: $createdAt, updatedAt: $updatedAt, deletedAt: $deletedAt)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Student &&
        other.id == id &&
        other.userId == userId &&
        other.fullname == fullname &&
        other.email == email &&
        other.techStackId == techStackId &&
        listEquals(other.skillSet, skillSet) &&
        listEquals(other.languages, languages) &&
        listEquals(other.projectResume, projectResume) &&
        listEquals(other.educations, educations) &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt &&
        other.deletedAt == deletedAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        userId.hashCode ^
        fullname.hashCode ^
        email.hashCode ^
        techStackId.hashCode ^
        skillSet.hashCode ^
        languages.hashCode ^
        projectResume.hashCode ^
        educations.hashCode ^
        createdAt.hashCode ^
        updatedAt.hashCode ^
        deletedAt.hashCode;
  }
}
