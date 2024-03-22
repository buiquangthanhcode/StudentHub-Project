import 'dart:convert';

import 'package:studenthub/models/student_create_profile/skillset_model.dart';

class ProjectResume {
  String id;
  String name;
  String description;
  String startDate;
  String endDate;
  int duration;
  List<SkillSet> skills;
  ProjectResume({
    required this.id,
    required this.name,
    required this.description,
    required this.startDate,
    required this.endDate,
    required this.duration,
    required this.skills,
  });

  ProjectResume copyWith({
    String? id,
    String? name,
    String? description,
    String? startDate,
    String? endDate,
    int? duration,
    List<SkillSet>? skills,
  }) {
    return ProjectResume(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      duration: duration ?? this.duration,
      skills: skills ?? this.skills,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'id': id});
    result.addAll({'name': name});
    result.addAll({'description': description});
    result.addAll({'startDate': startDate});
    result.addAll({'endDate': endDate});
    result.addAll({'duration': duration});
    result.addAll({'skills': skills.map((x) => x.toMap()).toList()});

    return result;
  }

  factory ProjectResume.fromMap(Map<String, dynamic> map) {
    return ProjectResume(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      description: map['description'] ?? '',
      startDate: map['startDate'] ?? '',
      endDate: map['endDate'] ?? '',
      duration: map['duration']?.toInt() ?? 0,
      skills: List<SkillSet>.from(map['skills']?.map((x) => SkillSet.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory ProjectResume.fromJson(String source) => ProjectResume.fromMap(json.decode(source));
}
