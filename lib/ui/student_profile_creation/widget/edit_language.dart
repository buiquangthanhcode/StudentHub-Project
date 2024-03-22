import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:studenthub/blocs/student_create_profile/student_create_profile_bloc.dart';
import 'package:studenthub/blocs/student_create_profile/student_create_profile_event.dart';
import 'package:studenthub/constants/app_theme.dart';
import 'package:studenthub/core/dropdown_button_formfield.dart';
import 'package:studenthub/models/student_create_profile/language_model.dart';
import 'package:studenthub/ui/student_profile_creation/data/student_data_creation.dart';

class LanguageEdit extends StatefulWidget {
  const LanguageEdit({super.key, required this.item});

  final Language item;

  @override
  State<LanguageEdit> createState() => _LanguageEditState();
}

class _LanguageEditState extends State<LanguageEdit> {
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
          DropDownFormFieldCustom(
            data: language,
            name: 'language',
            onSelected: (value) {},
            hint: "Please selecte Language",
          ),
          DropDownFormFieldCustom(
            name: 'level',
            data: levelLanguage,
            onSelected: (value) {},
            hint: "Please selecte level",
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              elevation: 0,
              minimumSize: const Size(double.infinity, 56),
            ),
            onPressed: () {
              if (formkey.currentState?.saveAndValidate() ?? false) {
                BlocProvider.of<StudentCreateProfileBloc>(context).add(UpdateLanguageEvent(widget.item));
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
