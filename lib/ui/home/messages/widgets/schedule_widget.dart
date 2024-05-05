import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:studenthub/constants/app_theme.dart';
import 'package:studenthub/constants/colors.dart';
import 'package:studenthub/constants/key_translator.dart';
import 'package:studenthub/core/date_picker_formfield.dart';
import 'package:studenthub/core/text_field_custom.dart';
import 'package:studenthub/core/time_picker.dart';
import 'package:studenthub/models/company/schedual_modal.dart';
import 'package:studenthub/utils/helper.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class ScheduleWidget extends StatefulWidget {
  const ScheduleWidget({super.key, this.onSave, this.schedule});

  final Function(dynamic value)? onSave;
  final Schedule? schedule;

  @override
  State<ScheduleWidget> createState() => _ScheduleWidgetState();
}

class _ScheduleWidgetState extends State<ScheduleWidget> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final formkey = GlobalKey<FormBuilderState>();
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(
              left: 20,
              right: 20,
              bottom: MediaQuery.of(context).viewInsets.bottom),
          child: FormBuilder(
            key: formkey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  // 'Schedule a video call interview',
                  scheduleVideoCallInterviewKey.tr(),
                  style: theme.textTheme.titleMedium!.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  // 'Title',
                  titleKey.tr(),

                  style: theme.textTheme.bodyMedium!.copyWith(),
                ),
                TextFieldFormCustom(
                  fillColor: Colors.white,
                  initialValue: widget.schedule?.title != null
                      ? widget.schedule?.title ?? ''
                      : null,
                  autofocus: true,
                  icon: FaIcon(
                    FontAwesomeIcons.tag,
                    size: 18,
                    color: theme.colorScheme.grey!,
                  ),
                  name: 'title',
                  // hintText: 'Catch up meeting',
                  hintText: catchUpMeetingKey.tr(),
                ),
                const SizedBox(height: 10),
                Text(
                  // 'Start Time',
                  startTimeKey.tr(),
                  style: theme.textTheme.bodyMedium!.copyWith(),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Expanded(
                      flex: 1,
                      child: DatePickerCustom(
                        view: DateRangePickerView.month,
                        name: 'start_date',
                        initialDate: widget.schedule?.startTime != null
                            ? stringToDateTime(widget.schedule?.startTime)
                            : null,
                        // hintText: 'Start Time',
                        // labelText: 'Start Time',
                        hintText: startDatePlaceHolderKey.tr(),
                        labelText: startDatePlaceHolderKey.tr(),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: TimePickerCustom(
                        name: 'time_start',
                        initialDate: widget.schedule?.startTime != null
                            ? stringToDateTime(widget.schedule?.startTime)
                            : null,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Text(
                  // 'End Time',
                  endTimeKey.tr(),
                  style: theme.textTheme.bodyMedium!.copyWith(),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Expanded(
                      flex: 1,
                      child: DatePickerCustom(
                        view: DateRangePickerView.month,
                        initialDate: widget.schedule?.startTime != null
                            ? stringToDateTime(widget.schedule?.startTime)
                            : null,
                        name: 'end_date',
                        // hintText: 'End Date',
                        // labelText: 'End Date',
                        hintText: endDatePlaceHolderKey.tr(),
                        labelText: endDatePlaceHolderKey.tr(),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: TimePickerCustom(
                        initialDate: widget.schedule?.startTime != null
                            ? stringToDateTime(widget.schedule?.startTime)
                            : null,
                        name: 'time_end',
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Text(
                  // 'Duration: 60 minutes ',
                  durationKey.tr(namedArgs: {"value": 60.toString()}),
                  style: theme.textTheme.bodyMedium!.copyWith(),
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: Colors.white,
                          elevation: 0,
                          minimumSize: const Size(double.infinity, 56),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                            side: const BorderSide(
                                color: primaryColor, width: 2.0),
                          ),
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          // 'Cancel',
                          cancelBtnKey.tr(),
                          style: theme.textTheme.bodyMedium!.copyWith(
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
                          minimumSize: const Size(double.infinity, 56),
                        ),
                        onPressed: () {
                          if (formkey.currentState?.saveAndValidate() ??
                              false) {
                            widget.onSave?.call(formkey.currentState?.value);

                            Navigator.pop(context);
                          }
                        },
                        child: Text(
                          // 'Send Invite',
                          sendInviteBtnKey.tr(),
                          style: theme.textTheme.bodyMedium!.copyWith(
                              color: Colors.white, fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
