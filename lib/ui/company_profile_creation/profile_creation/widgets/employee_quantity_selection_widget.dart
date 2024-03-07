import 'package:flutter/material.dart';
import 'package:studenthub/constants/colors.dart';

class EmployeeQuantitySelectionWidget extends StatefulWidget {
  const EmployeeQuantitySelectionWidget({Key? key}) : super(key: key);

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

  String? radioButtonSelected;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    radioButtonSelected = employeeQuantityData[0];
  }

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'How many people are in your company?',
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
                    radioButtonSelected = e;
                  });
                },
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 24),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: radioButtonSelected == e
                        ? primaryColor
                        : const Color.fromARGB(255, 235, 235, 235),
                  ),
                  child: Text(e,
                      style: radioButtonSelected == e
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
