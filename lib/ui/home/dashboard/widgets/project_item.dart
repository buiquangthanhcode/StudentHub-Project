import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:studenthub/constants/app_theme.dart';
import 'package:studenthub/constants/colors.dart';
import 'package:studenthub/core/show_modal_bottomSheet.dart';
import 'package:studenthub/models/common/project_model.dart';
import 'package:studenthub/models/common/project_proposal_modal.dart';
import 'package:studenthub/ui/home/dashboard/widgets/more_action_widget.dart';
import 'package:studenthub/utils/helper.dart';

class ProjectItem extends StatelessWidget {
  const ProjectItem({
    super.key,
    required this.theme,
    this.item,
    this.projectProposal,
  });

  final ThemeData theme;
  final Project? item;
  final ProjectProposal? projectProposal;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.push('/company_review',
            extra: {'item': item, 'projectProposal': projectProposal} as Map<String, dynamic>);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  item?.title ?? projectProposal?.project?.title ?? 'Title',
                  style: theme.textTheme.bodyMedium,
                ),
                const Spacer(),
                GestureDetector(
                  onTap: () {
                    showModalBottomSheetCustom(context,
                        headerBuilder: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  color: theme.colorScheme.grey!.withOpacity(0.4),
                                  borderRadius: BorderRadius.circular(50)),
                              padding: const EdgeInsets.all(3),
                              child: InkWell(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: Icon(
                                  Icons.close,
                                  size: 20,
                                  color: theme.colorScheme.grey,
                                ),
                              ),
                            ),
                          ],
                        ),
                        widgetBuilder: MoreActionWidget(
                          project: item ?? Project(),
                          // projectId: item.id!,
                        ));
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
              "Updated at ${formatIsoDateString(item?.updatedAt ?? projectProposal?.project?.updatedAt ?? '')}",
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.grey,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'Students are looking for',
              style: theme.textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.bold),
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
                      item?.description ?? projectProposal?.project?.description ?? 'Description',
                      style: theme.textTheme.bodyMedium!.copyWith(
                        fontSize: 14,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            Builder(builder: (context) {
              final data = [
                {"label": "Proposals", "total": item?.countProposals ?? projectProposal?.project?.countProposals ?? 0},
                {"label": "Messages", "total": item?.countMessages ?? projectProposal?.project?.countProposals ?? 0},
                {"label": "Hired", "total": item?.countHired ?? projectProposal?.project?.countProposals ?? 0},
              ];
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: data
                    .map(
                      (item) => Container(
                        width: MediaQuery.of(context).size.width / 4,
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                        decoration: BoxDecoration(
                          color: theme.colorScheme.grey!.withOpacity(0.08),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item['total'].toString(),
                              style: theme.textTheme.bodyMedium!.copyWith(color: Colors.black87),
                            ),
                            Text(
                              item['label'].toString(),
                              style: theme.textTheme.bodyMedium!.copyWith(color: primaryColor),
                            ),
                          ],
                        ),
                      ),
                    )
                    .toList(),
              );
            })
          ],
        ),
      ),
    );
  }
}
