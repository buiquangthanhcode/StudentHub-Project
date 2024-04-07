import 'dart:convert';

class Education {
  int? id;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;
  int? studentId;
  String? schoolName;
  String? startYear;
  String? endYear;
  Education({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.studentId,
    this.schoolName,
    this.startYear,
    this.endYear,
  });

  Education copyWith({
    int? id,
    String? createdAt,
    String? updatedAt,
    String? deletedAt,
    int? studentId,
    String? schoolName,
    String? startYear,
    String? endYear,
  }) {
    return Education(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      studentId: studentId ?? this.studentId,
      schoolName: schoolName ?? this.schoolName,
      startYear: startYear ?? this.startYear,
      endYear: endYear ?? this.endYear,
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
    if (studentId != null) {
      result.addAll({'studentId': studentId});
    }
    if (schoolName != null) {
      result.addAll({'schoolName': schoolName});
    }
    if (startYear != null) {
      result.addAll({'startYear': startYear});
    }
    if (endYear != null) {
      result.addAll({'endYear': endYear});
    }

    return result;
  }

  factory Education.fromMap(Map<String, dynamic> map) {
    return Education(
      id: map['id']?.toInt(),
      createdAt: map['createdAt'],
      updatedAt: map['updatedAt'],
      deletedAt: map['deletedAt'],
      studentId: map['studentId']?.toInt(),
      schoolName: map['schoolName'],
      startYear: map['startYear'],
      endYear: map['endYear'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Education.fromJson(String source) => Education.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Education(id: $id, createdAt: $createdAt, updatedAt: $updatedAt, deletedAt: $deletedAt, studentId: $studentId, schoolName: $schoolName, startYear: $startYear, endYear: $endYear)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Education &&
        other.id == id &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt &&
        other.deletedAt == deletedAt &&
        other.studentId == studentId &&
        other.schoolName == schoolName &&
        other.startYear == startYear &&
        other.endYear == endYear;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        createdAt.hashCode ^
        updatedAt.hashCode ^
        deletedAt.hashCode ^
        studentId.hashCode ^
        schoolName.hashCode ^
        startYear.hashCode ^
        endYear.hashCode;
  }
}
