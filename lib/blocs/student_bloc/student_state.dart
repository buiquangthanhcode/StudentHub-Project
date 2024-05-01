import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'package:studenthub/models/common/project_proposal_modal.dart';
import 'package:studenthub/models/student/student_model.dart';

class StudentState extends Equatable {
  final Student student;
  final bool isChange;
  final List<ProjectProposal> submitProjectProposals;
  final List<ProjectProposal> activeProjectProposals;
  const StudentState({
    required this.student,
    required this.isChange,
    required this.submitProjectProposals,
    required this.activeProjectProposals,
  });

  StudentState update({
    Student? student,
    bool? isChange,
    List<ProjectProposal>? submitProjectProposals,
    List<ProjectProposal>? activeProjectProposals,
  }) {
    return StudentState(
      student: student ?? this.student,
      isChange: isChange ?? this.isChange,
      submitProjectProposals: submitProjectProposals ?? this.submitProjectProposals,
      activeProjectProposals: activeProjectProposals ?? this.activeProjectProposals,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'student': student.toMap()});
    result.addAll({'isChange': isChange});
    result.addAll({'submitProjectProposals': submitProjectProposals.map((x) => x.toMap()).toList()});
    result.addAll({'activeProjectProposals': activeProjectProposals.map((x) => x.toMap()).toList()});

    return result;
  }

  factory StudentState.fromMap(Map<String, dynamic> map) {
    return StudentState(
      student: Student.fromMap(map['student']),
      isChange: map['isChange'] ?? false,
      submitProjectProposals:
          List<ProjectProposal>.from(map['submitProjectProposals']?.map((x) => ProjectProposal.fromMap(x))),
      activeProjectProposals:
          List<ProjectProposal>.from(map['activeProjectProposals']?.map((x) => ProjectProposal.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory StudentState.fromJson(String source) => StudentState.fromMap(json.decode(source));

  @override
  String toString() =>
      'StudentState(student: $student, isChange: $isChange, submitProjectProposals: $submitProjectProposals)';

  @override
  List<Object> get props => [student, isChange, submitProjectProposals, activeProjectProposals];
}
