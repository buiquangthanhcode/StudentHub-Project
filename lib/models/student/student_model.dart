import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:studenthub/models/student/student_create_profile/education_model.dart';
import 'package:studenthub/models/student/student_create_profile/language_model.dart';
import 'package:studenthub/models/student/student_create_profile/project_model.dart';
import 'package:studenthub/models/student/student_create_profile/skillset_model.dart';

class Student {
  String? id;
  String? userId;
  String? fullname;
  String? email;
  String? techStack;
  List<SkillSet>? skillSet;
  List<Language>? languages;
  List<ProjectResume>? projectResume;
  List<Education>? educations;
  String? createdTime;
  String? updatedTime;
  Student({
    required this.id,
    required this.userId,
    required this.fullname,
    required this.email,
    required this.techStack,
    required this.skillSet,
    required this.languages,
    required this.projectResume,
    required this.educations,
    required this.createdTime,
    required this.updatedTime,
  });

  Student copyWith({
    String? id,
    String? userId,
    String? fullname,
    String? email,
    String? techStack,
    List<SkillSet>? skillSet,
    List<Language>? languages,
    List<ProjectResume>? projectResume,
    List<Education>? educations,
    String? createdTime,
    String? updatedTime,
  }) {
    return Student(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      fullname: fullname ?? this.fullname,
      email: email ?? this.email,
      techStack: techStack ?? this.techStack,
      skillSet: skillSet ?? this.skillSet,
      languages: languages ?? this.languages,
      projectResume: projectResume ?? this.projectResume,
      educations: educations ?? this.educations,
      createdTime: createdTime ?? this.createdTime,
      updatedTime: updatedTime ?? this.updatedTime,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'id': id});
    result.addAll({'userId': userId});
    result.addAll({'fullname': fullname});
    result.addAll({'email': email});
    result.addAll({'techStack': techStack});
    result.addAll({'skillSet': skillSet?.map((x) => x.toMap()).toList()});
    result.addAll({'languages': languages?.map((x) => x.toMap()).toList()});
    result.addAll({'projectResume': projectResume?.map((x) => x.toMap()).toList()});
    result.addAll({'educations': educations?.map((x) => x.toMap()).toList()});
    result.addAll({'createdTime': createdTime});
    result.addAll({'updatedTime': updatedTime});

    return result;
  }

  factory Student.fromMap(Map<String, dynamic> map) {
    return Student(
      id: map['id'] ?? '',
      userId: map['userId'] ?? '',
      fullname: map['fullname'] ?? '',
      email: map['email'] ?? '',
      techStack: map['techStack'] ?? '',
      skillSet: List<SkillSet>.from(map['skillSet']?.map((x) => SkillSet.fromMap(x))),
      languages: List<Language>.from(map['languages']?.map((x) => Language.fromMap(x))),
      projectResume: List<ProjectResume>.from(map['projectResume']?.map((x) => ProjectResume.fromMap(x))),
      educations: List<Education>.from(map['educations']?.map((x) => Education.fromMap(x))),
      createdTime: map['createdTime'] ?? '',
      updatedTime: map['updatedTime'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Student.fromJson(String source) => Student.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Student(id: $id, userId: $userId, fullname: $fullname, email: $email, techStack: $techStack, skillSet: $skillSet, languages: $languages, projectResume: $projectResume, educations: $educations, createdTime: $createdTime, updatedTime: $updatedTime)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Student &&
        other.id == id &&
        other.userId == userId &&
        other.fullname == fullname &&
        other.email == email &&
        other.techStack == techStack &&
        listEquals(other.skillSet, skillSet) &&
        listEquals(other.languages, languages) &&
        listEquals(other.projectResume, projectResume) &&
        listEquals(other.educations, educations) &&
        other.createdTime == createdTime &&
        other.updatedTime == updatedTime;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        userId.hashCode ^
        fullname.hashCode ^
        email.hashCode ^
        techStack.hashCode ^
        skillSet.hashCode ^
        languages.hashCode ^
        projectResume.hashCode ^
        educations.hashCode ^
        createdTime.hashCode ^
        updatedTime.hashCode;
  }
}
