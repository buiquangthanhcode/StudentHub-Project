import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:studenthub/constants/app_theme.dart';
import 'package:studenthub/constants/colors.dart';
import 'package:studenthub/constants/key_translator.dart';

class EmployeeQuantitySelectionWidget extends StatefulWidget {
  const EmployeeQuantitySelectionWidget(
      {super.key, required this.chooseEmployeesQuantity});
  final Function(int value) chooseEmployeesQuantity;

  @override
  _EmployeeQuantitySelectionWidgetState createState() =>
      _EmployeeQuantitySelectionWidgetState();
}

class _EmployeeQuantitySelectionWidgetState
    extends State<EmployeeQuantitySelectionWidget> {
  // final employeeQuantityData = [
  //   'It\'s just me',
  //   '2-9',
  //   '10-99',
  //   '100-1000',
  //   'More than 1000',
  // ];

  final employeeQuantityData = [
    justMeKey.tr(),
    twoToNineKey.tr(),
    tenToNinetyNineKey.tr(),
    hundredToThousandKey.tr(),
    moreThanThousandKey.tr(),
  ];
  int? radioButtonSelected;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    radioButtonSelected = 0;
  }

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          // 'How many people are in your company?',
          howManyPeopleMsgKey.tr(),
          style: textTheme.bodySmall,
        ),
        const SizedBox(
          height: 12,
        ),
        Wrap(
          runSpacing: 10,
          spacing: 12,
          children: [
            ...employeeQuantityData.map(
              (e) => GestureDetector(
                onTap: () {
                  setState(() {
                    radioButtonSelected = employeeQuantityData.indexOf(e);
                    widget.chooseEmployeesQuantity(radioButtonSelected!);
                  });
                },
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 24),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    // color: employeeQuantityData[radioButtonSelected!] == e
                    //     ? primaryColor
                    //     : const Color.fromARGB(255, 235, 235, 235),
                    color: employeeQuantityData[radioButtonSelected!] == e
                        ? primaryColor
                        : const Color.fromARGB(255, 235, 235, 235),
                  ),
                  child: Text(
                    e,
                    // style: employeeQuantityData[radioButtonSelected!] == e
                    //     ? textTheme.bodyMedium!.copyWith(color: Colors.white)
                    //     : textTheme.bodyMedium!),
                    style: employeeQuantityData[radioButtonSelected!] == e
                        ? textTheme.bodyMedium?.copyWith(
                            color: Colors.white,
                          )
                        : textTheme.bodyMedium?.copyWith(color: Colors.black),
                  ),
                ),
              ),
            )
          ],
        ),
      ],
    );
  }
}
