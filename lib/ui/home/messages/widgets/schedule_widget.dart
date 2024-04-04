import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:studenthub/constants/app_theme.dart';
import 'package:studenthub/core/date_picker_formfield.dart';
import 'package:studenthub/core/text_field_custom.dart';
import 'package:studenthub/core/time_picker.dart';
import 'package:studenthub/utils/logger.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class ScheduleWidget extends StatefulWidget {
  const ScheduleWidget({super.key, this.onSave});

  final Function(dynamic value)? onSave;

  @override
  State<ScheduleWidget> createState() => _ScheduleWidgetState();
}

class _ScheduleWidgetState extends State<ScheduleWidget> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final formkey = GlobalKey<FormBuilderState>();
    return FormBuilder(
      key: formkey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Schedule a video call interview',
            style: theme.textTheme.titleMedium!.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            'Title',
            style: theme.textTheme.bodyMedium!.copyWith(),
          ),
          const SizedBox(height: 10),
          TextFieldFormCustom(
            fillColor: Colors.white,
            autofocus: true,
            icon: FaIcon(
              FontAwesomeIcons.tag,
              size: 18,
              color: theme.colorScheme.grey!,
            ),
            name: 'title',
            hintText: 'Catch up meeting',
          ),
          const SizedBox(height: 10),
          Text(
            'Start Time',
            style: theme.textTheme.bodyMedium!.copyWith(),
          ),
          const SizedBox(height: 10),
          const Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                flex: 1,
                child: DatePickerCustom(
                  view: DateRangePickerView.month,
                  name: 'start_date',
                  labelText: 'Start Time',
                  hintText: 'Start Time',
                ),
              ),
              SizedBox(width: 10),
              Expanded(
                child: TimePickerCustom(
                  name: 'time_start',
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            'End Time',
            style: theme.textTheme.bodyMedium!.copyWith(),
          ),
          const SizedBox(height: 10),
          const Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                flex: 1,
                child: DatePickerCustom(
                  view: DateRangePickerView.month,
                  name: 'end_date',
                  hintText: 'End Date',
                  labelText: 'End Date',
                ),
              ),
              SizedBox(width: 10),
              Expanded(
                child: TimePickerCustom(
                  name: 'time_end',
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Text(
            'Duration: 60 minutes ',
            style: theme.textTheme.bodyMedium!.copyWith(),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 56),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    'Cancel',
                    style: theme.textTheme.bodyMedium!.copyWith(
                        color: Colors.white, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 56),
                  ),
                  onPressed: () {
                    if (formkey.currentState?.saveAndValidate() ?? false) {
                      logger.d(formkey.currentState?.value);
                      widget.onSave?.call(formkey.currentState?.value);
                      Navigator.pop(context);
                    }
                  },
                  child: Text(
                    'Send Invite',
                    style: theme.textTheme.bodyMedium!.copyWith(
                        color: Colors.white, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
