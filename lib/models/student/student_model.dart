import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:studenthub/models/student/student_create_profile/education_model.dart';
import 'package:studenthub/models/student/student_create_profile/language_model.dart';
import 'package:studenthub/models/student/student_create_profile/project_model.dart';
import 'package:studenthub/models/student/student_create_profile/skillset_model.dart';
import 'package:studenthub/models/student/student_create_profile/tech_stack.dart';

class User {
  String? fullname;
  User({
    this.fullname,
  });

  User copyWith({
    String? fullname,
  }) {
    return User(
      fullname: fullname ?? this.fullname,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (fullname != null) {
      result.addAll({'fullname': fullname});
    }

    return result;
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      fullname: map['fullname'],
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(json.decode(source));

  @override
  String toString() => 'User(fullname: $fullname)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is User && other.fullname == fullname;
  }

  @override
  int get hashCode => fullname.hashCode;
}

class Student {
  int? id;
  int? userId;
  String? fullname;
  String? email;
  int? techStackId;
  List<SkillSet>? skillSets;
  List<Language>? languages;
  List<ProjectResume>? experiences;
  List<Education>? educations;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;
  TechStack? techStack;
  String? resume;
  User? user;
  String? transcript;
  String? resumeUrl;
  String? transcriptUrl;
  Student({
    this.id,
    this.userId,
    this.fullname,
    this.email,
    this.techStackId,
    this.skillSets,
    this.languages,
    this.experiences,
    this.educations,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.techStack,
    this.resume,
    this.user,
    this.transcript,
    this.resumeUrl,
    this.transcriptUrl,
  });

  Student copyWith({
    int? id,
    int? userId,
    String? fullname,
    String? email,
    int? techStackId,
    List<SkillSet>? skillSets,
    List<Language>? languages,
    List<ProjectResume>? experiences,
    List<Education>? educations,
    String? createdAt,
    String? updatedAt,
    String? deletedAt,
    TechStack? techStack,
    String? resume,
    User? user,
    String? transcript,
    String? resumeUrl,
    String? transcriptUrl,
  }) {
    return Student(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      fullname: fullname ?? this.fullname,
      email: email ?? this.email,
      techStackId: techStackId ?? this.techStackId,
      skillSets: skillSets ?? this.skillSets,
      languages: languages ?? this.languages,
      experiences: experiences ?? this.experiences,
      educations: educations ?? this.educations,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      techStack: techStack ?? this.techStack,
      resume: resume ?? this.resume,
      user: user ?? this.user,
      transcript: transcript ?? this.transcript,
      resumeUrl: resumeUrl ?? this.resumeUrl,
      transcriptUrl: transcriptUrl ?? this.transcriptUrl,
    );
  }

  Student reset() {
    return Student(
      id: id,
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
    if (skillSets != null) {
      result.addAll({'skillSets': skillSets!.map((x) => x?.toMap()).toList()});
    }
    if (languages != null) {
      result.addAll({'languages': languages!.map((x) => x?.toMap()).toList()});
    }
    if (experiences != null) {
      result.addAll({'experiences': experiences!.map((x) => x?.toMap()).toList()});
    }
    if (educations != null) {
      result.addAll({'educations': educations!.map((x) => x?.toMap()).toList()});
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
    if (techStack != null) {
      result.addAll({'techStack': techStack!.toMap()});
    }
    if (resume != null) {
      result.addAll({'resume': resume});
    }
    if (user != null) {
      result.addAll({'user': user!.toMap()});
    }
    if (transcript != null) {
      result.addAll({'transcript': transcript});
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
      skillSets:
          map['skillSets'] != null ? List<SkillSet>.from(map['skillSets']?.map((x) => SkillSet.fromMap(x))) : null,
      languages:
          map['languages'] != null ? List<Language>.from(map['languages']?.map((x) => Language.fromMap(x))) : null,
      experiences: map['experiences'] != null
          ? List<ProjectResume>.from(map['experiences']?.map((x) => ProjectResume.fromMap(x)))
          : null,
      educations:
          map['educations'] != null ? List<Education>.from(map['educations']?.map((x) => Education.fromMap(x))) : null,
      createdAt: map['createdAt'],
      updatedAt: map['updatedAt'],
      deletedAt: map['deletedAt'],
      techStack: map['techStack'] != null ? TechStack.fromMap(map['techStack']) : null,
      resume: map['resume'],
      user: map['user'] != null ? User.fromMap(map['user']) : null,
      transcript: map['transcript'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Student.fromJson(String source) => Student.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Student(id: $id, userId: $userId, fullname: $fullname, email: $email, techStackId: $techStackId, skillSets: $skillSets, languages: $languages, experiences: $experiences, educations: $educations, createdAt: $createdAt, updatedAt: $updatedAt, deletedAt: $deletedAt, techStack: $techStack, resume: $resume, user: $user, transcript: $transcript)';
  }
}
