import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:studenthub/blocs/student_create_profile/student_create_profile_bloc.dart';
import 'package:studenthub/blocs/student_create_profile/student_create_profile_event.dart';
import 'package:studenthub/constants/app_theme.dart';
import 'package:studenthub/core/text_field_custom.dart';
import 'package:studenthub/core/year_picker_formfield.dart';
import 'package:studenthub/models/student/student_create_profile/education_model.dart';

class CreateEducationWidget extends StatefulWidget {
  const CreateEducationWidget({super.key});

  @override
  State<CreateEducationWidget> createState() => _CreateEducationWidgetState();
}

class _CreateEducationWidgetState extends State<CreateEducationWidget> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final formkey = GlobalKey<FormBuilderState>();
    return FormBuilder(
      key: formkey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Text(
                "Create Education",
                style: theme.textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              const Spacer(),
              Container(
                decoration: BoxDecoration(
                    color: theme.colorScheme.grey!.withOpacity(0.4),
                    borderRadius: BorderRadius.circular(50)),
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
          const SizedBox(height: 18),
          TextFieldFormCustom(
            icon: const Icon(
              Icons.school,
            ),
            name: 'nameOfSchool',
            hintText: 'Name of School',
            fillColor: Colors.white,
            style: TextStyle(
              color: Colors.grey[600],
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 10),
          const PickerYearCustom(
            name: 'year_start',
            hintText: "Year Start",
            labelText: 'Year Start',
          ),
          const SizedBox(height: 18),
          const PickerYearCustom(
            name: 'year_end',
            hintText: "Year End",
            labelText: 'Year End',
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              elevation: 0,
              minimumSize: const Size(double.infinity, 56),
            ),
            onPressed: () {
              if (formkey.currentState?.saveAndValidate() ?? false) {
                context.read<StudentCreateProfileBloc>().add(
                      AddEducationEvent(
                        education: Education(
                          id: Random().nextInt(1000).toString(),
                          nameOfSchool: formkey.currentState!
                              .fields['nameOfSchool']!.value as String,
                          timeStart:
                              formkey.currentState!.fields['year_start']!.value,
                          timeEnd:
                              formkey.currentState!.fields['year_end']!.value,
                        ),
                        onSuccess: () {
                          Navigator.pop(context);
                        },
                      ),
                    );
              }
            },
            child: Text(
              "Save",
              style: theme.textTheme.bodyMedium!.copyWith(
                color: theme.colorScheme.onPrimary,
              ),
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
