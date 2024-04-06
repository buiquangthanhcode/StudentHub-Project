import 'package:flutter/material.dart';
import 'package:studenthub/constants/colors.dart';

class EmployeeQuantitySelectionWidget extends StatefulWidget {
  const EmployeeQuantitySelectionWidget(
      {Key? key, required this.chooseEmployeeQuantity, required this.value})
      : super(key: key);

  final Function(int value) chooseEmployeeQuantity;
  final int value;

  @override
  _EmployeeQuantitySelectionWidgetState createState() =>
      _EmployeeQuantitySelectionWidgetState();
}

class _EmployeeQuantitySelectionWidgetState
    extends State<EmployeeQuantitySelectionWidget> {
  final employeeQuantityData = [
    'It\'s just me',
    '2-9',
    '10-99',
    '100-1000',
    'More than 1000',
  ];

  int? radioButtonSelected;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    radioButtonSelected = widget.value;
  }

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Employees',
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
                    widget.chooseEmployeeQuantity(radioButtonSelected!);
                  });
                },
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 24),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: employeeQuantityData[radioButtonSelected!] == e
                        ? primaryColor
                        : const Color.fromARGB(255, 235, 235, 235),
                  ),
                  child: Text(e,
                      style: employeeQuantityData[radioButtonSelected!] == e
                          ? textTheme.bodyMedium!.copyWith(color: Colors.white)
                          : textTheme.bodyMedium!),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
