import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:studenthub/blocs/student_bloc/student_bloc.dart';
import 'package:studenthub/blocs/student_bloc/student_event.dart';
import 'package:studenthub/constants/app_theme.dart';
import 'package:studenthub/constants/key_translator.dart';
import 'package:studenthub/core/dropdown_button_formfield.dart';
import 'package:studenthub/models/student/student_create_profile/language_model.dart';
import 'package:studenthub/ui/home/account/student_profile_creation/data/student_data_creation.dart';

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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: FormBuilder(
        key: formkey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  // "Edit Language",
                  editLanguageTitleKey.tr(),
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
              hint: "Please select Language",
              initValue: widget.item.languageName,
            ),
            DropDownFormFieldCustom(
              name: 'level',
              data: levelLanguage,
              onSelected: (value) {},
              hint: "Please select level",
              initValue: widget.item.level,
            ),
            const SizedBox(height: 50),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                elevation: 0,
                minimumSize: const Size(double.infinity, 56),
              ),
              onPressed: () {
                if (formkey.currentState?.saveAndValidate() ?? false) {
                  int userId =
                      BlocProvider.of<StudentBloc>(context).state.student.id ??
                          0;
                  List<Language> currentLanguages =
                      BlocProvider.of<StudentBloc>(context)
                              .state
                              .student
                              .languages ??
                          [];
                  Language itemUpdate = Language(
                      id: widget.item.id,
                      languageName:
                          formkey.currentState?.fields['language']?.value,
                      level: formkey.currentState?.fields['level']?.value);
                  List<Language> newLanguages = currentLanguages.map((e) {
                    if (e.id == widget.item.id) {
                      return itemUpdate;
                    } else {
                      return e;
                    }
                  }).toList();
                  BlocProvider.of<StudentBloc>(context).add(UpdateLanguageEvent(
                      userId: userId,
                      languages: newLanguages,
                      onSuccess: () {
                        Navigator.pop(context);
                      }));
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
    );
  }
}
