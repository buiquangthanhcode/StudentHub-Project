import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:studenthub/blocs/student_create_profile/student_create_profile_bloc.dart';
import 'package:studenthub/blocs/student_create_profile/student_create_profile_state.dart';
import 'package:studenthub/constants/app_theme.dart';
import 'package:studenthub/core/show_modal_bottomSheet.dart';
import 'package:studenthub/core/dropdown_button_formfield.dart';
import 'package:studenthub/ui/student_profile_creation/data/student_data_creation.dart';
import 'package:studenthub/ui/student_profile_creation/widget/autocomplete_widget.dart';
import 'package:studenthub/ui/student_profile_creation/widget/create_education.dart';
import 'package:studenthub/ui/student_profile_creation/widget/create_language.dart';
import 'package:studenthub/ui/student_profile_creation/widget/education_item.dart';
import 'package:studenthub/ui/student_profile_creation/widget/language_item.dart';
import 'package:studenthub/ui/student_profile_creation/widget/skillset_item.dart';
import 'package:studenthub/widgets/emtyDataWidget.dart';

class StudentProfileCreationStep01Screen extends StatefulWidget {
  const StudentProfileCreationStep01Screen({super.key});

  @override
  State<StudentProfileCreationStep01Screen> createState() => _StudentProfileCreationStep01State();
}

class _StudentProfileCreationStep01State extends State<StudentProfileCreationStep01Screen> {
  String? selectedValue;
  late TextEditingController textEditingController;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      resizeToAvoidBottomInset: true,
      floatingActionButton: ElevatedButton(
        style: ElevatedButton.styleFrom(
          elevation: 0,
          minimumSize: const Size(35, 25),
        ),
        onPressed: () {
          context.push('/student_create_profile/step_02');
        },
        child: Text(
          "Next",
          style: theme.textTheme.bodyMedium!.copyWith(
            color: theme.colorScheme.onPrimary,
          ),
        ),
      ),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            context.pop();
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  "Welcome to StudentHub",
                  style: theme.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
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
                  data: items,
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
              BlocBuilder<StudentCreateProfileBloc, StudentCreateProfileState>(
                builder: (context, state) {
                  return Column(
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
                                .toList(),
                          );
                        }
                        return const SizedBox();
                      }),
                      const SizedBox(height: 10),
                      const AutoCompleteWidget(),
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
                                  border: Border.all(color: theme.colorScheme.grey!),
                                  shape: BoxShape.circle,
                                ),
                                child: InkWell(
                                  onTap: () {
                                    showModalBottomSheetCustom(context, widgetBuilder: const CreateLanguageWidget());
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
                                  border: Border.all(color: theme.colorScheme.grey!),
                                  shape: BoxShape.circle,
                                ),
                                child: InkWell(
                                  onTap: () {
                                    showModalBottomSheetCustom(context, widgetBuilder: const CreateEducationWidget());
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
                  );
                },
              ),
              const SizedBox(
                height: 20,
              )
            ],
          ),
        ),
      ),
    );
  }
}
