import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:studenthub/blocs/student_create_profile/student_create_profile_bloc.dart';
import 'package:studenthub/blocs/student_create_profile/student_create_profile_event.dart';
import 'package:studenthub/models/student_create_profile/skillset_model.dart';

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
      padding: const EdgeInsets.symmetric(horizontal: 20),
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
              context.read<StudentCreateProfileBloc>().add(RemoveSkillSetEvent(item));
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
