import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:studenthub/blocs/auth_bloc/auth_bloc.dart';
import 'package:studenthub/blocs/auth_bloc/auth_event.dart';
import 'package:studenthub/blocs/auth_bloc/auth_state.dart';
import 'package:studenthub/blocs/global_bloc/global_bloc.dart';
import 'package:studenthub/blocs/global_bloc/global_event.dart';
import 'package:studenthub/blocs/student_bloc/student_bloc.dart';
import 'package:studenthub/blocs/student_bloc/student_event.dart';
import 'package:studenthub/blocs/student_bloc/student_state.dart';
import 'package:studenthub/constants/app_theme.dart';
import 'package:studenthub/constants/key_translator.dart';
import 'package:studenthub/core/show_modal_bottomSheet.dart';
import 'package:studenthub/core/dropdown_button_formfield.dart';
import 'package:studenthub/data/dto/student/request_update_profile_student.dart';
import 'package:studenthub/models/common/user_model.dart';
import 'package:studenthub/models/student/student_create_profile/skillset_model.dart';
import 'package:studenthub/models/student/student_create_profile/tech_stack.dart';
import 'package:studenthub/ui/home/account/student_profile_creation/widget/autocomplete_widget.dart';
import 'package:studenthub/ui/home/account/student_profile_creation/widget/create_education.dart';
import 'package:studenthub/ui/home/account/student_profile_creation/widget/create_language.dart';
import 'package:studenthub/ui/home/account/student_profile_creation/widget/education_item.dart';
import 'package:studenthub/ui/home/account/student_profile_creation/widget/language_item.dart';
import 'package:studenthub/ui/home/account/student_profile_creation/widget/skillset_item.dart';
import 'package:studenthub/utils/helper.dart';
import 'package:studenthub/widgets/emtyDataWidget.dart';
import 'package:studenthub/widgets/snack_bar_config.dart';

class StudentProfileCreationStep01Screen extends StatefulWidget {
  const StudentProfileCreationStep01Screen({super.key});

  @override
  State<StudentProfileCreationStep01Screen> createState() =>
      _StudentProfileCreationStep01State();
}

