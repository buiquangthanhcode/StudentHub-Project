import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:studenthub/blocs/auth_bloc/auth_bloc.dart';
import 'package:studenthub/blocs/project_bloc/project_bloc.dart';
import 'package:studenthub/blocs/project_bloc/project_event.dart';
import 'package:studenthub/constants/app_theme.dart';
import 'package:studenthub/constants/colors.dart';
import 'package:studenthub/constants/key_translator.dart';
import 'package:studenthub/core/text_field_custom.dart';
import 'package:studenthub/models/common/project_model.dart';
import 'package:studenthub/utils/logger.dart';
import 'package:studenthub/widgets/snack_bar_config.dart';

enum TimeOption { option1, option2, option3, option4 }

class EditPosting extends StatefulWidget {
  final Project project;
  const EditPosting({super.key, required this.project});

  @override
  _EditPostingState createState() => _EditPostingState();
}

class _EditPostingState extends State<EditPosting> {
  final _formKeyEdit = GlobalKey<FormBuilderState>();
  late TimeOption _timeOption;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _timeOption = widget.project.projectScopeFlag == 0
        ? TimeOption.option1
        : widget.project.projectScopeFlag == 1
            ? TimeOption.option2
            : widget.project.projectScopeFlag == 2
                ? TimeOption.option3
                : TimeOption.option4;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      height: MediaQuery.of(context).size.height * 0.95,
      width: double.infinity,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
      ),
      child: FormBuilder(
        key: _formKeyEdit,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            Text(
              'Title',
              style: theme.textTheme.bodyMedium!.copyWith(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black.withOpacity(0.6),
              ),
            ),
            TextFieldFormCustom(
              fillColor: Colors.white,
              name: 'title',
              hintText: 'Please enter title',
              initialValue: widget.project.title,
              icon: Container(
                width: 18,
                height: 18,
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: FaIcon(
                  FontAwesomeIcons.clipboard,
                  size: 16,
                  color: theme.colorScheme.grey,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              projectScopeKey.tr(),
              style: theme.textTheme.bodyMedium!.copyWith(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black.withOpacity(0.6),
              ),
            ),
            Column(
              children: [
                const SizedBox(height: 2),
                RadioListTile(
                  activeColor: primaryColor,
                  visualDensity:
                      const VisualDensity(vertical: -4.0, horizontal: -4.0),
                  title: Text(
                    lessThan1MonthKey.tr(),
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: Colors.black.withOpacity(0.6),
                        ),
                  ),
                  value: TimeOption.option1,
                  groupValue: _timeOption,
                  onChanged: (value) {
                    setState(() {
                      _timeOption = value as TimeOption;
                    });
                  },
                ),
                RadioListTile(
                  activeColor: primaryColor,
                  visualDensity:
                      const VisualDensity(vertical: -4.0, horizontal: -4.0),
                  title: Text(
                    oneToThreeMonthsKey.tr(),
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: Colors.black.withOpacity(0.6),
                        ),
                  ),
                  value: TimeOption.option2,
                  groupValue: _timeOption,
                  onChanged: (value) {
                    setState(() {
                      _timeOption = value as TimeOption;
                    });
                  },
                ),
                RadioListTile(
                  activeColor: primaryColor,
                  visualDensity:
                      const VisualDensity(vertical: -4.0, horizontal: -4.0),
                  title: Text(
                    threeToSixMonthsKey.tr(),
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: Colors.black.withOpacity(0.6),
                        ),
                  ),
                  value: TimeOption.option3,
                  groupValue: _timeOption,
                  onChanged: (value) {
                    setState(() {
                      _timeOption = value as TimeOption;
                    });
                  },
                ),
                RadioListTile(
                  activeColor: primaryColor,
                  visualDensity:
                      const VisualDensity(vertical: -4.0, horizontal: -4.0),
                  title: Text(
                    moreThan6MonthsKey.tr(),
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: Colors.black.withOpacity(0.6),
                        ),
                  ),
                  value: TimeOption.option4,
                  groupValue: _timeOption,
                  onChanged: (value) {
                    setState(() {
                      _timeOption = value as TimeOption;
                    });
                  },
                ),
              ],
            ),
            const SizedBox(height: 20),
            Text(
              'Number of students',
              style: theme.textTheme.bodyMedium!.copyWith(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black.withOpacity(0.6),
              ),
            ),
            TextFieldFormCustom(
              fillColor: Colors.white,
              initialValue: widget.project.numberOfStudents.toString(),
              name: 'number_of_students',
              hintText: 'Please enter number of students',
              icon: Container(
                width: 18,
                height: 18,
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: FaIcon(
                  FontAwesomeIcons.user,
                  size: 16,
                  color: theme.colorScheme.grey,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              // 'Description',
              descriptionPlaceHolderKey.tr(),
              style: theme.textTheme.bodyMedium!.copyWith(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black.withOpacity(0.6),
              ),
            ),
            TextFieldFormCustom(
              initialValue: widget.project.description.toString(),
              maxLines: 8,
              fillColor: Colors.white,
              name: 'description',
              hintText: 'Please enter description',
            ),
            const SizedBox(height: 20),
            Expanded(
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Row(
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        elevation: 0,
                        minimumSize: const Size(180, 56),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                          side:
                              const BorderSide(color: primaryColor, width: 2.0),
                        ),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        // 'Cancel',
                        cancelBtnKey.tr(),
                        style: theme.textTheme.bodyMedium?.copyWith(
                            color: primaryColor, fontWeight: FontWeight.w600),
                      ),
                    ),
                    const Spacer(),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        elevation: 0,
                        minimumSize: const Size(180, 56),
                      ),
                      onPressed: () {
                        // validate form
                        if (_formKeyEdit.currentState?.saveAndValidate() ??
                            false) {
                          logger.d(_formKeyEdit.currentState!.value);
                        }

                        int? companyId = BlocProvider.of<AuthBloc>(context)
                            .state
                            .userModel
                            .company!
                            .id;
                        context.read<ProjectBloc>().add(
                              EditProjectEvent(
                                  companyId: companyId!,
                                  updatedProject: Project.fromMap(
                                    {
                                      'id': widget.project.id,
                                      'projectScopeFlag': _timeOption ==
                                              TimeOption.option1
                                          ? 0
                                          : _timeOption == TimeOption.option2
                                              ? 1
                                              : _timeOption ==
                                                      TimeOption.option3
                                                  ? 2
                                                  : 3,
                                      'title': _formKeyEdit
                                          .currentState!.value['title'],
                                      'description': _formKeyEdit
                                          .currentState!.value['description'],
                                      'numberOfStudents': int.parse(_formKeyEdit
                                          .currentState!
                                          .value['number_of_students']),
                                      'typeFlag': widget.project.typeFlag,
                                    },
                                  ),
                                  onSuccess: () {
                                    SnackBarService.showSnackBar(
                                        status: StatusSnackBar.success,
                                        // content:
                                        //     "Project was updated successfully!");
                                        content:
                                            projectUpdatedSuccessMsgKey.tr());
                                    Navigator.pop(context);
                                    Navigator.pop(context);
                                  }),
                            );
                      },
                      child: Text(
                        'Edit',
                        style: theme.textTheme.bodyMedium?.copyWith(
                            color: Colors.white, fontWeight: FontWeight.w600),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
      // width: double.infinity, // Set width to occupy 100% of parent's width
    );
  }
}
