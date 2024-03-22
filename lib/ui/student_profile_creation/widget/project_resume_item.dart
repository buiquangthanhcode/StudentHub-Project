import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:studenthub/blocs/student_create_profile/student_create_profile_bloc.dart';
import 'package:studenthub/blocs/student_create_profile/student_create_profile_event.dart';
import 'package:studenthub/constants/app_theme.dart';
import 'package:studenthub/constants/colors.dart';
import 'package:studenthub/core/show_modal_bottomSheet.dart';
import 'package:studenthub/models/student_create_profile/project_model.dart';
import 'package:studenthub/ui/student_profile_creation/widget/edit_project_resume.dart';
import 'package:studenthub/utils/helper.dart';

class ProjectResumeItem extends StatelessWidget {
  const ProjectResumeItem({super.key, required this.item});

  final ProjectResume item;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Theme(
      data: ThemeData(
        dividerColor: Colors.transparent,
        unselectedWidgetColor: primaryColor,
        colorScheme: const ColorScheme.light(
          primary: Colors.black,
          onPrimary: Colors.black,
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: theme.colorScheme.grey!.withOpacity(0.2),
          ),
        ),
        child: ExpansionTile(
          tilePadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
          childrenPadding: const EdgeInsets.all(0),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              FaIcon(
                FontAwesomeIcons.tags,
                size: 18,
                color: theme.colorScheme.grey!,
              ),
              const SizedBox(width: 5),
              Text(
                item.name ?? '',
              ),
              const Spacer(),
              GestureDetector(
                child: FaIcon(
                  FontAwesomeIcons.penToSquare,
                  size: 18,
                  color: theme.colorScheme.grey!,
                ),
                onTap: () {
                  showModalBottomSheetCustom(context, widgetBuilder: EditProjectResumeItem(item: item));
                },
              ),
              const SizedBox(width: 10),
              GestureDetector(
                child: const FaIcon(
                  FontAwesomeIcons.xmark,
                  size: 18,
                  color: Colors.red,
                ),
                onTap: () {
                  context.read<StudentCreateProfileBloc>().add(
                        RemoveProjectEvents(project: item, onSuccess: () {}),
                      );
                },
              ),
              const SizedBox(width: 10),
            ],
          ),
          children: [
            Container(
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: theme.colorScheme.grey!.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const SizedBox(
                      height: 2,
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        children: [
                          FaIcon(
                            FontAwesomeIcons.calendar,
                            size: 18,
                            color: theme.colorScheme.grey!,
                          ),
                          const SizedBox(width: 7),
                          Text(
                            '${formatDateTime(stringToDateTime(item.startDate), format: 'MM/yyyy')} - ${formatDateTime(stringToDateTime(item.endDate), format: 'MM/yyyy')}',
                          ),
                          Builder(builder: (context) {
                            int duration = calculateMonthDifference(
                                stringToDateTime(item.startDate), stringToDateTime(item.endDate));
                            return duration != 0
                                ? Text(
                                    ', $duration  months',
                                  )
                                : const SizedBox();
                          }),
                        ],
                      )
                    ],
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Skillset',
                    style: theme.textTheme.bodyMedium,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Builder(builder: (context) {
                    if (item.skills?.isNotEmpty ?? false) {
                      return Wrap(
                        spacing: 6.0,
                        runSpacing: 6.0,
                        direction: Axis.horizontal,
                        children: item.skills!
                            .map((item) => Container(
                                  margin: const EdgeInsets.only(left: 20),
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
                                          style: theme.textTheme.bodyMedium?.copyWith(),
                                        ),
                                      ),
                                    ],
                                  ),
                                ))
                            .toList(),
                      );
                    }
                    return const SizedBox();
                  }),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      FaIcon(
                        FontAwesomeIcons.circleInfo,
                        size: 18,
                        color: theme.colorScheme.grey!,
                      ),
                      const SizedBox(width: 7),
                      Text(
                        'Description',
                        style: theme.textTheme.bodyMedium,
                      ),
                    ],
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 25),
                    child: Text(
                      item.description ?? '',
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: theme.colorScheme.grey,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
