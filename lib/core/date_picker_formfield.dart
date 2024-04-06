import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:studenthub/constants/colors.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class DatePickerCustom extends StatefulWidget {
  const DatePickerCustom({
    super.key,
    required this.view,
    required this.name,
    this.hintText,
    this.labelText,
    this.initialDate,
  });

  final DateRangePickerView view;
  final String name;
  final String? hintText;
  final String? labelText;
  final DateTime? initialDate;
  @override
  State<DatePickerCustom> createState() => _DatePickerCustomState();
}

class _DatePickerCustomState extends State<DatePickerCustom> {
  final textController = TextEditingController();
  String _selectedDate = '';
  String _dateCount = '';
  String _range = '';
  String _rangeCount = '';

  @override
  void initState() {
    super.initState();
    if (widget.initialDate != null) {
      textController.text =
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
              controller: textController,
              scrollPadding: const EdgeInsets.all(0),
              decoration: InputDecoration(
                labelText: widget.labelText ?? 'Date of Birth',
                hintText: widget.hintText ?? 'Date of Birth',
                contentPadding: EdgeInsets.symmetric(
                  vertical: 0,
                  horizontal: 10,
                ),
                isDense: true,
                hintStyle: TextStyle(
                  color: Colors.grey[400],
                  fontSize: 16,
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
              onSaved: (newValue) {
                field.didChange(newValue);
                field.save();
                textController.text = newValue!;
              },
              onTap: () async {
                DateTime? data =
                    await showDatePickerCustom(context, view: widget.view);
                if (data != null) {
                  field.didChange(data);
                  field.save();
                  textController.text =
                      DateFormat('dd/MM/yyyy').format(data).toString();
                }
              },
            );
          },
        ));
  }

  void _onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
    setState(() {
      if (args.value is PickerDateRange) {
        _range = '${DateFormat('dd/MM/yyyy').format(args.value.startDate)} -'
            // ignore: lines_longer_than_80_chars
            ' ${DateFormat('dd/MM/yyyy').format(args.value.endDate ?? args.value.startDate)}';
      } else if (args.value is DateTime) {
        _selectedDate = args.value.toString();
      } else if (args.value is List<DateTime>) {
        _dateCount = args.value.length.toString();
      } else {
        _rangeCount = args.value.length.toString();
      }
    });
  }

  Future<DateTime?> showDatePickerCustom(
    BuildContext context, {
    DateTime? initialDate,
    DateTime? firstDate,
    DateTime? lastDate,
    DateRangePickerSelectionMode selectionMode =
        DateRangePickerSelectionMode.single,
    DateRangePickerView view = DateRangePickerView.month,
    DateRangePickerMonthViewSettings monthViewSettings =
        const DateRangePickerMonthViewSettings(firstDayOfWeek: 1),
    bool showActionButtons = true,
    DateRangePickerHeaderStyle headerStyle = const DateRangePickerHeaderStyle(
        backgroundColor: primaryColor,
        textAlign: TextAlign.center,
        textStyle: TextStyle(
          fontStyle: FontStyle.normal,
          fontSize: 25,
          letterSpacing: 5,
          color: Color(0xffff5eaea),
        )),
  }) async {
    DateTime value = await showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                ),
                child: Theme(
                  data: ThemeData.light().copyWith(
                    colorScheme: const ColorScheme.light(
                      primary: primaryColor,
                      onPrimary: Colors.white,
                      surface: primaryColor,
                      onSurface: Colors.black,
                    ),
                    dialogBackgroundColor: Colors.white,
                  ),
                  child: SfDateRangePicker(
                    backgroundColor: Colors.white,
                    onSelectionChanged: _onSelectionChanged,
                    showActionButtons: showActionButtons,
                    cancelText: 'CANCEL',
                    confirmText: 'OK',
                    initialSelectedDate: DateTime.now(),
                    headerStyle: headerStyle,
                    view: view,
                    monthViewSettings: monthViewSettings,
                    selectionMode: selectionMode,
                    selectionColor: primaryColor,
                    onSubmit: (p0) {
                      Navigator.pop(context, p0);
                    },
                    onCancel: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );

    return value;
  }
}
