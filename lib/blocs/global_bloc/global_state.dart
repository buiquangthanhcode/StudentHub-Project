import 'package:equatable/equatable.dart';
import 'package:studenthub/models/student/student_create_profile/skillset_model.dart';
import 'package:studenthub/models/student/student_create_profile/tech_stack.dart';

class GlobalState extends Equatable {
  final List<SkillSet> dataSourceSkillSet;
  final List<TechStack> dataSourceTeckstacks;
  final bool isFirtTimeAccessApp;

  const GlobalState(
      {required this.dataSourceSkillSet, required this.dataSourceTeckstacks, required this.isFirtTimeAccessApp});
  @override
  List<Object?> get props => [dataSourceSkillSet, dataSourceTeckstacks, isFirtTimeAccessApp];

  GlobalState update({
    List<SkillSet>? dataSourceSkillSet,
    List<TechStack>? dataSourceTeckstacks,
    bool? isFirtTimeAccessApp,
  }) {
    return GlobalState(
      dataSourceSkillSet: dataSourceSkillSet ?? this.dataSourceSkillSet,
      dataSourceTeckstacks: dataSourceTeckstacks ?? this.dataSourceTeckstacks,
      isFirtTimeAccessApp: isFirtTimeAccessApp ?? this.isFirtTimeAccessApp,
    );
  }
}
