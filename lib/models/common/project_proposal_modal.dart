import 'dart:convert';

import 'package:studenthub/models/common/project_model.dart';
import 'package:studenthub/models/student/student_model.dart';

class ProjectProposal {
  final int? id;
  final String? createdAt;
  final String? updatedAt;
  final String? deletedAt;
  final int? projectId;
  final int? studentId;
  final String? coverLetter;
  final int? statusFlag;
  final int? disableFlag;
  final Project? project;
  final Student? student;
  ProjectProposal({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.projectId,
    this.studentId,
    this.coverLetter,
    this.statusFlag,
    this.disableFlag,
    this.project,
    this.student,
  });

  ProjectProposal copyWith({
    int? id,
    String? createdAt,
    String? updatedAt,
    String? deletedAt,
    int? projectId,
    int? studentId,
    String? coverLetter,
    int? statusFlag,
    int? disableFlag,
    Project? project,
    Student? student,
  }) {
    return ProjectProposal(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      projectId: projectId ?? this.projectId,
      studentId: studentId ?? this.studentId,
      coverLetter: coverLetter ?? this.coverLetter,
      statusFlag: statusFlag ?? this.statusFlag,
      disableFlag: disableFlag ?? this.disableFlag,
      project: project ?? this.project,
      student: student ?? this.student,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (id != null) {
      result.addAll({'id': id});
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
    if (projectId != null) {
      result.addAll({'projectId': projectId});
    }
    if (studentId != null) {
      result.addAll({'studentId': studentId});
    }
    if (coverLetter != null) {
      result.addAll({'coverLetter': coverLetter});
    }
    if (statusFlag != null) {
      result.addAll({'statusFlag': statusFlag});
    }
    if (disableFlag != null) {
      result.addAll({'disableFlag': disableFlag});
    }
    if (project != null) {
      result.addAll({'project': project!.toMap()});
    }
    if (student != null) {
      result.addAll({'student': student!.toMap()});
    }

    return result;
  }

  factory ProjectProposal.fromMap(Map<String, dynamic> map) {
    return ProjectProposal(
      id: map['id']?.toInt(),
      createdAt: map['createdAt'],
      updatedAt: map['updatedAt'],
      deletedAt: map['deletedAt'],
      projectId: map['projectId']?.toInt(),
      studentId: map['studentId']?.toInt(),
      coverLetter: map['coverLetter'],
      statusFlag: map['statusFlag']?.toInt(),
      disableFlag: map['disableFlag']?.toInt(),
      project: map['project'] != null ? Project.fromMap(map['project']) : null,
      student: map['student'] != null ? Student.fromMap(map['student']) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ProjectProposal.fromJson(String source) => ProjectProposal.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ProjectProposal(id: $id, createdAt: $createdAt, updatedAt: $updatedAt, deletedAt: $deletedAt, projectId: $projectId, studentId: $studentId, coverLetter: $coverLetter, statusFlag: $statusFlag, disableFlag: $disableFlag, project: $project, student: $student)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ProjectProposal &&
        other.id == id &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt &&
        other.deletedAt == deletedAt &&
        other.projectId == projectId &&
        other.studentId == studentId &&
        other.coverLetter == coverLetter &&
        other.statusFlag == statusFlag &&
        other.disableFlag == disableFlag &&
        other.project == project &&
        other.student == student;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        createdAt.hashCode ^
        updatedAt.hashCode ^
        deletedAt.hashCode ^
        projectId.hashCode ^
        studentId.hashCode ^
        coverLetter.hashCode ^
        statusFlag.hashCode ^
        disableFlag.hashCode ^
        project.hashCode ^
        student.hashCode;
  }
}
