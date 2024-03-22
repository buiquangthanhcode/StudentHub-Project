import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:studenthub/blocs/student_create_profile/student_create_profile_bloc.dart';
import 'package:studenthub/blocs/student_create_profile/student_create_profile_event.dart';
import 'package:studenthub/constants/app_theme.dart';
import 'package:studenthub/core/text_field_custom.dart';
import 'package:studenthub/core/year_picker_formfield.dart';
import 'package:studenthub/models/student_create_profile/education_model.dart';

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
                "Create Language",
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
            fillColor: Colors.white,
            style: TextStyle(
              color: Colors.grey[600],
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 10),
          const PickerYearCustom(
            name: 'year',
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              elevation: 0,
              minimumSize: const Size(double.infinity, 56),
            ),
            onPressed: () {
              if (formkey.currentState?.saveAndValidate() ?? false) {
                context.read<StudentCreateProfileBloc>().add(AddEducationEvent(Education(
                      nameOfSchool: "University of Science",
                      timeStart: '2020',
                      timeEnd: '2024',
                    )));
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
