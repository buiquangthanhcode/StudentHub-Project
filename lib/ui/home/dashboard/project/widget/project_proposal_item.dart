import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:logger/logger.dart';
import 'package:studenthub/constants/app_theme.dart';
import 'package:studenthub/constants/colors.dart';
import 'package:studenthub/models/common/project_proposal_modal.dart';
import 'package:studenthub/utils/logger.dart';
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
  bool isPressHiredButton = false;

  @override
  Widget build(BuildContext context) {
    logger.d("PROPOSAL: ${widget.item.toString()}");

    return Container(
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
                padding: const EdgeInsets.all(10),
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
                  width: 36,
                  height: 36,
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
                    widget.item.student?.fullname ?? '4th year student',
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
              Text(
                widget.item.project?.title ?? 'Excellent',
                style: widget.theme.textTheme.bodyMedium!.copyWith(
                  color: Color.fromARGB(255, 231, 144, 5),
                  fontWeight: FontWeight.w600,
                ),
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
                            side: const BorderSide(
                                color: primaryColor, width: 2.0),
                          ),
                        ),
                        onPressed: () {
                          showDialogCustom(context,
                              title: 'Hide Offer',
                              textButtom: 'Hired',
                              subtitle:
                                  'Do you really want to hide this offer for student to do this project?',
                              onSave: () {
                            SnackBarService.showSnackBar(
                                content: "Hired Successfully",
                                status: StatusSnackBar.success);
                            context.pop();
                            setState(() {
                              isPressHiredButton = true;
                            });
                          });
                        },
                        child: Text(
                          isPressHiredButton ? 'Send offer' : "Hired",
                          style: widget.theme.textTheme.bodyMedium!.copyWith(
                            color: primaryColor,
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
                    // logger.d(
                    //     '${widget.item.student!.user?.fullname}\n${widget.item.studentId.toString()}\n${widget.projectId}');
                    context.pushNamed('chat_detail', queryParameters: {
                      'userName': widget.item.student!.user?.fullname ?? '',
                      'userId': widget.item.student!.userId.toString(),
                      'projectId': widget.projectId,
                    });
                  },
                  child: Text(
                    "Message",
                    style: widget.theme.textTheme.bodyMedium!.copyWith(
                      color: widget.theme.colorScheme.onPrimary,
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
