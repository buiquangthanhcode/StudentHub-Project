import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'package:studenthub/models/student/student_model.dart';

class StudentState extends Equatable {
  final Student student;
  final bool isChange;

  const StudentState({required this.student, required this.isChange});

  @override
  List<Object> get props => [student, isChange];

  StudentState update({
    Student? student,
    bool? isChange,
  }) {
    return StudentState(
      student: student ?? this.student,
      isChange: isChange ?? this.isChange,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'student': student.toMap()});
    result.addAll({'isChange': isChange});

    return result;
  }

  factory StudentState.fromMap(Map<String, dynamic> map) {
    return StudentState(
      student: Student.fromMap(map['student']),
      isChange: map['isChange'] ?? false,
    );
  }

  String toJson() => json.encode(toMap());

  factory StudentState.fromJson(String source) => StudentState.fromMap(json.decode(source));
}
