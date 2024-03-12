import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:studenthub/blocs/student_create_profile/student_create_profile_bloc.dart';
import 'package:studenthub/blocs/student_create_profile/student_create_profile_event.dart';
import 'package:studenthub/blocs/student_create_profile/student_create_profile_state.dart';
import 'package:studenthub/constants/app_theme.dart';
import 'package:studenthub/models/student_create_profile/education_model.dart';
import 'package:studenthub/models/student_create_profile/language_model.dart';
import 'package:studenthub/models/student_create_profile/skillset_model.dart';
import 'package:studenthub/ui/student_profile_creation/widget/dropdown_button_formfield.dart';
import 'package:studenthub/utils/logger.dart';

class StudentProfileCreationStep01 extends StatefulWidget {
  const StudentProfileCreationStep01({super.key});

  @override
  State<StudentProfileCreationStep01> createState() => _StudentProfileCreationStep01State();
}

class _StudentProfileCreationStep01State extends State<StudentProfileCreationStep01> {
  static const List<String> skillSetList = <String>[
    'NodeJS',
    'C++',
    'Python',
    'Java',
    'React',
    'Angular',
    'Vue',
    'Django',
    'Flask',
    'Express',
    'Spring',
    'Laravel',
    'ASP.NET',
    'PHP',
    'Go',
    'Swift',
    'Kotlin',
    "Objective-C",
    'Flutter',
    'Xamarin',
    'Ionic',
  ];
  final List<String> items = [
    'Fullstack Engineering',
    'Frontend Engineering',
    'Backend Engineering',
    'Mobile Engineering',
    'DevOps',
    'Data Science',
    'Machine Learning',
    'Artificial Intelligence',
    'Cyber Security',
    'Game Development',
    'Cloud Computing',
    'Blockchain',
    'Embedded Systems',
    'AR/VR',
    'IoT',
    'Robotics',
    'Big Data',
    'Web Development',
  ];
  final List<String> language = [
    'English',
    'French',
    'Spanish',
    'German',
    'Italian',
    'Portuguese',
    'Dutch',
    'Russian',
    'Vietnamese',
  ];
  final List<String> levelLanguage = [
    'Native',
    'Bilingal',
  ];
  String? selectedValue;
  String? selectedValueValue;
  String? selectedValueLevel;
  late TextEditingController textEditingController;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
        appBar: AppBar(automaticallyImplyLeading: false, title: const SizedBox()),
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
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
                    )),
                DropDownButtonCustom(
                    data: items,
                    onSaved: (value) {
                      selectedValue = value.toString();
                    },
                    hint: "Please selecte TechStack"),
                Text("Skillset",
                    style: theme.textTheme.bodyMedium?.copyWith(
                      fontSize: 15,
                    )),
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
                                  .map((item) => Container(
                                        padding: const EdgeInsets.symmetric(horizontal: 10),
                                        decoration: BoxDecoration(
                                          border: Border.all(color: Colors.grey),
                                          borderRadius: BorderRadius.circular(40),
                                        ),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Center(
                                              child: Text(
                                                item.name,
                                                style: theme.textTheme.bodyMedium?.copyWith(
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                            const SizedBox(width: 10),
                                            InkWell(
                                              onTap: () {
                                                context.read<StudentCreateProfileBloc>().add(RemoveSkillSetEvent(item));
                                              },
                                              child: const FaIcon(
                                                FontAwesomeIcons.xmark,
                                                size: 16,
                                                color: Colors.red,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ))
                                  .toList(),
                            );
                          }
                          return const SizedBox();
                        }),
                        const SizedBox(height: 10),
                        Autocomplete<String>(
                          displayStringForOption: (option) {
                            return option;
                          },
                          fieldViewBuilder: (context, fieldTextEditingController, focusNode, onFieldSubmitted) {
                            textEditingController = fieldTextEditingController;
                            return TextField(
                              controller: fieldTextEditingController,
                              focusNode: focusNode,
                              decoration: const InputDecoration(
                                hintText: 'Enter your skill',
                                hintStyle: TextStyle(fontSize: 16),
                                border: OutlineInputBorder(),
                              ),
                            );
                          },
                          optionsBuilder: (TextEditingValue skillsetTextEditController) {
                            if (skillsetTextEditController.text == '') {
                              return const Iterable<String>.empty();
                            }
                            return skillSetList.where((String option) {
                              return option.toLowerCase().contains(skillsetTextEditController.text);
                            });
                          },
                          // when user click on the suggested
                          onSelected: (String value) {
                            context
                                .read<StudentCreateProfileBloc>()
                                .add(AddSkillSetEvent(SkillSet(name: value, isSelected: false)));
                            textEditingController.text = "";
                          },
                        ),
                        const SizedBox(height: 10),
                        Column(
                          children: [
                            Row(
                              children: [
                                Text(
                                  "Languages",
                                  style: theme.textTheme.bodyMedium,
                                ),
                                const Spacer(),
                                Container(
                                  margin: const EdgeInsets.only(right: 10),
                                  padding: const EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                    border: Border.all(color: theme.colorScheme.grey!),
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                  child: InkWell(
                                    onTap: () {
                                      context.read<StudentCreateProfileBloc>().add(
                                          AddLanguageEvent(Language(name: "English", level: 'Native or Bilingal')));
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
                                if (state.languages.isNotEmpty) {
                                  return ListView.separated(
                                      shrinkWrap: true,
                                      itemBuilder: (context, index) {
                                        return Container(
                                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                                          decoration: BoxDecoration(
                                            color: const Color.fromARGB(255, 242, 242, 242),
                                            borderRadius: BorderRadius.circular(10),
                                            border: Border.all(
                                              color: theme.colorScheme.grey!,
                                            ),
                                          ),
                                          child: Row(
                                            children: [
                                              Text('${state.languages[index].name}: ${state.languages[index].level}'),
                                              const Spacer(),
                                              InkWell(
                                                onTap: () {
                                                  // context
                                                  //     .read<StudentCreateProfileBloc>()
                                                  //     .add(UpdateLanguageEvent(state.languages[index]));

                                                  showModalBottomSheet(
                                                      context: context,
                                                      builder: (ctx) => Container(
                                                            decoration: BoxDecoration(
                                                              color: theme.colorScheme.surface,
                                                              borderRadius: const BorderRadius.only(
                                                                topLeft: Radius.circular(20),
                                                                topRight: Radius.circular(20),
                                                              ),
                                                            ),
                                                            padding: const EdgeInsets.all(20),
                                                            width: double.infinity,
                                                            child: Column(
                                                              children: [
                                                                Center(
                                                                  child: Container(
                                                                    width: 80,
                                                                    height: 5,
                                                                    decoration: BoxDecoration(
                                                                      color: theme.colorScheme.grey,
                                                                      borderRadius: BorderRadius.circular(50),
                                                                    ),
                                                                  ),
                                                                ),
                                                                Center(
                                                                  child: Text(
                                                                    "Edit Language",
                                                                    style: theme.textTheme.bodyMedium?.copyWith(
                                                                      fontWeight: FontWeight.bold,
                                                                      fontSize: 20,
                                                                    ),
                                                                  ),
                                                                ),
                                                                DropDownButtonCustom(
                                                                  data: language,
                                                                  onChanged: (value) {},
                                                                  onSelected: (value) {},
                                                                  onSaved: (value) {
                                                                    selectedValueValue = value.toString();
                                                                  },
                                                                  hint: "Please selecte Language",
                                                                ),
                                                                DropDownButtonCustom(
                                                                  data: levelLanguage,
                                                                  onChanged: (value) {},
                                                                  onSelected: (value) {},
                                                                  onSaved: (value) {
                                                                    selectedValueLevel = value.toString();
                                                                  },
                                                                  hint: "Please selecte level",
                                                                ),
                                                                const SizedBox(height: 10),
                                                                ElevatedButton(
                                                                  style: ElevatedButton.styleFrom(
                                                                    elevation: 0,
                                                                    minimumSize: const Size(double.infinity, 56),
                                                                  ),
                                                                  onPressed: () {
                                                                    context.read<StudentCreateProfileBloc>().add(
                                                                        UpdateLanguageEvent(state.languages[index]
                                                                            .copyWith(
                                                                                name: selectedValueValue!,
                                                                                level: selectedValueLevel!)));
                                                                    Navigator.pop(context);
                                                                  },
                                                                  child: Text(
                                                                    "Save",
                                                                    style: theme.textTheme.bodyMedium!.copyWith(
                                                                      color: theme.colorScheme.onPrimary,
                                                                    ),
                                                                  ),
                                                                )
                                                              ],
                                                            ),
                                                          ));
                                                },
                                                child: FaIcon(
                                                  FontAwesomeIcons.penToSquare,
                                                  size: 16,
                                                  color: theme.colorScheme.grey!,
                                                ),
                                              ),
                                              const SizedBox(width: 10),
                                              InkWell(
                                                onTap: () {
                                                  context
                                                      .read<StudentCreateProfileBloc>()
                                                      .add(RemoveLanguageEvent(state.languages[index]));
                                                },
                                                child: const FaIcon(
                                                  FontAwesomeIcons.xmark,
                                                  size: 16,
                                                  color: Colors.red,
                                                ),
                                              ),
                                            ],
                                          ),
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
                                  style: theme.textTheme.bodyMedium,
                                ),
                                const Spacer(),
                                Container(
                                  margin: const EdgeInsets.only(right: 10),
                                  padding: const EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                    border: Border.all(color: theme.colorScheme.grey!),
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                  child: InkWell(
                                    onTap: () {
                                      context.read<StudentCreateProfileBloc>().add(AddEducationEvent(Education(
                                            nameOfSchool: "University of Science",
                                            timeStart: '2020',
                                            timeEnd: '2024',
                                          )));
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
                                if (state.edutcations.isNotEmpty) {
                                  return ListView.separated(
                                      shrinkWrap: true,
                                      itemBuilder: (context, index) {
                                        return Container(
                                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                                          decoration: BoxDecoration(
                                            color: const Color.fromARGB(255, 242, 242, 242),
                                            borderRadius: BorderRadius.circular(10),
                                            border: Border.all(
                                              color: theme.colorScheme.grey!,
                                            ),
                                          ),
                                          child: Row(
                                            children: [
                                              Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text(state.edutcations[index].nameOfSchool),
                                                  const SizedBox(
                                                    height: 5,
                                                  ),
                                                  Text(
                                                      '${state.edutcations[index].timeStart} - ${state.edutcations[index].timeEnd}'),
                                                ],
                                              ),
                                              const Spacer(),
                                              InkWell(
                                                onTap: () {
                                                  showModalBottomSheet(
                                                      context: context,
                                                      builder: (ctx) => Container(
                                                            decoration: BoxDecoration(
                                                              color: theme.colorScheme.surface,
                                                              borderRadius: const BorderRadius.only(
                                                                topLeft: Radius.circular(20),
                                                                topRight: Radius.circular(20),
                                                              ),
                                                            ),
                                                            padding: const EdgeInsets.all(20),
                                                            width: double.infinity,
                                                            child: Column(
                                                              children: [
                                                                Center(
                                                                  child: Container(
                                                                    width: 80,
                                                                    height: 5,
                                                                    decoration: BoxDecoration(
                                                                      color: theme.colorScheme.grey,
                                                                      borderRadius: BorderRadius.circular(50),
                                                                    ),
                                                                  ),
                                                                ),
                                                                const SizedBox(height: 10),
                                                                ElevatedButton(
                                                                  style: ElevatedButton.styleFrom(
                                                                    elevation: 0,
                                                                    minimumSize: const Size(double.infinity, 56),
                                                                  ),
                                                                  onPressed: () {},
                                                                  child: Text(
                                                                    "Save",
                                                                    style: theme.textTheme.bodyMedium!.copyWith(
                                                                      color: theme.colorScheme.onPrimary,
                                                                    ),
                                                                  ),
                                                                )
                                                              ],
                                                            ),
                                                          ));
                                                },
                                                child: FaIcon(
                                                  FontAwesomeIcons.penToSquare,
                                                  size: 16,
                                                  color: theme.colorScheme.grey!,
                                                ),
                                              ),
                                              const SizedBox(width: 10),
                                              InkWell(
                                                onTap: () {
                                                  context
                                                      .read<StudentCreateProfileBloc>()
                                                      .add(RemoveEducationEvent(state.edutcations[index]));
                                                },
                                                child: const FaIcon(
                                                  FontAwesomeIcons.xmark,
                                                  size: 16,
                                                  color: Colors.red,
                                                ),
                                              ),
                                            ],
                                          ),
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
              ],
            ),
          ),
        ));
  }
}

class AddSkillSet {}
