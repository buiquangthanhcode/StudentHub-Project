import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:studenthub/constants/app_theme.dart';
import 'package:studenthub/constants/colors.dart';
import 'package:studenthub/core/show_modal_bottomSheet.dart';
import 'package:studenthub/ui/home/dashboard/data/data_count.dart';
import 'package:studenthub/ui/home/dashboard/widget/more_action_widget.dart';

class ProjectArchivedTab extends StatefulWidget {
  const ProjectArchivedTab({super.key});

  @override
  State<ProjectArchivedTab> createState() => _ProjectArchivedTabState();
}

class _ProjectArchivedTabState extends State<ProjectArchivedTab> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      margin: const EdgeInsets.only(top: 20),
      child: Center(
          child: ListView.separated(
        itemCount: 10,
        itemBuilder: (context, index) {
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      'Senior Frontend Developer',
                      style: theme.textTheme.bodyMedium,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      '(${'FinTech'})',
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: primaryColor,
                      ),
                    ),
                    const Spacer(),
                    GestureDetector(
                      onTap: () {
                        showModalBottomSheetCustom(context,
                            widgetBuilder: const MoreActionWidget());
                      },
                      child: Container(
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color: theme.colorScheme.grey!.withOpacity(0.08),
                          shape: BoxShape.circle,
                        ),
                        child: FaIcon(
                          FontAwesomeIcons.ellipsis,
                          size: 18,
                          color: theme.colorScheme.grey!,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 2),
                Text(
                  'Created 3 days ago',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.grey,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  'Student are looking for',
                  style: theme.textTheme.bodyMedium!
                      .copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.fromLTRB(6, 9, 6, 6),
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
                          style: theme.textTheme.bodyMedium!.copyWith(
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: data
                      .map(
                        (item) => Container(
                          width: MediaQuery.of(context).size.width / 4,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          decoration: BoxDecoration(
                            color: theme.colorScheme.grey!.withOpacity(0.08),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item['total'] ?? '',
                                style: theme.textTheme.bodyMedium!
                                    .copyWith(color: Colors.black87),
                              ),
                              Text(
                                item['label'] ?? '',
                                style: theme.textTheme.bodyMedium!
                                    .copyWith(color: primaryColor),
                              ),
                            ],
                          ),
                        ),
                      )
                      .toList(),
                ),
              ],
            ),
          );
        },
        separatorBuilder: (context, index) {
          return const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            child: Divider(),
          );
        },
      )),
    );
  }
}
