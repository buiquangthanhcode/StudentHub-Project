import 'dart:convert';

class Proposal {
  final String projectId;
  final String studentId;
  final String coverLetter;
  final int statusFlag;
  final int disableFlag;
  Proposal({
    required this.projectId,
    required this.studentId,
    required this.coverLetter,
    required this.statusFlag,
    required this.disableFlag,
  });

  Proposal copyWith({
    String? projectId,
    String? studentId,
    String? coverLetter,
    int? statusFlag,
    int? disableFlag,
  }) {
    return Proposal(
      projectId: projectId ?? this.projectId,
      studentId: studentId ?? this.studentId,
      coverLetter: coverLetter ?? this.coverLetter,
      statusFlag: statusFlag ?? this.statusFlag,
      disableFlag: disableFlag ?? this.disableFlag,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'projectId': projectId});
    result.addAll({'studentId': studentId});
    result.addAll({'coverLetter': coverLetter});
    result.addAll({'statusFlag': statusFlag});
    result.addAll({'disableFlag': disableFlag});

    return result;
  }

  factory Proposal.fromMap(Map<String, dynamic> map) {
    return Proposal(
      projectId: map['projectId'] ?? '',
      studentId: map['studentId'] ?? '',
      coverLetter: map['coverLetter'] ?? '',
      statusFlag: map['statusFlag']?.toInt() ?? 0,
      disableFlag: map['disableFlag']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory Proposal.fromJson(String source) => Proposal.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Proposal(projectId: $projectId, studentId: $studentId, coverLetter: $coverLetter, statusFlag: $statusFlag, disableFlag: $disableFlag)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Proposal &&
        other.projectId == projectId &&
        other.studentId == studentId &&
        other.coverLetter == coverLetter &&
        other.statusFlag == statusFlag &&
        other.disableFlag == disableFlag;
  }

  @override
  int get hashCode {
    return projectId.hashCode ^ studentId.hashCode ^ coverLetter.hashCode ^ statusFlag.hashCode ^ disableFlag.hashCode;
  }
}
