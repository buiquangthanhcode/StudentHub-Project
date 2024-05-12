import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:studenthub/blocs/global_bloc/global_bloc.dart';
import 'package:studenthub/blocs/global_bloc/global_event.dart';
import 'package:studenthub/constants/app_theme.dart';
import 'package:studenthub/constants/colors.dart';
import 'package:studenthub/constants/key_translator.dart';
import 'package:studenthub/core/dropdown_button_formfield.dart';
import 'package:studenthub/models/common/project_proposal_modal.dart';
import 'package:studenthub/models/student/student_create_profile/education_model.dart';
import 'package:studenthub/models/student/student_create_profile/tech_stack.dart';
import 'package:studenthub/ui/home/account/student_profile_creation/widget/education_item.dart';
import 'package:studenthub/utils/helper.dart';
import 'package:studenthub/utils/logger.dart';
import 'package:studenthub/widgets/emtyDataWidget.dart';

class StudentDetailScreen extends StatefulWidget {
  const StudentDetailScreen({super.key, required this.item});

  final ProjectProposal item;

  @override
  State<StudentDetailScreen> createState() => _StudentDetailScreenState();
}

class _StudentDetailScreenState extends State<StudentDetailScreen> {
  List<TechStack> dataSourceTechStack = [];
  String excel_path = 'lib/assets/images/icons8-excel-48.png';
  String image_path = 'lib/assets/images/icons8-image-48.png';
  String pdf_path = 'lib/assets/images/icons8-pdf-48.png';

  @override
  void initState() {
    super.initState();
    context.read<GlobalBloc>().add(GetAllTeckStackEventMetadata(onSuccess: (value) {
      setState(() {
        dataSourceTechStack = value;
      });
    }));
  }

  @override
  Widget build(BuildContext context) {
    logger.d(widget.item.toMap());
    final theme = Theme.of(context);

    final typeResume = getLastSubstringAfterDot(widget.item.student?.resume ?? '');
    final typeTranscript = getLastSubstringAfterDot(widget.item.student?.transcript ?? '');
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Student Detail",
            style: theme.textTheme.headlineSmall!.copyWith(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          decoration: const BoxDecoration(
            color: Colors.white,
          ),
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
                        color: theme.colorScheme.grey!.withOpacity(0.2),
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
                        backgroundImage: AssetImage('lib/assets/images/circle_avatar.png'),
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
                        style: theme.textTheme.bodyMedium,
                      ),
                      Text(
                        // widget.item.student?.fullname ?? '4th year student',
                        widget.item.student?.fullname ?? fourthYearStudentKey.tr(),
                        style: theme.textTheme.bodyMedium,
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
                    style: theme.textTheme.bodyMedium!.copyWith(
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
                        style: theme.textTheme.bodyMedium!.copyWith(
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
                style: theme.textTheme.bodyMedium,
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                // "TechStack",
                techStackKey.tr(),
                style: theme.textTheme.bodyMedium?.copyWith(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
              IgnorePointer(
                child: DropDownFormFieldCustom<TechStack>(
                  name: "techstack",
                  data: removeDuplicates(dataSourceTechStack),
                  onChanged: (value) {},
                  initValue: widget.item.student?.techStack,
                  hint: selectTechStackKey.tr(),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                // "Education",
                educationKey.tr(),
                style: theme.textTheme.bodyMedium!.copyWith(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Builder(
                builder: (context) {
                  if (widget.item.student?.educations?.isEmpty ?? true) {
                    return EmptyDataWidget(
                      mainTitle: '',
                      // subTitle: 'No data',
                      subTitle: noDataKey.tr(),
                      widthImage: 150,
                    );
                  }
                  if (widget.item.student?.educations?.isNotEmpty ?? false) {
                    return ListView.separated(
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return EducationItem(
                            theme: theme,
                            item: widget.item.student?.educations![index] ?? Education(),
                          );
                        },
                        separatorBuilder: (context, index) {
                          return const SizedBox(
                            height: 10,
                          );
                        },
                        itemCount: widget.item.student?.educations!.length ?? 0);
                  }
                  return const SizedBox();
                },
              ),
              const SizedBox(
                height: 10,
              ),
              Visibility(
                visible: widget.item.student?.resume != null,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      // "Resume",
                      resumeCVKey.tr().replaceAll("(*)", ""),
                      style: theme.textTheme.bodyMedium?.copyWith(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.7,
                      margin: const EdgeInsets.only(right: 10),
                      padding: const EdgeInsets.fromLTRB(15, 8, 0, 8),
                      decoration: const BoxDecoration(
                        color: Color(0xffF6F7F9),
                        borderRadius: BorderRadius.all(
                          Radius.circular(6),
                        ),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10)),
                            child: Image.asset(
                              typeResume == 'png' || typeResume == 'jpg'
                                  ? image_path
                                  : typeResume == 'pdf'
                                      ? pdf_path
                                      : excel_path,
                              scale: 1.8,
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  widget.item.student?.resume ?? '',
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
                                ),
                                const SizedBox(
                                  height: 4,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Visibility(
                visible: widget.item.student?.transcript != null,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      // "Resume",
                      transcriptKey.tr().replaceAll("(*)", ""),
                      style: theme.textTheme.bodyMedium?.copyWith(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.7,
                      margin: const EdgeInsets.only(right: 10),
                      padding: const EdgeInsets.fromLTRB(15, 8, 0, 8),
                      decoration: const BoxDecoration(
                        color: Color(0xffF6F7F9),
                        borderRadius: BorderRadius.all(
                          Radius.circular(6),
                        ),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10)),
                            child: Image.asset(
                              typeTranscript == 'png' || typeTranscript == 'jpg'
                                  ? image_path
                                  : typeTranscript == 'pdf'
                                      ? pdf_path
                                      : excel_path,
                              scale: 1.8,
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  widget.item.student?.transcript ?? '',
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
                                ),
                                const SizedBox(
                                  height: 4,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
