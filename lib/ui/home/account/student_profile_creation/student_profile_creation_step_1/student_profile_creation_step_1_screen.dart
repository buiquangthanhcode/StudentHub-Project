import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:studenthub/blocs/student_bloc/student_bloc.dart';
import 'package:studenthub/blocs/student_bloc/student_event.dart';
import 'package:studenthub/blocs/student_bloc/student_state.dart';
import 'package:studenthub/constants/app_theme.dart';
import 'package:studenthub/core/show_modal_bottomSheet.dart';
import 'package:studenthub/core/dropdown_button_formfield.dart';
import 'package:studenthub/ui/home/account/student_profile_creation/widget/autocomplete_widget.dart';
import 'package:studenthub/ui/home/account/student_profile_creation/widget/create_education.dart';
import 'package:studenthub/ui/home/account/student_profile_creation/widget/create_language.dart';
import 'package:studenthub/ui/home/account/student_profile_creation/widget/education_item.dart';
import 'package:studenthub/ui/home/account/student_profile_creation/widget/language_item.dart';
import 'package:studenthub/ui/home/account/student_profile_creation/widget/skillset_item.dart';
import 'package:studenthub/widgets/emtyDataWidget.dart';

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

  @override
  void initState() {
    super.initState();
    context.read<StudentBloc>().add(GetAllTeckStackEvent(onSuccess: () {}));
    context.read<StudentBloc>().add(GetAllSkillSetEvent(onSuccess: () {}));
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndDocked,
      floatingActionButton: ElevatedButton(
        style: ElevatedButton.styleFrom(
          minimumSize: const Size(56, 56),
          shape: const CircleBorder(),
        ),
        onPressed: () {
          context.pushNamed('student_create_profile_step_02');
        },
        child: const Icon(Icons.arrow_forward),
      ),
      appBar: AppBar(
        centerTitle: false,
        titleSpacing: 0,
        title: Center(
          child: Text(
            "Welcome to StudentHub",
            style: theme.textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.bold,
              fontSize: 24,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
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
                      "Tell us about your self and you will be on your way connect with real-world project",
                      style: theme.textTheme.bodyMedium?.copyWith(
                        fontSize: 15,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text("TechStack",
                      style: theme.textTheme.bodyMedium?.copyWith(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      )),
                  DropDownFormFieldCustom(
                      name: "techstack",
                      data: state.teckstacks.map((e) => e.name ?? '').toList(),
                      onSaved: (value) {
                        selectedValue = value.toString();
                      },
                      hint: "Please selecte TechStack"),
                  Text("Skillset",
                      style: theme.textTheme.bodyMedium?.copyWith(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      )),
                  const SizedBox(
                    height: 10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Builder(builder: (context) {
                        if (state.skillset.isNotEmpty) {
                          return Wrap(
                            spacing: 6.0,
                            runSpacing: 6.0,
                            direction: Axis.horizontal,
                            children: state.skillset
                                .map((item) => SkillSetItem(
                                      theme: theme,
                                      item: item,
                                    ))
                                .where((element) =>
                                    element.item.isSelected == true)
                                .toList(),
                          );
                        }
                        return const SizedBox();
                      }),
                      const SizedBox(height: 10),
                      AutoCompleteWidget(
                        data: state.skillset.map((e) => e.name ?? '').toList(),
                      ),
                      const SizedBox(height: 10),
                      Column(
                        children: [
                          Row(
                            children: [
                              Text(
                                "Languages",
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
                              if (state.languages.isEmpty) {
                                return const EmptyDataWidget(
                                  mainTitle: '',
                                  subTitle: 'No data',
                                  widthImage: 150,
                                );
                              }
                              if (state.languages.isNotEmpty) {
                                return ListView.separated(
                                    shrinkWrap: true,
                                    itemBuilder: (context, index) {
                                      return LanguageItem(
                                        theme: theme,
                                        item: state.languages[index],
                                      );
                                    },
                                    separatorBuilder: (context, index) {
                                      return const SizedBox(
                                        height: 10,
                                      );
                                    },
                                    itemCount: state.languages.length);
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
                                "Education",
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
                                            const CreateEducationWidget());
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
                              if (state.edutcations.isEmpty) {
                                return const EmptyDataWidget(
                                  mainTitle: '',
                                  subTitle: 'No data',
                                  widthImage: 150,
                                );
                              }
                              if (state.edutcations.isNotEmpty) {
                                return ListView.separated(
                                    shrinkWrap: true,
                                    itemBuilder: (context, index) {
                                      return EducationItem(
                                        theme: theme,
                                        item: state.edutcations[index],
                                      );
                                    },
                                    separatorBuilder: (context, index) {
                                      return const SizedBox(
                                        height: 10,
                                      );
                                    },
                                    itemCount: state.edutcations.length);
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
    );
  }
}
