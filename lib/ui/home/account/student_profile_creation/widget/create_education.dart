
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:studenthub/blocs/auth_bloc/auth_bloc.dart';
import 'package:studenthub/blocs/student_bloc/student_bloc.dart';
import 'package:studenthub/blocs/student_bloc/student_event.dart';
import 'package:studenthub/constants/key_translator.dart';
import 'package:studenthub/core/text_field_custom.dart';
import 'package:studenthub/core/year_picker_formfield.dart';
import 'package:studenthub/models/student/student_create_profile/education_model.dart';
import 'package:studenthub/widgets/snack_bar_config.dart';

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
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        color: Colors.white,
        child: FormBuilder(
          key: formkey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFieldFormCustom(
                autofocus: true,
                icon: const Icon(
                  Icons.school,
                ),
                name: 'nameOfSchool',
                // hintText: 'Name of School',
                hintText: nameOfSchoolKey.tr(),
                fillColor: Colors.white,
                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 10),
              PickerYearCustom(
                name: 'year_start',
                // hintText: "Year Start",
                // labelText: 'Year Start',
                hintText: yearStartPlaceHolderKey.tr(),
                labelText: yearStartPlaceHolderKey.tr(),
              ),
              const SizedBox(height: 18),
              PickerYearCustom(
                name: 'year_end',
                // hintText: "Year End",
                // labelText: 'Year End',
                hintText: yearEndPlaceHolderKey.tr(),
                labelText: yearEndPlaceHolderKey.tr(),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                  minimumSize: const Size(double.infinity, 56),
                ),
                onPressed: () {
                  if (formkey.currentState?.saveAndValidate() ?? false) {
                    if (int.parse(
                            formkey.currentState!.fields['year_start']!.value) >
                        int.parse(
                            formkey.currentState!.fields['year_end']!.value)) {
                      SnackBarService.showSnackBar(
                          content: "Year start must be less than year end",
                          status: StatusSnackBar.info);
                    } else {
                      int userId = BlocProvider.of<AuthBloc>(context)
                              .state
                              .userModel
                              .student
                              ?.id ??
                          -1;
                      List<Education> educations = List<Education>.from(
                          BlocProvider.of<StudentBloc>(context)
                              .state
                              .student
                              .educations as Iterable);
                      context.read<StudentBloc>().add(
                            UpdateEducationEvent(
                              userId: userId,
                              educations: educations
                                ..add(Education(
                                  schoolName: formkey.currentState!
                                      .fields['nameOfSchool']!.value as String,
                                  startYear: int.parse(formkey.currentState!
                                      .fields['year_start']!.value),
                                  endYear: int.parse(formkey
                                      .currentState!.fields['year_end']!.value),
                                )),
                              onSuccess: () {
                                Navigator.pop(context);
                              },
                            ),
                          );
                    }
                  }
                },
                child: Text(
                  // "Save",
                  saveBtnKey.tr(),
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
