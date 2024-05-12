import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:studenthub/constants/app_theme.dart';
import 'package:studenthub/constants/colors.dart';
import 'package:studenthub/models/common/interview_model.dart';
import 'package:studenthub/services/interview/interview.dart';
import 'package:studenthub/ui/home/messages/chat_detail_screen/zego/zego.dart';
import 'package:studenthub/utils/helper.dart';
import 'package:studenthub/widgets/dialog.dart';

class InterviewWidget extends StatelessWidget {
  const InterviewWidget({
    super.key,
    required this.colorTheme,
    required this.interview,
  });
  final ColorScheme colorTheme;
  final Interview interview;

  String convertDateTimeFormat(String isoDateTime) {
    if (isoDateTime.isEmpty) return '';
    DateTime dateTime = DateTime.parse(isoDateTime);

    String formattedDateTime =
        ' ${_twoDigits(dateTime.hour)}:${_twoDigits(dateTime.minute)} ${dateTime.year}-${_twoDigits(dateTime.month)}-${_twoDigits(dateTime.day)}';

    return formattedDateTime;
  }

  String _twoDigits(int n) {
    if (n >= 10) {
      return "$n";
    }
    return "0$n";
  }

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    final InterviewService _interviewService = InterviewService();

    return Container(
      margin: const EdgeInsets.only(top: 10, left: 20, right: 20),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
      decoration: BoxDecoration(
          border: Border(
              bottom: BorderSide(width: 1, color: colorTheme.hintColor!))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  interview.title ?? '',
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
              ),
              Text(
                checkDateTime(interview.createdAt ?? ''),
                style: textTheme.bodySmall!.copyWith(
                    fontWeight: FontWeight.w400, color: colorTheme.grey),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            "Start Time: ${convertDateTimeFormat(interview.startTime ?? '')}",
            style: textTheme.bodyMedium,
          ),
          const SizedBox(
            height: 6,
          ),
          Text(
            "End Time: ${convertDateTimeFormat(interview.endTime ?? '')}",
            style: textTheme.bodyMedium,
          ),
          const SizedBox(
            height: 16,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                  minimumSize: const Size(
                    100,
                    40,
                  ),
                ),
                onPressed: () {
                  _interviewService
                      .checkAvailability(
                          interview.meetingRoom['meeting_room_code'],
                          interview.meetingRoom['meeting_room_code'])
                      .then((value) {
                    if (value.data!) {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => VideoCallPage(
                            conferenceID:
                                interview.meetingRoom['meeting_room_code'],
                          ),
                        ),
                      );
                    } else {
                      showDialogCustom(context,
                          title: 'Error',
                          image: 'lib/assets/images/empty_data.png',
                          subtitle: 'The meeting room is not available',
                          textButtom: 'OK', onSave: () {
                        Navigator.pop(context);
                      });
                    }
                  });
                },
                child: const Text(
                  "Join",
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
