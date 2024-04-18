import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:studenthub/blocs/auth_bloc/auth_bloc.dart';
import 'package:studenthub/blocs/auth_bloc/auth_event.dart';
import 'package:studenthub/blocs/global_bloc/global_bloc.dart';
import 'package:studenthub/blocs/student_bloc/student_bloc.dart';
import 'package:studenthub/blocs/student_bloc/student_event.dart';
import 'package:studenthub/data/dto/student/request_update_profile_student.dart';
import 'package:studenthub/models/common/user_model.dart';
import 'package:studenthub/models/student/student_create_profile/skillset_model.dart';
import 'package:studenthub/utils/helper.dart';

class SkillSetItem extends StatelessWidget {
  const SkillSetItem({
    super.key,
    required this.theme,
    required this.item,
  });

  final ThemeData theme;
  final SkillSet item;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(40),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Center(
            child: Text(
              item.name ?? '',
              style: theme.textTheme.bodyMedium!.copyWith(
                fontSize: 15,
              ),
            ),
          ),
          const SizedBox(width: 10),
          InkWell(
            onTap: () {
              final currentStudent = context.read<StudentBloc>().state.student;
              List<SkillSet> data = List<SkillSet>.from(currentStudent.skillSets ?? []);
              List<SkillSet> dataSource = List<SkillSet>.from(context.read<GlobalBloc>().state.dataSourceSkillSet);
              data.remove(getSkillSetByName(item.name ?? '', dataSource));
              RequestUpdateProfileStudent profileStudent = RequestUpdateProfileStudent(
                  skillSets: data.map((e) => e.id.toString()).toList(), userId: currentStudent.id ?? -1);
              context
                  .read<StudentBloc>()
                  .add(UpdateProfileStudent(profileStudent: profileStudent, onSuccess: (userModel) {}));
            },
            child: const FaIcon(
              FontAwesomeIcons.xmark,
              size: 16,
              color: Colors.red,
            ),
          ),
        ],
      ),
    );
  }
}
