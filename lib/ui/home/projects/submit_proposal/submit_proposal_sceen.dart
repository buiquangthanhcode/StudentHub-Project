import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:studenthub/blocs/student_bloc/student_bloc.dart';
import 'package:studenthub/blocs/student_bloc/student_event.dart';
import 'package:studenthub/constants/colors.dart';
import 'package:studenthub/constants/key_translator.dart';
import 'package:studenthub/data/dto/student/request_post_proposal.dart';
import 'package:studenthub/models/common/project_model.dart';
import 'package:studenthub/widgets/snack_bar_config.dart';

class SubmitProposalScreen extends StatefulWidget {
  const SubmitProposalScreen({super.key, required this.projectDetail});

  final Project projectDetail;

  @override
  State<SubmitProposalScreen> createState() => _SubmitProposalState();
}

class _SubmitProposalState extends State<SubmitProposalScreen> {
  final TextEditingController _controllerCoverLetter = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          // 'Submit Proposal',
          submitProposalTitleKey.tr(),
          style: theme.textTheme.headlineSmall!.copyWith(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Container(
          decoration: const BoxDecoration(
            color: Colors.white,
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10),
                Text(
                  // 'Cover letter',
                  coverLetterKey.tr(),
                  style: theme.textTheme.bodyMedium!
                      .copyWith(fontSize: 20, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 8),
                Text(
                  // 'Desribe why do you fit to the project',
                  coverLetterDescriptionKey.tr(),
                  style: theme.textTheme.bodyMedium!
                      .copyWith(fontWeight: FontWeight.w400),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: _controllerCoverLetter,
                  autofocus: true,
                  minLines:
                      6, // any number you need (It works as the rows for the textarea)
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          elevation: 0,
                          minimumSize: const Size(double.infinity, 56),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                            side: const BorderSide(
                                color: primaryColor, width: 2.0),
                          ),
                        ),
                        onPressed: () {},
                        child: Text(
                          // 'Cancel',
                          cancelBtnKey.tr(),
                          style: theme.textTheme.bodyMedium!.copyWith(
                              color: primaryColor, fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size(double.infinity, 56),
                        ),
                        onPressed: () {
                          final student = context.read<StudentBloc>().state;

                          RequestProposal requestProposal = RequestProposal(
                            projectId: widget.projectDetail.id.toString(),
                            studentId: student.student.id.toString(),
                            coverLetter: _controllerCoverLetter.text,
                            statusFlag: 0,
                            disableFlag: 1,
                          );
                          context.read<StudentBloc>().add(SubmitProposal(
                              requestProposal: requestProposal,
                              onSuccess: () {
                                SnackBarService.showSnackBar(
                                    // content: 'Submit successfully',
                                    content: submitSuccessMsgKey.tr(),
                                    status: StatusSnackBar.success);
                                context.read<StudentBloc>().add(
                                      GetAllProjectProposal(
                                        userId: student.student.id ?? 0,
                                        statusFlag: "1",
                                        onSuccess: () {},
                                      ),
                                    );
                                context.read<StudentBloc>().add(
                                      GetAllProjectProposal(
                                        userId: student.student.id ?? 0,
                                        statusFlag: "0",
                                        onSuccess: () {},
                                      ),
                                    );
                                context.push(
                                  '/home',
                                );
                              }));
                        },
                        child: Text(
                          // 'Submit Proposal',
                          submitProposalTitleKey.tr(),
                          style: theme.textTheme.bodyMedium!.copyWith(
                              color: Colors.white, fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          )),
    );
  }
}
