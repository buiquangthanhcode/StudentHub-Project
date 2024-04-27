import 'dart:convert';

class Proposal {
  final int projectId;
  final int studentId;
  final String coverLetter;
  final int statusFlag;
  final int disableFlag;
  final String createdAt;
  final String updatedAt;
  final String deletedAt;
  final int id;
  Proposal({
    required this.projectId,
    required this.studentId,
    required this.coverLetter,
    required this.statusFlag,
    required this.disableFlag,
    required this.createdAt,
    required this.updatedAt,
    required this.deletedAt,
    required this.id,
  });

  Proposal copyWith({
    int? projectId,
    int? studentId,
    String? coverLetter,
    int? statusFlag,
    int? disableFlag,
    String? createdAt,
    String? updatedAt,
    String? deletedAt,
    int? id,
  }) {
    return Proposal(
      projectId: projectId ?? this.projectId,
      studentId: studentId ?? this.studentId,
      coverLetter: coverLetter ?? this.coverLetter,
      statusFlag: statusFlag ?? this.statusFlag,
      disableFlag: disableFlag ?? this.disableFlag,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      id: id ?? this.id,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'projectId': projectId});
    result.addAll({'studentId': studentId});
    result.addAll({'coverLetter': coverLetter});
    result.addAll({'statusFlag': statusFlag});
    result.addAll({'disableFlag': disableFlag});
    result.addAll({'createdAt': createdAt});
    result.addAll({'updatedAt': updatedAt});
    result.addAll({'deletedAt': deletedAt});
    result.addAll({'id': id});

    return result;
  }

  factory Proposal.fromMap(Map<String, dynamic> map) {
    return Proposal(
      projectId: map['projectId']?.toInt() ?? 0,
      studentId: map['studentId']?.toInt() ?? 0,
      coverLetter: map['coverLetter'] ?? '',
      statusFlag: map['statusFlag']?.toInt() ?? 0,
      disableFlag: map['disableFlag']?.toInt() ?? 0,
      createdAt: map['createdAt'] ?? '',
      updatedAt: map['updatedAt'] ?? '',
      deletedAt: map['deletedAt'] ?? '',
      id: map['id']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory Proposal.fromJson(String source) => Proposal.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Proposal(projectId: $projectId, studentId: $studentId, coverLetter: $coverLetter, statusFlag: $statusFlag, disableFlag: $disableFlag, createdAt: $createdAt, updatedAt: $updatedAt, deletedAt: $deletedAt, id: $id)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Proposal &&
        other.projectId == projectId &&
        other.studentId == studentId &&
        other.coverLetter == coverLetter &&
        other.statusFlag == statusFlag &&
        other.disableFlag == disableFlag &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt &&
        other.deletedAt == deletedAt &&
        other.id == id;
  }

  @override
  int get hashCode {
    return projectId.hashCode ^
        studentId.hashCode ^
        coverLetter.hashCode ^
        statusFlag.hashCode ^
        disableFlag.hashCode ^
        createdAt.hashCode ^
        updatedAt.hashCode ^
        deletedAt.hashCode ^
        id.hashCode;
  }
}
