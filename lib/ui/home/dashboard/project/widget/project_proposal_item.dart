import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:studenthub/blocs/company_bloc/company_bloc.dart';
import 'package:studenthub/blocs/company_bloc/company_event.dart';
import 'package:studenthub/constants/app_theme.dart';
import 'package:studenthub/constants/colors.dart';
import 'package:studenthub/constants/key_translator.dart';
import 'package:studenthub/models/common/project_proposal_modal.dart';
import 'package:studenthub/widgets/dialog.dart';
import 'package:studenthub/widgets/snack_bar_config.dart';

class ProposalItem extends StatefulWidget {
  const ProposalItem(
      {super.key,
      required this.theme,
      required this.item,
      this.activeSentButton,
      required this.projectId});

  final ThemeData theme;
  final ProjectProposal item;
  final bool? activeSentButton;
  final String projectId;

  @override
  State<ProposalItem> createState() => _ProposalItemState();
}

class _ProposalItemState extends State<ProposalItem> {
  bool isPressSentButton = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.push('/student_detail', extra: widget.item);
      },
      behavior: HitTestBehavior.opaque,
      child: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Container(
                  height: 70,
                  clipBehavior: Clip.none,
                  width: 70,
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: widget.theme.colorScheme.grey!.withOpacity(0.2),
                      width: 2,
                    ),
                  ),
                  // child: Image.network(
                  //   item['avatar'],
                  //   fit: BoxFit.cover,
                  // ),
                  child: const SizedBox(
                    width: 30,
                    height: 30,
                    child: CircleAvatar(
                      backgroundImage:
                          AssetImage('lib/assets/images/circle_avatar.png'),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.item.student!.user?.fullname ?? '',
                      style: widget.theme.textTheme.bodyMedium,
                    ),
                    Text(
                      // widget.item.student?.fullname ?? '4th year student',
                      widget.item.student?.fullname ??
                          fourthYearStudentKey.tr(),
                      style: widget.theme.textTheme.bodyMedium,
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Text(
                  widget.item.student!.techStack?.name ?? '',
                  style: widget.theme.textTheme.bodyMedium!.copyWith(
                    color: primaryColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const Spacer(),
                Row(
                  children: [
                    Text(
                      // widget.item.project?.title ?? 'Excellent',
                      widget.item.project?.title ?? excellentRankedKey.tr(),
                      style: widget.theme.textTheme.bodyMedium!.copyWith(
                        color: const Color.fromARGB(255, 231, 144, 5),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              widget.item.coverLetter ?? '',
              style: widget.theme.textTheme.bodyMedium,
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                widget.activeSentButton ?? true
                    ? Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            elevation: 0,
                            minimumSize: const Size(double.infinity, 35),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                              // side: const BorderSide(
                              //     color: primaryColor, width: 2.0),
                              side: BorderSide(
                                  color: isPressSentButton
                                      ? Colors.green.shade600
                                      : primaryColor,
                                  width: 2.0),
                            ),
                          ),
                          onPressed: () {
                            showDialogCustom(context,
                                title: sendOfferBtnKey.tr(),
                                // textButtom: 'Send',
                                // subtitle:
                                //     'Do you really want too send this offer for student to do this project?',
                                textButtom: sendOfferBtnKey.tr(),
                                subtitle: sendOfferConfirmMsgKey.tr(),
                                onSave: () {
                              context
                                  .read<CompanyBloc>()
                                  .add(SetEventActionToStudent(
                                    proposalId: widget.item.id ?? 0,
                                    statusFlag: 2,
                                    onSuccess: () {
                                      SnackBarService.showSnackBar(
                                          content: "Sent Successfully",
                                          status: StatusSnackBar.success);
                                      context.pop();
                                      setState(() {
                                        isPressSentButton = true;
                                      });
                                    },
                                  ));
                            });
                          },
                          child: Text(
                            (isPressSentButton || widget.item.statusFlag == 2)
                                ? "Đã gửi"
                                : sendOfferBtnKey.tr(),
                            style: widget.theme.textTheme.bodyMedium!.copyWith(
                              color: isPressSentButton
                                  ? Colors.green.shade600
                                  : primaryColor,
                            ),
                          ),
                        ),
                      )
                    : const SizedBox(),
                widget.activeSentButton ?? true
                    ? const SizedBox(
                        width: 10,
                      )
                    : const SizedBox(),
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                      minimumSize: const Size(double.infinity, 35),
                    ),
                    onPressed: () {
                      context.pushNamed('chat_detail', queryParameters: {
                        'userName': widget.item.student!.user?.fullname ?? '',
                        'userId': widget.item.student!.userId.toString(),
                        'projectId': widget.projectId,
                        'projectProposalId': (widget.item.id ?? -1).toString(),
                      });
                    },
                    child: Text(
                      messageBtnKey.tr(),
                      style: widget.theme.textTheme.bodyMedium!.copyWith(
                        // color: widget.theme.colorScheme.onPrimary,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
