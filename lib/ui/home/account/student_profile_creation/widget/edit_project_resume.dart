import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:studenthub/blocs/auth_bloc/auth_bloc.dart';
import 'package:studenthub/blocs/student_bloc/student_bloc.dart';
import 'package:studenthub/blocs/student_bloc/student_event.dart';
import 'package:studenthub/constants/app_theme.dart';
import 'package:studenthub/constants/key_translator.dart';
import 'package:studenthub/core/date_picker_formfield.dart';
import 'package:studenthub/core/text_field_custom.dart';
import 'package:studenthub/data/dto/student/request_post_experience.dart';
import 'package:studenthub/models/student/student_create_profile/project_model.dart';
import 'package:studenthub/utils/helper.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class EditProjectResumeItem extends StatefulWidget {
  const EditProjectResumeItem({super.key, required this.item});

  final ProjectResume item;

  @override
  State<EditProjectResumeItem> createState() => _EditProjectResumeItemState();
}

class _EditProjectResumeItemState extends State<EditProjectResumeItem> {
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
                    "Edit Project",
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
                autofocus: true,
                hintText: 'Project Name',
                initialValue: widget.item.title,
              ),
              const SizedBox(height: 10),
              DatePickerCustom(
                name: 'start_date',
                hintText: 'Start Date',
                labelText: 'Start Date',
                initialDate: parseMonthYear(widget.item.startMonth),
                view: DateRangePickerView.month,
              ),
              const SizedBox(height: 10),
              DatePickerCustom(
                name: 'end_date',
                hintText: 'End Date',
                labelText: 'End Date',
                initialDate: parseMonthYear(widget.item.endMonth),
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
                initialValue: widget.item.description,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                  minimumSize: const Size(double.infinity, 56),
                ),
                onPressed: () {
                  if (formkey.currentState?.saveAndValidate() ?? false) {
                    final student = context.read<StudentBloc>().state.student;

                    final currentExperience = student.experiences;
                    // Update value
                    for (var element in currentExperience!) {
                      if (element.id == widget.item.id) {
                        element.title = formkey.currentState!
                            .fields['project_name']!.value as String;
                        element.startMonth = DateFormat('MM-yyyy').format(
                            stringToDateTime(formkey
                                .currentState?.fields['start_date']?.value));
                        element.endMonth = DateFormat('MM-yyyy').format(
                            stringToDateTime(formkey
                                .currentState?.fields['end_date']?.value));
                        element.description = formkey.currentState!
                            .fields['description']!.value as String;
                      }
                    }

                    RequestPostExperience requestPostExperience =
                        RequestPostExperience(
                      experience: currentExperience,
                      userId: context
                          .read<AuthBloc>()
                          .state
                          .userModel
                          .student!
                          .id
                          .toString(),
                    );

                    context.read<StudentBloc>().add(AddProjectEvent(
                          experience: requestPostExperience,
                          onSuccess: () {
                            Navigator.pop(context);
                          },
                        ));
                  }
                },
                child: Text(
                  saveBtnKey.tr(),
                  style: theme.textTheme.bodyMedium!.copyWith(
                    color: theme.colorScheme.onPrimary,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
