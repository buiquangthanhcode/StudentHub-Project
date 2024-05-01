import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:studenthub/blocs/auth_bloc/auth_bloc.dart';
import 'package:studenthub/blocs/auth_bloc/auth_state.dart';
import 'package:studenthub/constants/app_theme.dart';
import 'package:studenthub/constants/colors.dart';
import 'package:studenthub/constants/key_translator.dart';
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
    AuthenState authState = context.read<AuthBloc>().state;

    return InkWell(
      onTap: () {
        if (authState.currentRole == UserRole.company) {
          context.push('/project_company_detail',
              extra: {'item': item, 'projectProposal': projectProposal}
                  as Map<String, dynamic>);
        } else {
          context.push('/project_student_detail',
              extra: {'item': item, 'projectProposal': projectProposal}
                  as Map<String, dynamic>);
        }
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
                    showModalBottomSheet(
                      context: context,
                      backgroundColor: Colors.transparent,
                      builder: (context) {
                        return Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          height: authState.currentRole == UserRole.company
                              ? MediaQuery.of(context).size.height * 0.6
                              : MediaQuery.of(context).size.height * 0.2,
                          decoration: BoxDecoration(
                            color: theme.colorScheme.background,
                            borderRadius: const BorderRadius.vertical(
                              top: Radius.circular(30),
                            ),
                            border: Border.all(
                              color: theme.colorScheme.grey!.withOpacity(0.2),
                              width: 2,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: theme.colorScheme.grey!.withOpacity(0.2),
                                blurRadius: 10,
                                spreadRadius: 5,
                              ),
                            ],
                          ),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                        color: theme.colorScheme.grey!
                                            .withOpacity(0.4),
                                        borderRadius:
                                            BorderRadius.circular(50)),
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
                              MoreActionWidget(
                                project: item ??
                                    projectProposal?.project ??
                                    Project(),
                                // projectId: item.id!,
                              ),
                            ],
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
              // "Updated at ${formatIsoDateString(item?.updatedAt ?? projectProposal?.project?.updatedAt ?? '')}",
              // "Updated at ${formatIsoDateString(item?.updatedAt ?? projectProposal?.project?.updatedAt ?? '')}",
              updatedTimeProjectReviewKey.tr(namedArgs: {
                "value":
                    formatIsoDateString(item?.updatedAt ?? projectProposal?.project?.updatedAt ?? '')
              }),
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.grey,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              jobDescriptionExampleKey.tr(),
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
                      item?.description ??
                          projectProposal?.project?.description ??
                          // 'Description',
                          descriptionPlaceHolderKey.tr(),
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
                {
                  "label": proposalsProjectReviewKey.tr(),
                  "total": item?.countProposals ??
                      projectProposal?.project?.countProposals ??
                      0
                },
                {
                  "label": messagesProjectReviewKey.tr(),
                  "total": item?.countMessages ??
                      projectProposal?.project?.countProposals ??
                      0
                },
                {
                  "label": hiredProjectReviewKey.tr(),
                  "total": item?.countHired ??
                      projectProposal?.project?.countProposals ??
                      0
                },
              ];
              return Row(
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
                              item['total'].toString(),
                              style: theme.textTheme.bodyMedium!
                                  .copyWith(color: Colors.black87),
                            ),
                            Text(
                              item['label'].toString(),
                              style: theme.textTheme.bodyMedium!
                                  .copyWith(color: primaryColor),
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
