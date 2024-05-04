import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:studenthub/constants/colors.dart';
import 'package:studenthub/constants/key_translator.dart';
import 'package:studenthub/utils/helper.dart';
import 'package:time_pickerr/time_pickerr.dart';

class TimePickerCustom extends StatefulWidget {
  const TimePickerCustom({
    super.key,
    required this.name,
    this.hintText,
    this.labelText,
    this.initialDate,
  });

  final String name;
  final String? hintText;
  final String? labelText;
  final DateTime? initialDate;
  @override
  State<TimePickerCustom> createState() => _DatePickerCustomState();
}

class _DatePickerCustomState extends State<TimePickerCustom> {
  final texController = TextEditingController();
  @override
  void initState() {
    super.initState();
    if (widget.initialDate != null) {
      texController.text =
          DateFormat('dd/MM/yyyy').format(widget.initialDate!).toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 50,
        child: FormBuilderField(
          name: widget.name,
          builder: (field) {
            return TextFormField(
              style: TextStyle(
                color: Colors.grey[400],
                fontSize: 16,
              ),
              controller: texController,
              scrollPadding: const EdgeInsets.all(0),
              decoration: InputDecoration(
                isDense: true,
                // labelText: widget.labelText ?? 'Time',
                // hintText: widget.hintText ?? 'Time',
                labelText: widget.labelText ?? timePlaceHolderKey.tr(),
                hintText: widget.hintText ?? timePlaceHolderKey.tr(),
                hintStyle: TextStyle(
                  color: Colors.grey[400],
                  fontSize: 16,
                ),
                contentPadding: const EdgeInsets.symmetric(
                  vertical: 0,
                  horizontal: 10,
                ),
                labelStyle: TextStyle(
                  color: Colors.grey[400],
                  fontSize: 16,
                ),
                prefixIcon: Icon(
                  Icons.calendar_today_rounded,
                  size: 16,
                  color: Colors.grey[500],
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              readOnly: true,
              onChanged: (value) {},
              onSaved: (newValue) {
                field.didChange(newValue);
                field.save();
                texController.text = newValue!;
              },
              onTap: () async {
                DateTime? data = await showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return Theme(
                      data: ThemeData(
                          primarySwatch: Colors.blue,
                          dialogBackgroundColor: Colors.white,
                          textTheme: const TextTheme(
                            bodySmall: TextStyle(color: Colors.black),
                            labelLarge: TextStyle(color: Colors.black),
                            bodyLarge: TextStyle(color: Colors.black),
                            bodyMedium: TextStyle(color: Colors.black),
                            titleLarge: TextStyle(color: Colors.black),
                            titleMedium: TextStyle(color: Colors.black),
                            titleSmall: TextStyle(color: Colors.black),
                            displayLarge: TextStyle(color: Colors.black),
                            displaySmall: TextStyle(color: Colors.black),
                            displayMedium: TextStyle(color: Colors.black),
                          ),
                          colorScheme: const ColorScheme.light(
                            primary: Colors.white,
                            secondary: Colors.black,
                          )),
                      child: CustomHourPicker(
                        // title: "Select Time",
                        title: selectTimeBtnKey.tr(),
                        titleStyle: const TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                        positiveButtonText: "OK",
                        positiveButtonStyle: const TextStyle(
                          color: primaryColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                        negativeButtonStyle: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                        // negativeButtonText: "Cancel",
                        negativeButtonText: cancelBtnKey.tr(),
                        onPositivePressed: (context, time) {
                          Navigator.pop(context, time);
                        },
                        onNegativePressed: (context) {
                          Navigator.pop(context);
                        },
                      ),
                    );
                  },
                );
                if (data != null) {
                  field.didChange(data);
                  field.save();
                  texController.text = formatTimeFromDateTime(data);
                }
              },
            );
          },
        ));
  }
}