class _StudentProfileCreationStep01State
    extends State<StudentProfileCreationStep01Screen> {
  String? selectedValue;
  late TextEditingController textEditingController;
  late UserModel user;
  List<SkillSet> dataSourceSkillSets = [];
  List<TechStack> dataSourceTechStack = [];

  @override
  void initState() {
    super.initState();
    user = BlocProvider.of<AuthBloc>(context).state.userModel;
    context
        .read<GlobalBloc>()
        .add(GetAllTeckStackEventMetadata(onSuccess: (value) {
      setState(() {
        dataSourceTechStack = value;
      });
    }));
    context
        .read<GlobalBloc>()
        .add(GetAllSkillSetEventMetadata(onSuccess: (value) {
      setState(() {
        dataSourceSkillSets = value;
      });
    }));

    context.read<StudentBloc>().add(
        GetAllLanguageEvent(onSuccess: () {}, userId: user.student?.id ?? -1));
    context.read<StudentBloc>().add(
        GetAllEducationEvent(onSuccess: () {}, id: user.student?.id ?? -1));
    context.read<AuthBloc>().add(GetInformationEvent(
        onSuccess: () {},
        accessToken: user.token ?? '',
        currentContext: context));
  }

  void _handleChangeTechStack(value) {
    final currentUser = BlocProvider.of<AuthBloc>(context).state.userModel;
    if (currentUser.student == null) {
      RequestUpdateProfileStudent profileStudent =
          RequestUpdateProfileStudent(techStackId: value?.id ?? -1);
      context.read<StudentBloc>().add(PostProfileStudent(
          profileStudent: profileStudent,
          currentContext: context,
          onSuccess: (userModel) {},
          token: currentUser.token ?? ''));
    } else {
      RequestUpdateProfileStudent profileStudent = RequestUpdateProfileStudent(
          techStackId: value?.id ?? -1, userId: currentUser.student?.id ?? -1);
      context.read<StudentBloc>().add(UpdateProfileStudent(
          profileStudent: profileStudent,
          onSuccess: (userModel) {
            context.read<AuthBloc>().add(GetInformationEvent(
                onSuccess: () {},
                accessToken: user.token ?? '',
                currentContext: context));
          }));
    }
    context.read<AuthBloc>().add(GetInformationEvent(
        onSuccess: () {},
        accessToken: user.token ?? '',
        currentContext: context));
  }

  void _handleSelectedSkillSet(value) {
    List<SkillSet> data = List<SkillSet>.from(
        context.read<StudentBloc>().state.student.skillSets ?? []);
    data.add(getSkillSetByName(value, dataSourceSkillSets));
    int userId = BlocProvider.of<StudentBloc>(context).state.student.id ?? -1;
    RequestUpdateProfileStudent profileStudent = RequestUpdateProfileStudent(
        skillSets: data.map((e) => e.id.toString()).toList(),
        userId: userId ?? -1);
    context.read<StudentBloc>().add(
          UpdateProfileStudent(
              profileStudent: profileStudent, onSuccess: (userModel) {}),
        );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    AuthenState authSate = context.watch<AuthBloc>().state;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: theme.colorScheme.background,
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndDocked,
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 50.0),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            minimumSize: const Size(56, 56),
            shape: const CircleBorder(),
            backgroundColor: authSate.isAnonymus() ? null : null,
          ),
          onPressed: () {
            if (authSate.isAnonymus()) {
              SnackBarService.showSnackBar(
                  content: "Please update your pView Proposalsrofile",
                  status: StatusSnackBar.info);
            } else {
              context.pushNamed('student_create_profile_step_02');
            }
          },
          child: const Icon(Icons.arrow_forward),
        ),
      ),
      appBar: AppBar(
        centerTitle: false,
        titleSpacing: 0,
        title: Text(
          // user.student == null ? "Welcome to StudentHub" : "Edit Profile",
          user.student == null
              ? welcomeDialogMsg.tr()
              : editProfileTitleKey.tr(),
          style: theme.textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: BlocBuilder<StudentBloc, StudentState>(
              builder: (context, state) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 10),
                    Center(
                      child: Text(
                        // "Tell us about your self and you will be on your way connect with real-world project",
                        editProfileDescriptionKey.tr(),
                        style: theme.textTheme.bodyMedium?.copyWith(
                          fontSize: 15,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      // "TechStack",
                      techStackKey.tr(),
                      style: theme.textTheme.bodyMedium?.copyWith(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    DropDownFormFieldCustom<TechStack>(
                      name: "techstack",
                      data: removeDuplicates(dataSourceTechStack),
                      onChanged: _handleChangeTechStack,
                      initValue: state.student.techStack,
                      onSaved: (value) {
                        selectedValue = value.toString();
                      },
                      // hint: "Please selecte TechStack",
                      hint: selectTechStackKey.tr(),
                    ),
                    Text(
                      // "Skillset",
                      skillSetKey.tr(),
                      style: theme.textTheme.bodyMedium?.copyWith(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    // const SizedBox(
                    //   height: 10,
                    // ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Builder(builder: (context) {
                          if (state.student.skillSets?.isNotEmpty ?? false) {
                            return Wrap(
                              spacing: 2.0,
                              runSpacing: 2.0,
                              direction: Axis.horizontal,
                              children: state.student.skillSets!
                                  .map((item) => SkillSetItem(
                                        theme: theme,
                                        item: item,
                                      ))
                                  .toList(),
                            );
                          }
                          return const SizedBox();
                        }),
                        const SizedBox(height: 10),
                        AutoCompleteWidget(
                          data: dataSourceSkillSets
                              .map((e) => e.name ?? '')
                              .toList(),
                          onSelected: (value) {
                            _handleSelectedSkillSet(value);
                          },
                        ),
                        const SizedBox(height: 10),
                        Column(
                          children: [
                            Row(
                              children: [
                                Text(
                                  // "Languages",
                                  languagesKey.tr(),
                                  style: theme.textTheme.bodyMedium!.copyWith(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const Spacer(),
                                Container(
                                  margin: const EdgeInsets.only(right: 10),
                                  padding: const EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: theme.colorScheme.grey!),
                                    shape: BoxShape.circle,
                                  ),
                                  child: InkWell(
                                    onTap: () {
                                      showModalBottomSheetCustom(context,
                                          widgetBuilder:
                                              const CreateLanguageWidget());
                                    },
                                    child: FaIcon(
                                      FontAwesomeIcons.plus,
                                      size: 14,
                                      color: theme.colorScheme.grey,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            Builder(
                              builder: (context) {
                                if (state.student.languages?.isEmpty ?? true) {
                                  return EmptyDataWidget(
                                    mainTitle: '',
                                    // subTitle: 'No data',
                                    subTitle: noDataKey.tr(),
                                    widthImage: 150,
                                  );
                                }
                                if (state.student.languages!.isNotEmpty) {
                                  return ListView.separated(
                                      shrinkWrap: true,
                                      itemBuilder: (context, index) {
                                        return LanguageItem(
                                          theme: theme,
                                          item: state.student.languages![index],
                                        );
                                      },
                                      separatorBuilder: (context, index) {
                                        return const SizedBox(
                                          height: 10,
                                        );
                                      },
                                      itemCount:
                                          state.student.languages!.length);
                                }
                                return const SizedBox();
                              },
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Column(
                          children: [
                            Row(
                              children: [
                                Text(
                                  // "Education",
                                  educationKey.tr(),
                                  style: theme.textTheme.bodyMedium!.copyWith(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const Spacer(),
                                Container(
                                  margin: const EdgeInsets.only(right: 10),
                                  padding: const EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: theme.colorScheme.grey!),
                                    shape: BoxShape.circle,
                                  ),
                                  child: InkWell(
                                    onTap: () {
                                      showModalBottomSheetCustom(
                                        context,
                                        widgetBuilder:
                                            const CreateEducationWidget(),
                                        headerBuilder: Row(
                                          children: [
                                            Text(
                                              // "Create Education",
                                              createEducationTitleKey.tr(),
                                              style: theme.textTheme.bodyMedium
                                                  ?.copyWith(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 20,
                                              ),
                                            ),
                                            const Spacer(),
                                            // Container(
                                            //   decoration: BoxDecoration(
                                            //       color: theme.colorScheme.grey!
                                            //           .withOpacity(0.4),
                                            //       borderRadius:
                                            //           BorderRadius.circular(
                                            //               50)),
                                            //   padding: const EdgeInsets.all(3),
                                            //   child: InkWell(
                                            //     onTap: () {
                                            //       Navigator.pop(context);
                                            //     },
                                            //     child: Icon(
                                            //       Icons.close,
                                            //       color: theme.colorScheme.grey,
                                            //     ),
                                            //   ),
                                            // ),
                                            const Spacer(),
                                            Container(
                                              decoration: BoxDecoration(
                                                  color: theme.colorScheme.grey!
                                                      .withOpacity(0.4),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          50)),
                                              padding: const EdgeInsets.all(3),
                                              child: InkWell(
                                                onTap: () {
                                                  Navigator.pop(context);
                                                },
                                                child: Icon(
                                                  Icons.close,
                                                  color: theme.colorScheme.grey,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                    child: FaIcon(
                                      FontAwesomeIcons.plus,
                                      size: 14,
                                      color: theme.colorScheme.grey,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            Builder(
                              builder: (context) {
                                if (state.student.educations?.isEmpty ?? true) {
                                  return EmptyDataWidget(
                                    mainTitle: '',
                                    // subTitle: 'No data',
                                    subTitle: noDataKey.tr(),
                                    widthImage: 150,
                                  );
                                }
                                if (state.student.educations?.isNotEmpty ??
                                    false) {
                                  return ListView.separated(
                                      shrinkWrap: true,
                                      itemBuilder: (context, index) {
                                        return EducationItem(
                                          theme: theme,
                                          item:
                                              state.student.educations![index],
                                        );
                                      },
                                      separatorBuilder: (context, index) {
                                        return const SizedBox(
                                          height: 10,
                                        );
                                      },
                                      itemCount:
                                          state.student.educations!.length);
                                }
                                return const SizedBox();
                              },
                            ),
                          ],
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    )
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
