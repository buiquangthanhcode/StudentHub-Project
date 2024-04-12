import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:studenthub/constants/app_theme.dart';
import 'package:studenthub/constants/colors.dart';
import 'package:studenthub/core/text_field_custom.dart';
import 'package:studenthub/models/common/project_model.dart';
import 'package:studenthub/utils/logger.dart';

enum TimeOption { option1, option2 }

class EditPosting extends StatefulWidget {
  final Project project;
  const EditPosting({Key? key, required this.project}) : super(key: key);

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
    _timeOption = TimeOption.option1;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      height: MediaQuery.of(context).size.height * 0.8,
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
              'Project scope',
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
                    '1 to 3 months',
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
                    '3 to 6 months',
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
                )
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
              'Description',
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
              name: 'number_of_students',
              hintText: 'Please enter description',
            ),
            const SizedBox(height: 20),
            Expanded(
              child: Container(
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
                        'Cancel',
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
