import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:studenthub/constants/app_theme.dart';
import 'package:studenthub/constants/colors.dart';
import 'package:studenthub/core/show_modal_bottomSheet.dart';
import 'package:studenthub/models/common/interview_model.dart';
import 'package:studenthub/services/interview/interview.dart';
import 'package:studenthub/ui/home/messages/widgets/get_more_action_widget.dart';
import 'package:studenthub/utils/helper.dart';
import 'package:studenthub/utils/logger.dart';

class InterviewReceiveWidget extends StatelessWidget {
  const InterviewReceiveWidget(
      {super.key,
      required this.meId,
      required this.screenSize,
      required this.colorTheme,
      this.messageList,
      required this.index,
      required this.join});

  final int meId;
  final Size screenSize;
  final ColorScheme colorTheme;
  final dynamic messageList;
  final int index;
  final void Function(dynamic data) join;
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
    InterviewService _interviewService = InterviewService();
    // logger.d(messageList[index].interview.id);
    bool isCancel = messageList[index].interview.disableFlag == 1;

    return Container(
      margin: EdgeInsets.only(
          top: index + 1 < messageList.length
              ? !(messageList[index + 1].sender['id'] == meId)
                  ? 3
                  : 15
              : 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (index + 1 < messageList.length)
            (messageList[index + 1].sender['id'] != meId)
                ? const SizedBox(
                    width: 28,
                  )
                : const SizedBox(
                    width: 28,
                    height: 28,
                    child: CircleAvatar(
                      backgroundImage:
                          AssetImage('lib/assets/images/circle_avatar.png'),
                    ),
                  ),
          const SizedBox(
            width: 10,
          ),
          Container(
            width: screenSize.width * 0.79,
            // constraints: BoxConstraints(maxWidth: screenSize.width * 0.8),
            padding: isCancel
                ? const EdgeInsets.symmetric(horizontal: 10, vertical: 12)
                : const EdgeInsets.fromLTRB(14, 10, 8, 4),
            decoration: BoxDecoration(
                color: isCancel
                    ? Theme.of(context).colorScheme.chatColorContentBackground
                    : const Color.fromARGB(255, 245, 245, 245),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                    color: const Color.fromARGB(255, 210, 210, 210),
                    width: isCancel ? 2 : 0)),
            child: isCancel
                ? Text(
                    'A meeting ${messageList[index].interview.title ?? ''} has been canceled.',
                    style: const TextStyle(
                      fontStyle: FontStyle.italic,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Color.fromARGB(255, 190, 190, 190),
                    ),
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            messageList[index].interview.title ?? '',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: colorTheme.black,
                            ),
                          ),
                          // const Spacer(),
                          // Text(messagesData[index]['duration']
                          //     as String),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Text(
                        "Start Time: ${convertDateTimeFormat(messageList[index].interview.startTime ?? '')}",
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              color: const Color.fromARGB(255, 80, 80, 80),
                            ),
                      ),
                      const SizedBox(
                        height: 6,
                      ),
                      Text(
                        "End Time: ${convertDateTimeFormat(messageList[index].interview.endTime ?? '')}",
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              color: const Color.fromARGB(255, 80, 80, 80),
                            ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(5),
                            decoration: const BoxDecoration(
                              color: Color.fromARGB(255, 245, 245, 245),
                              shape: BoxShape.circle,
                            ),
                            margin: const EdgeInsets.only(right: 10, left: 10),
                            child: InkWell(
                              onTap: () {
                                showModalBottomSheetCustom(context,
                                    widgetBuilder: MoreActionChatDetail(
                                      isEdit: true,
                                      callBack: (value) {
                                        if (value == true) {
                                          _interviewService.cancelInterview(
                                              messageList[index].interview.id);
                                        } else if (value == false) {
                                        } else {
                                          _interviewService.updateInterview(
                                              messageList[index].interview.id, {
                                            "title": value['title'],
                                            "startTime": convertToIso8601(
                                                value['start_date'],
                                                value['time_start']),
                                            "endTime": convertToIso8601(
                                                value['end_date'],
                                                value['time_end']),
                                          });
                                        }
                                      },
                                    ));
                              },
                              child: const FaIcon(
                                FontAwesomeIcons.ellipsis,
                                size: 16,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              elevation: 0,
                              minimumSize: const Size(100, 40),
                            ),
                            onPressed: () {
                              // JitsiMeetService.instance.join();
                              join(messageList[index].interview);
                            },
                            child: const Text(
                              "Join",
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            checkDateTime(messageList[index].createdAt ?? ''),
                            style: const TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w400,
                              color: Color.fromARGB(255, 80, 80, 80),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
          ),
        ],
      ),
    );
  }
}
