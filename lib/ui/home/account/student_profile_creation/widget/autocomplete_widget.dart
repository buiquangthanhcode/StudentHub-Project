import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:studenthub/blocs/student_create_profile/student_create_profile_bloc.dart';
import 'package:studenthub/blocs/student_create_profile/student_create_profile_event.dart';
import 'package:studenthub/models/student/student_create_profile/skillset_model.dart';
import 'package:studenthub/ui/home/account/student_profile_creation/data/student_data_creation.dart';

class AutoCompleteWidget extends StatefulWidget {
  const AutoCompleteWidget({super.key});

  @override
  State<AutoCompleteWidget> createState() => _AutoCompleteWidgetState();
}

class _AutoCompleteWidgetState extends State<AutoCompleteWidget> {
  late TextEditingController textEditingController;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return LayoutBuilder(
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
          fieldViewBuilder: (context, fieldTextEditingController, focusNode,
              onFieldSubmitted) {
            textEditingController = fieldTextEditingController;
            return TextFormField(
              controller: fieldTextEditingController,
              focusNode: focusNode,
              style: TextStyle(
                color: Colors.grey[400],
                fontSize: 16,
              ),
              scrollPadding: const EdgeInsets.all(0),
              decoration: const InputDecoration(
                // contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                isDense: true,
                hintText: 'Enter your skill',
                hintStyle: TextStyle(
                  fontSize: 14,
                ),
                border: OutlineInputBorder(),
              ),
            );
          },
          optionsBuilder: (TextEditingValue skillsetTextEditController) {
            if (skillsetTextEditController.text == '') {
              return const Iterable<String>.empty();
            }
            return skillSetList.where((String option) {
              return option
                  .toLowerCase()
                  .contains(skillsetTextEditController.text);
            });
          },
          onSelected: (String value) {
            context.read<StudentCreateProfileBloc>().add(
                AddSkillSetEvent(SkillSet(name: value, isSelected: false)));
            textEditingController.text = "";
          },
        );
      },
    );
  }
}
