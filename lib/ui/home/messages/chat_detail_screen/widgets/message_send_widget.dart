import 'package:flutter/material.dart';
import 'package:studenthub/constants/colors.dart';

class MessageSendWidget extends StatelessWidget {
  const MessageSendWidget({
    super.key,
    required this.screenSize,
    required this.meId,
    this.messageList,
    required this.index,
  });

  final Size screenSize;
  final int meId;
  final dynamic messageList;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          constraints: BoxConstraints(maxWidth: screenSize.width * 0.7),
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
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 6),
                child: Text(
                  messageList[index].content ?? '',
                  style: const TextStyle(color: Colors.white),
                ),
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    messageList[index].createdAt??'',
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