import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:studenthub/blocs/auth_bloc/auth_bloc.dart';
import 'package:studenthub/blocs/student_bloc/student_bloc.dart';
import 'package:studenthub/blocs/student_bloc/student_event.dart';
import 'package:studenthub/constants/app_theme.dart';
import 'package:studenthub/core/text_field_custom.dart';
import 'package:studenthub/core/year_picker_formfield.dart';
import 'package:studenthub/models/student/student_create_profile/education_model.dart';
import 'package:studenthub/utils/helper.dart';

class EducationEdit extends StatefulWidget {
  const EducationEdit({
    super.key,
    required this.item,
  });

  final Education item;

  @override
  State<EducationEdit> createState() => _EditEducationState();
}

class _EditEducationState extends State<EducationEdit> {
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
                "Edit Language",
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
            icon: const Icon(
              Icons.school,
            ),
            name: 'nameOfSchool',
            hintText: 'Name of School',
            initialValue: widget.item.schoolName,
            fillColor: Colors.white,
            style: TextStyle(
              color: Colors.grey[600],
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 10),
          PickerYearCustom(
            name: 'year_start',
            hintText: "Year Start",
            initValue: parseYearToDateTime(widget.item.startYear.toString()),
            labelText: 'Year Start',
          ),
          const SizedBox(height: 10),
          PickerYearCustom(
            name: 'year_end',
            hintText: "Year End",
            labelText: 'Year End',
            initValue: parseYearToDateTime(widget.item.endYear.toString()),
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              elevation: 0,
              minimumSize: const Size(double.infinity, 56),
            ),
            onPressed: () {
              if (formkey.currentState?.saveAndValidate() ?? false) {
                int userId = BlocProvider.of<AuthBloc>(context).state.userModel.student?.id ?? -1;
                List<Education> educations =
                    List<Education>.from(BlocProvider.of<StudentBloc>(context).state.edutcations);
                context.read<StudentBloc>().add(
                      UpdateEducationEvent(
                        userId: userId,
                        educations: educations
                          ..add(Education(
                            schoolName: formkey.currentState!.fields['nameOfSchool']!.value as String,
                            startYear: formkey.currentState!.fields['year_start']!.value,
                            endYear: formkey.currentState!.fields['year_end']!.value,
                          )),
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
          )
        ],
      ),
    );
  }
}
