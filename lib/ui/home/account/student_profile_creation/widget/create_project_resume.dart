import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:studenthub/blocs/student_create_profile/student_create_profile_bloc.dart';
import 'package:studenthub/blocs/student_create_profile/student_create_profile_event.dart';
import 'package:studenthub/constants/app_theme.dart';
import 'package:studenthub/core/date_picker_formfield.dart';
import 'package:studenthub/core/text_field_custom.dart';
import 'package:studenthub/models/student/student_create_profile/project_model.dart';
import 'package:studenthub/models/student/student_create_profile/skillset_model.dart';
import 'package:studenthub/utils/logger.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class CreateProjectResume extends StatefulWidget {
  const CreateProjectResume({super.key});

  @override
  State<CreateProjectResume> createState() => _CreateProjectResumeState();
}

class _CreateProjectResumeState extends State<CreateProjectResume> {
  final formkey = GlobalKey<FormBuilderState>();
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return FormBuilder(
      key: formkey,
      child: Column(
        children: [
          Row(
            children: [
              Text(
                "Create Project",
                style: theme.textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              const Spacer(),
              Container(
                decoration: BoxDecoration(
                    color: theme.colorScheme.grey!.withOpacity(0.4), borderRadius: BorderRadius.circular(50)),
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
          const SizedBox(height: 20),
          TextFieldFormCustom(
            fillColor: Colors.white,
            style: TextStyle(
              color: Colors.grey[600],
              fontSize: 16,
            ),
            icon: const Icon(
              Icons.work,
              color: Colors.grey,
            ),
            name: 'project_name',
            hintText: 'Project Name',
          ),
          const SizedBox(height: 10),
          const DatePickerCustom(
            name: 'start_date',
            hintText: 'Start Date',
            labelText: 'Start Date',
            view: DateRangePickerView.month,
          ),
          const SizedBox(height: 10),
          const DatePickerCustom(
            name: 'end_date',
            hintText: 'End Date',
            labelText: 'End Date',
            view: DateRangePickerView.month,
          ),
          const SizedBox(height: 10),
          TextFieldFormCustom(
            fillColor: Colors.white,
            style: TextStyle(
              color: Colors.grey[600],
              fontSize: 16,
            ),
            icon: const Icon(
              Icons.description,
              color: Colors.grey,
            ),
            name: 'description',
            hintText: 'Description',
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              elevation: 0,
              minimumSize: const Size(double.infinity, 56),
            ),
            onPressed: () {
              if (formkey.currentState?.saveAndValidate() ?? false) {
                logger.d(formkey.currentState?.value);
                context.read<StudentCreateProfileBloc>().add(AddProjectEvent(
                      project: ProjectResume(
                        id: Random().nextInt(1000).toString(),
                        duration: 1,
                        skills: [
                          SkillSet(name: 'NodeJs', isSelected: false),
                        ],
                        name: formkey.currentState?.fields['project_name']?.value,
                        startDate: formkey.currentState?.fields['start_date']?.value,
                        endDate: formkey.currentState?.fields['end_date']?.value,
                        description: formkey.currentState?.fields['description']?.value,
                      ),
                      onSuccess: () {
                        Navigator.pop(context);
                      },
                    ));
              }
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
    );
  }
}
