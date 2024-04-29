import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:studenthub/blocs/auth_bloc/auth_bloc.dart';
import 'package:studenthub/blocs/auth_bloc/auth_event.dart';
import 'package:studenthub/blocs/student_bloc/student_bloc.dart';
import 'package:studenthub/blocs/student_bloc/student_event.dart';
import 'package:studenthub/constants/app_theme.dart';
import 'package:studenthub/core/date_picker_formfield.dart';
import 'package:studenthub/core/text_field_custom.dart';
import 'package:studenthub/data/dto/student/request_post_experience.dart';
import 'package:studenthub/models/student/student_create_profile/project_model.dart';
import 'package:studenthub/utils/helper.dart';
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

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: SingleChildScrollView(
        child: FormBuilder(
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
              const SizedBox(height: 10),
              TextFieldFormCustom(
                fillColor: Colors.white,
                style: TextStyle(
                  color: Colors.grey[900],
                  fontSize: 16,
                ),
                icon: const Icon(
                  Icons.work,
                  color: Colors.grey,
                ),
                name: 'project_name',
                autofocus: true,
                hintText: 'Project Name',
              ),
              const SizedBox(height: 10),
              const DatePickerCustom(
                name: 'start_date',
                hintText: 'Start Date',
                labelText: 'Start Date',
                view: DateRangePickerView.month,
              ),
              const SizedBox(height: 18),
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
                  color: Colors.grey[900],
                  fontSize: 16,
                ),
                icon: const Icon(
                  Icons.description,
                  color: Colors.grey,
                ),
                name: 'description',
                hintText: 'Description',
                maxLines: 5,
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                  minimumSize: const Size(double.infinity, 56),
                ),
                onPressed: () {
                  if (formkey.currentState?.saveAndValidate() ?? false) {
                    final student = context.read<StudentBloc>().state.student;
                    RequestPostExperience requestPostExperience = RequestPostExperience(
                      experience: [
                        ...student.experiences ?? [],
                        ProjectResume(
                          skillSets: student.skillSets ?? [],
                          title: formkey.currentState?.fields['project_name']?.value,
                          startMonth: DateFormat('MM-yyyy')
                              .format(stringToDateTime(formkey.currentState?.fields['start_date']?.value)),
                          endMonth: DateFormat('MM-yyyy')
                              .format(stringToDateTime(formkey.currentState?.fields['end_date']?.value)),
                          description: formkey.currentState?.fields['description']?.value,
                        )
                      ],
                      userId: context.read<AuthBloc>().state.userModel.student!.id.toString(),
                    );

                    context.read<StudentBloc>().add(AddProjectEvent(
                          experience: requestPostExperience,
                          onSuccess: () {
                            Navigator.pop(context);
                            context.read<AuthBloc>().add(GetInformationEvent(
                                onSuccess: () {}, accessToken: context.read<AuthBloc>().state.userModel.token ?? ''));
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
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
