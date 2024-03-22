import 'package:studenthub/models/student_create_profile/skillset_model.dart';

class Project {
  String id;
  String name;
  String description;
  String startDate;
  String endDate;
  int duration;
  List<SkillSet> skills;
  Project({
    required this.id,
    required this.name,
    required this.description,
    required this.startDate,
    required this.endDate,
    required this.duration,
    required this.skills,
  });

  Project copyWith({
    String? id,
    String? name,
    String? description,
    String? startDate,
    String? endDate,
    int? duration,
    List<SkillSet>? skills,
  }) {
    return Project(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      duration: duration ?? this.duration,
      skills: skills ?? this.skills,
    );
  }
}
