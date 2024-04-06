import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:studenthub/blocs/student_bloc/student_bloc.dart';
import 'package:studenthub/constants/app_theme.dart';
import 'package:studenthub/core/show_modal_bottomSheet.dart';
import 'package:studenthub/models/student/student_create_profile/education_model.dart';
import 'package:studenthub/ui/home/account/student_profile_creation/widget/edit_education.dart';

import '../../../../../blocs/student_bloc/student_event.dart';

class EducationItem extends StatelessWidget {
  const EducationItem({
    super.key,
    required this.theme,
    required this.item,
  });

  final ThemeData theme;
  final Education item;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 242, 242, 242),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: theme.colorScheme.grey!.withOpacity(0.2),
        ),
      ),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(item.nameOfSchool ?? ''),
              const SizedBox(
                height: 5,
              ),
              Text(
                '${item.timeStart} - ${item.timeEnd}',
                style: theme.textTheme.bodyMedium!.copyWith(
                  color: theme.colorScheme.grey,
                  fontSize: 15,
                ),
              ),
            ],
          ),
          const Spacer(),
          InkWell(
            onTap: () {
              showModalBottomSheetCustom(context, widgetBuilder: EducationEdit(item: item));
            },
            child: FaIcon(
              FontAwesomeIcons.penToSquare,
              size: 16,
              color: theme.colorScheme.grey!,
            ),
          ),
          const SizedBox(width: 10),
          InkWell(
            onTap: () {
              context.read<StudentBloc>().add(
                    RemoveEducationEvent(education: item, onSuccess: () {}),
                  );
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
