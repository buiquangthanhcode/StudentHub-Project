import 'package:equatable/equatable.dart';
import 'package:studenthub/models/student/student_create_profile/skillset_model.dart';
import 'package:studenthub/models/student/student_create_profile/tech_stack.dart';

class GlobalState extends Equatable {
  final List<SkillSet> dataSourceSkillSet;
  final List<TechStack> dataSourceTeckstacks;

  const GlobalState(
      {required this.dataSourceSkillSet, required this.dataSourceTeckstacks});
  @override
  List<Object?> get props => [dataSourceSkillSet, dataSourceTeckstacks];

  GlobalState update({
    List<SkillSet>? dataSourceSkillSet,
    List<TechStack>? dataSourceTeckstacks,
  }) {
    return GlobalState(
      dataSourceSkillSet: dataSourceSkillSet ?? this.dataSourceSkillSet,
      dataSourceTeckstacks: dataSourceTeckstacks ?? this.dataSourceTeckstacks,
    );
  }
}
