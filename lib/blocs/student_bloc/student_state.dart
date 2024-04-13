import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'package:studenthub/models/common/project_proposal_modal.dart';
import 'package:studenthub/models/student/student_model.dart';

class StudentState extends Equatable {
  final Student student;
  final bool isChange;
  final List<ProjectProposal> projectProposals;
  StudentState({
    required this.student,
    required this.isChange,
    required this.projectProposals,
  });

  StudentState update({
    Student? student,
    bool? isChange,
    List<ProjectProposal>? projectProposals,
  }) {
    return StudentState(
      student: student ?? this.student,
      isChange: isChange ?? this.isChange,
      projectProposals: projectProposals ?? this.projectProposals,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'student': student.toMap()});
    result.addAll({'isChange': isChange});
    result.addAll({'projectProposals': projectProposals.map((x) => x.toMap()).toList()});

    return result;
  }

  factory StudentState.fromMap(Map<String, dynamic> map) {
    return StudentState(
      student: Student.fromMap(map['student']),
      isChange: map['isChange'] ?? false,
      projectProposals: List<ProjectProposal>.from(map['projectProposals']?.map((x) => ProjectProposal.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory StudentState.fromJson(String source) => StudentState.fromMap(json.decode(source));

  @override
  String toString() => 'StudentState(student: $student, isChange: $isChange, projectProposals: $projectProposals)';

  @override
  List<Object> get props => [student, isChange, projectProposals];
}
