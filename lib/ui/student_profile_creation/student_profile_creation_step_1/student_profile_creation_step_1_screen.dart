import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:studenthub/blocs/student_create_profile/student_create_profile_bloc.dart';
import 'package:studenthub/blocs/student_create_profile/student_create_profile_event.dart';
import 'package:studenthub/blocs/student_create_profile/student_create_profile_state.dart';
import 'package:studenthub/constants/app_theme.dart';
import 'package:studenthub/core/show_modal_bottomSheet.dart';
import 'package:studenthub/models/student_create_profile/skillset_model.dart';
import 'package:studenthub/core/dropdown_button_formfield.dart';
import 'package:studenthub/ui/student_profile_creation/data/student_data_creation.dart';
import 'package:studenthub/ui/student_profile_creation/widget/create_education.dart';
import 'package:studenthub/ui/student_profile_creation/widget/create_language.dart';
import 'package:studenthub/ui/student_profile_creation/widget/edit_language.dart';
import 'package:studenthub/widgets/dialog.dart';
import 'package:studenthub/widgets/emtyDataWidget.dart';
import 'package:studenthub/widgets/snack_bar_config.dart';

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
        title: const SizedBox(),
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
                                      padding: const EdgeInsets.symmetric(horizontal: 20),
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
                      LayoutBuilder(
                        builder: (context, constraints) {
                          return RawAutocomplete<String>(
                            optionsViewBuilder: (context, onSelected, options) {
                              return Align(
                                alignment: Alignment.topLeft,
                                child: Material(
                                  elevation: 4.0,
                                  child: SizedBox(
                                    height: options.length <= 2 ? 100 : 200,
                                    width: constraints.biggest.width,
                                    child: ListView.builder(
                                      padding: const EdgeInsets.all(8.0),
                                      itemCount: options.length,
                                      itemBuilder: (BuildContext context, int index) {
                                        final String option = options.elementAt(index);
                                        return GestureDetector(
                                          onTap: () {
                                            onSelected(option);
                                          },
                                          child: ListTile(
                                              title: Text(
                                            option,
                                            style: theme.textTheme.bodyMedium?.copyWith(
                                              fontSize: 16,
                                            ),
                                          )),
                                        );
                                      },
                                    ),
                                  ),
                                ),
                              );
                            },
                            displayStringForOption: (option) {
                              return option;
                            },
                            fieldViewBuilder: (context, fieldTextEditingController, focusNode, onFieldSubmitted) {
                              textEditingController = fieldTextEditingController;
                              return SizedBox(
                                height: 56,
                                child: TextField(
                                  controller: fieldTextEditingController,
                                  focusNode: focusNode,
                                  decoration: const InputDecoration(
                                    hintText: 'Enter your skill',
                                    hintStyle: TextStyle(fontSize: 16),
                                    border: OutlineInputBorder(),
                                  ),
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
                            onSelected: (String value) {
                              context
                                  .read<StudentCreateProfileBloc>()
                                  .add(AddSkillSetEvent(SkillSet(name: value, isSelected: false)));
                              textEditingController.text = "";
                            },
                          );
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
                                                showModalBottomSheetCustom(context,
                                                    widgetBuilder: LanguageEdit(item: state.languages[index]));
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
                                                showDialogCustom(context,
                                                    image: 'lib/assets/images/delete.png',
                                                    title: 'Are you sure you want to delete this language?',
                                                    textButtom: 'Delete',
                                                    subtitle: 'This action cannot be undone', onSave: () {
                                                  context.read<StudentCreateProfileBloc>().add(
                                                        RemoveLanguageEvent(
                                                            language: state.languages[index],
                                                            onSuccess: () {
                                                              SnackBarService.showSnackBar(
                                                                  content: "Delete Sucessfully",
                                                                  status: StatusSnackBar.success);
                                                              Navigator.pop(context);
                                                            }),
                                                      );
                                                });
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
