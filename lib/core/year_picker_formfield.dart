import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:studenthub/constants/colors.dart';
import 'package:studenthub/constants/key_translator.dart';

class PickerYearCustom extends StatefulWidget {
  const PickerYearCustom({
    super.key,
    required this.name,
    this.hintText,
    this.labelText,
    this.initValue,
    this.autovalidateModel,
    this.validator,
    this.onSave,
  });

  final String name;
  final String? hintText;
  final String? labelText;
  final DateTime? initValue;
  final AutovalidateMode? autovalidateModel;
  final String? Function(String?)? validator;
  final Function? onSave;

  @override
  State<PickerYearCustom> createState() => _PickerYearCustomState();
}

class _PickerYearCustomState extends State<PickerYearCustom> {
  DateTime selectedDate = DateTime.now();
  final texController = TextEditingController();
  final _textFormKey = GlobalKey<FormBuilderFieldState>();

  Future<DateTime?> showYearPicker(BuildContext context) async {
    DateTime? data = await showDialog<DateTime?>(
      context: context,
      builder: (BuildContext context) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: const ColorScheme.light(
              primary: primaryColor,
              onPrimary: Colors.white,
              surface: Colors.blue,
              onSurface: Colors.black,
            ),
            dialogBackgroundColor: Colors.white,
          ),
          child: AlertDialog(
            backgroundColor: Colors.white,
            surfaceTintColor: Colors.white,
            // title: const Text("Select Year"),
            title: Text(selectYearTitleKey.tr()),
            content: StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
                return SizedBox(
                  width: 300,
                  height: 300,
                  child: YearPicker(
                    firstDate: DateTime(DateTime.now().year - 100, 1),
                    lastDate: DateTime(DateTime.now().year),
                    selectedDate: widget.initValue ??
                        _textFormKey.currentState?.value ??
                        DateTime.now(),
                    onChanged: (DateTime dateTime) {
                      Navigator.pop(context, dateTime);
                    },
                  ),
                );
              },
            ),
          ),
        );
      },
    );
    return data;
  }

  @override
  void initState() {
    super.initState();
    if (widget.initValue != null) {
      texController.text = widget.initValue!.year.toString();
    }
  }

  @override
  void dispose() {
    super.dispose();
    texController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FormBuilderField(
      key: _textFormKey,
      name: widget.name,
      builder: (field) {
        return Container(
          alignment: Alignment.center,
          child: TextFormField(
            style: TextStyle(
              color: Colors.grey[600],
              fontSize: 16,
            ),
            autovalidateMode: widget.autovalidateModel,
            validator: widget.validator,
            controller: texController,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(
                vertical: 0,
                horizontal: 10,
              ),
              isDense: true,
              hintText: widget.hintText ?? 'Year',
              labelText: widget.labelText ?? 'Year',
              hintStyle: TextStyle(
                color: Colors.grey[600],
                fontSize: 16,
              ),
              labelStyle: TextStyle(
                color: Colors.grey[600],
                fontSize: 16,
              ),
              prefixIcon: const Icon(
                Icons.calendar_today,
                size: 16,
                color: Colors.black,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
            readOnly: true,
            onSaved: (newValue) {
              if (newValue == null || newValue == '') {
                return;
              }
              field.didChange(newValue);
              field.save();
              texController.text = newValue;
              if (widget.onSave != null) {
                widget.onSave!();
              }
            },
            onTap: () async {
              DateTime? data = await showYearPicker(context);
              if (data != null) {
                field.didChange(data);
                field.save();
                texController.text = data.year.toString();
                if (widget.onSave != null) {
                  widget.onSave!();
                }
              }
            },
          ),
        );
      },
    );
  }
}
