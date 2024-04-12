import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:studenthub/constants/app_theme.dart';
import 'package:studenthub/constants/colors.dart';
import 'package:studenthub/models/common/project_model.dart';

class ProjectItem extends StatefulWidget {
  const ProjectItem({
    super.key,
    required this.project,
    required this.paddingRight,
  });
  final Project project;
  final double paddingRight;

  @override
  State<ProjectItem> createState() => _ProjectItemState();
}

class _ProjectItemState extends State<ProjectItem> {
  bool? isSaved;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isSaved = false;
  }

  int differentDay(String dateString) {
    DateFormat format = DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'");
    DateTime ngayHienTai = DateTime.now();
    DateTime ngayDuocCungCap = format.parse(dateString);
    return ngayHienTai.difference(ngayDuocCungCap).inDays;
  }

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    var colorTheme = Theme.of(context).colorScheme;
    return GestureDetector(
      onTap: () {
        context.pushNamed('project_detail',
            queryParameters: {'id': widget.project.projectId.toString()});
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        padding: EdgeInsets.fromLTRB(0, 16, widget.paddingRight, 16),
        decoration: BoxDecoration(
            border: Border(
                bottom: BorderSide(width: 1, color: colorTheme.hintColor!))),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Created ${differentDay(widget.project.createdAt!)} days ago',
                        style: textTheme.bodySmall!
                            .copyWith(color: colorTheme.grey),
                      ),
                      Text(
                        widget.project.title ??
                            'Senior frontend developer (Fintech)',
                        style:
                            textTheme.bodySmall!.copyWith(color: primaryColor),
                      ),
                      Text(
                        'Time: 1-3 months, ${widget.project.numberOfStudents ?? '0'} students needed',
                        style: textTheme.bodySmall!.copyWith(
                          color: colorTheme.grey,
                        ),
                      ),
                    ],
                  ),
                ),
                InkWell(
                  onTap: () {
                    isSaved = !isSaved!;
                    setState(() {});
                  },
                  child: FaIcon(
                    isSaved!
                        ? FontAwesomeIcons.solidHeart
                        : FontAwesomeIcons.heart,
                    color: primaryColor,
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            Text(
              'Students are looking for',
              style: textTheme.bodySmall!,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(6),
                        child: FaIcon(
                          FontAwesomeIcons.solidCircle,
                          size: 6,
                        ),
                      ),
                      const SizedBox(
                        width: 4,
                      ),
                      Expanded(
                        child: Text(
                          'Clear expectation about your project or deliverables',
                          style: textTheme.bodySmall!,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Text('Proposal: Less than 5',
                style: textTheme.bodySmall!.copyWith(color: colorTheme.grey)),
          ],
        ),
      ),
    );
  }
}
