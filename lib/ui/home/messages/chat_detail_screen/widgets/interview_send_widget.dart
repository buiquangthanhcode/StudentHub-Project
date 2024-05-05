import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:studenthub/constants/colors.dart';
import 'package:studenthub/core/show_modal_bottomSheet.dart';
import 'package:studenthub/models/common/interview_model.dart';
import 'package:studenthub/ui/home/messages/widgets/get_more_action_widget.dart';

class InterviewSendWidget extends StatelessWidget {
  const InterviewSendWidget({
    super.key,
    required this.meId,
    required this.screenSize,
    required this.colorTheme,
    this.messageList,
    required this.index,
    required this.join,
  });
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
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: screenSize.width * 0.75,
          margin: EdgeInsets.only(
              top: index + 1 < messageList.length
                  ? (messageList[index + 1].sender['id'] == meId)
                      ? 3
                      : 15
                  : 10),
          padding: const EdgeInsets.fromLTRB(14, 10, 8, 4),
          decoration: BoxDecoration(
            color: primaryColor,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    messageList[index].interview.title ?? '',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
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
                    color: Colors.white),
              ),
              const SizedBox(
                height: 6,
              ),
              Text(
                "End Time: ${convertDateTimeFormat(messageList[index].interview.endTime ?? '')}",
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: Colors.white),
              ),
              const SizedBox(
                height: 16,
              ),
              Row(
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
                            widgetBuilder: const MoreActionChatDetail(
                              isEdit: true,
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
                      backgroundColor: Colors.white,
                      elevation: 0,
                      minimumSize: const Size(
                        100,
                        40,
                      ),
                    ),
                    onPressed: () {
                      join(messageList[index].interview);
                    },
                    child: const Text(
                      "Join",
                      style: TextStyle(color: primaryColor),
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
                    messageList[index].createdAt ?? '',
                    style: const TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w400,
                        color: Color.fromARGB(255, 230, 230, 230)),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
