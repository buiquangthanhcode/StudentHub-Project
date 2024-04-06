import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:studenthub/blocs/student_bloc/student_bloc.dart';
import 'package:studenthub/blocs/student_bloc/student_event.dart';
import 'package:studenthub/constants/app_theme.dart';
import 'package:studenthub/core/dropdown_button_formfield.dart';
import 'package:studenthub/models/student/student_create_profile/language_model.dart';
import 'package:studenthub/ui/home/account/student_profile_creation/data/student_data_creation.dart';
import 'package:studenthub/widgets/snack_bar_config.dart';

class CreateLanguageWidget extends StatefulWidget {
  const CreateLanguageWidget({
    super.key,
  });

  @override
  State<CreateLanguageWidget> createState() => _CreateLanguageWidgetState();
}

class _CreateLanguageWidgetState extends State<CreateLanguageWidget> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final formkey = GlobalKey<FormBuilderState>();
    return FormBuilder(
      key: formkey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
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
          const SizedBox(height: 10),
          DropDownFormFieldCustom(
            data: language,
            name: 'language',
            onSelected: (value) {},
            hint: "Please select language",
          ),
          DropDownFormFieldCustom(
            name: 'level',
            data: levelLanguage,
            onSelected: (value) {},
            hint: "Please select level",
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              elevation: 0,
              minimumSize: const Size(double.infinity, 56),
            ),
            onPressed: () {
              if (formkey.currentState?.saveAndValidate() ?? false) {
                Language newLanguage = Language(
                  id: Random().nextInt(1000).toString(),
                  name: formkey.currentState?.fields['language']?.value,
                  level: formkey.currentState?.fields['level']?.value,
                );
                context.read<StudentBloc>().add(AddLanguageEvent(
                    language: newLanguage,
                    onSuccess: () {
                      SnackBarService.showSnackBar(
                          content: "Add Sucessfully",
                          status: StatusSnackBar.success);
                      Navigator.pop(context);
                    }));
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
