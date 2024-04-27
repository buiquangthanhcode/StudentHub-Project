import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:studenthub/blocs/student_bloc/student_bloc.dart';
import 'package:studenthub/constants/app_theme.dart';
import 'package:studenthub/core/show_modal_bottomSheet.dart';
import 'package:studenthub/models/student/student_create_profile/education_model.dart';
import 'package:studenthub/ui/home/account/student_profile_creation/widget/edit_education.dart';
import 'package:studenthub/widgets/dialog.dart';
import 'package:studenthub/widgets/snack_bar_config.dart';

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
              Row(
                children: [
                  const FaIcon(
                    FontAwesomeIcons.school,
                    size: 14,
                  ),
                  const SizedBox(width: 10),
                  Text(item.schoolName ?? ''),
                ],
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                '${item.startYear} - ${item.endYear}',
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
              showDialogCustom(
                context,
                image: 'lib/assets/images/delete.png',
                title: 'Are you sure you want to delete this education?',
                textButtom: 'Delete',
                subtitle: 'This action cannot be undone',
                onSave: () {
                  int userId = BlocProvider.of<StudentBloc>(context).state.student.id ?? 0;
                  List<Education> currentEducation =
                      BlocProvider.of<StudentBloc>(context).state.student.educations ?? [];

                  for (var element in currentEducation) {
                    if (element.id == item.id) {
                      currentEducation.remove(element);
                      break;
                    }
                  }
                  context.read<StudentBloc>().add(
                        UpdateEducationEvent(
                          userId: userId,
                          educations: currentEducation,
                          onSuccess: () {
                            SnackBarService.showSnackBar(content: "Delete Sucessfully", status: StatusSnackBar.success);
                            Navigator.pop(context);
                          },
                        ),
                      );
                },
              );
            },
            child: Container(
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: theme.colorScheme.grey!.withOpacity(0.08),
                shape: BoxShape.circle,
              ),
              child: const FaIcon(
                FontAwesomeIcons.xmark,
                size: 16,
                color: Colors.red,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
