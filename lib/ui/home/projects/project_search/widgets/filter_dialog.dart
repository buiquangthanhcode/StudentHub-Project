import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:studenthub/constants/app_theme.dart';
import 'package:studenthub/constants/colors.dart';

class FilterDialog extends StatefulWidget {
  const FilterDialog({super.key, required this.applyFilter});

  final void Function(Map<String, dynamic> data) applyFilter;

  @override
  _FilterDialogState createState() => _FilterDialogState();
}

class _FilterDialogState extends State<FilterDialog> {
  final projectLength = [
    'Less than 1 month',
    '1-3 months',
    '3-6 months',
    'more than 6 months',
  ];

  int? radioButtonSelected;
  final studentInputController = TextEditingController();
  final proposalInputController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    radioButtonSelected = 0;
  }

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    return Container(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 30),
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(20))),
      child: Form(
        child: Padding(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Filter by',
                    style: textTheme.bodyLarge,
                  ),
                  InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: const FaIcon(FontAwesomeIcons.xmark))
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'Project length',
                        style: textTheme.bodySmall,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Wrap(
                    runSpacing: 10,
                    spacing: 12,
                    children: [
                      ...projectLength.map(
                        (e) => GestureDetector(
                          onTap: () {
                            setState(() {
                              radioButtonSelected = projectLength.indexOf(e);
                            });
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 8, horizontal: 15),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              color: radioButtonSelected ==
                                      projectLength.indexOf(e)
                                  ? primaryColor
                                  : const Color.fromARGB(255, 235, 235, 235),
                            ),
                            child: Text(e,
                                style: radioButtonSelected ==
                                        projectLength.indexOf(e)
                                    ? textTheme.bodyMedium!
                                        .copyWith(color: Colors.white)
                                    : textTheme.bodyMedium!),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'Students needed',
                        style: textTheme.bodySmall,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    onChanged: (value) {
                      if (value.length == 1 || value.isEmpty) {
                        setState(() {});
                      }
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                    cursorHeight: 18,
                    controller: studentInputController,
                    cursorColor: Colors.black,
                    style: textTheme.bodyMedium,
                    decoration: InputDecoration(
                      hintText: 'Enter your number',
                      hintStyle: textTheme.bodyMedium!.copyWith(
                          color: Theme.of(context).colorScheme.hintColor),
                      suffixIcon: studentInputController.text.isNotEmpty
                          ? Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                InkWell(
                                  onTap: () {
                                    studentInputController.clear();
                                    setState(() {});
                                  },
                                  child: Container(
                                    width: 18,
                                    height: 18,
                                    alignment: Alignment.center,
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Color.fromARGB(255, 191, 191, 191),
                                    ),
                                    child: const FaIcon(
                                      FontAwesomeIcons.xmark,
                                      color: Colors.white,
                                      size: 12,
                                    ),
                                  ),
                                ),
                              ],
                            )
                          : Container(width: 1),
                      suffixIconConstraints: const BoxConstraints(minWidth: 50),
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 10),
                      isDense: true,
                      filled: true,
                      fillColor: Colors.white,
                      errorStyle: const TextStyle(height: 0),
                      border: defaultInputBorder,
                      enabledBorder: defaultInputBorder,
                      disabledBorder: defaultInputBorder,
                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(width: 2, color: primaryColor),
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                      ),
                      errorBorder: defaultInputBorder,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'Proposals less than',
                        style: textTheme.bodySmall,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    onChanged: (value) {
                      if (value.length == 1 || value.isEmpty) {
                        setState(() {});
                      }
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                    cursorHeight: 18,
                    controller: proposalInputController,
                    cursorColor: Colors.black,
                    style: textTheme.bodyMedium,
                    decoration: InputDecoration(
                      hintText: 'Enter your number',
                      hintStyle: textTheme.bodyMedium!.copyWith(
                          color: Theme.of(context).colorScheme.hintColor),
                      suffixIcon: proposalInputController.text.isNotEmpty
                          ? Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                InkWell(
                                  onTap: () {
                                    proposalInputController.clear();
                                    setState(() {});
                                  },
                                  child: Container(
                                    width: 18,
                                    height: 18,
                                    alignment: Alignment.center,
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Color.fromARGB(255, 191, 191, 191),
                                    ),
                                    child: const FaIcon(
                                      FontAwesomeIcons.xmark,
                                      color: Colors.white,
                                      size: 12,
                                    ),
                                  ),
                                ),
                              ],
                            )
                          : Container(width: 1),
                      suffixIconConstraints: const BoxConstraints(minWidth: 50),
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 10),
                      isDense: true,
                      filled: true,
                      fillColor: Colors.white,
                      errorStyle: const TextStyle(height: 0),
                      border: defaultInputBorder,
                      enabledBorder: defaultInputBorder,
                      disabledBorder: defaultInputBorder,
                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(width: 2, color: primaryColor),
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                      ),
                      errorBorder: defaultInputBorder,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: primaryColor, width: 2),
                          minimumSize: const Size(double.infinity, 42),
                          backgroundColor: Colors.transparent),
                      onPressed: () {},
                      child: Text(
                        'Clear filters',
                        style: textTheme.bodyMedium!.copyWith(
                            color: primaryColor, fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(double.infinity, 42),
                      ),
                      onPressed: () {
                        widget.applyFilter({
                          'projectScopeFlag': radioButtonSelected,
                          'numberOfStudents': studentInputController.text,
                          'proposalsLessThan': proposalInputController.text,
                        });
                        Navigator.pop(context);
                      },
                      child: Text(
                        'Apply',
                        style: textTheme.bodyMedium!.copyWith(
                            color: Colors.white, fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
