import 'package:flutter/material.dart';
import 'package:studenthub/constants/app_theme.dart';

class MessageReceiveWidget extends StatelessWidget {
  const MessageReceiveWidget({
    super.key,
    required this.meId,
    required this.screenSize,
    required this.colorTheme, this.messageList, required this.index,
  });

  final int meId;
  final Size screenSize;
  final ColorScheme colorTheme;
  final dynamic messageList;
  final int index;

  @override
  Widget build(BuildContext context) {
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
            constraints: BoxConstraints(maxWidth: screenSize.width * 0.65),
            padding: const EdgeInsets.fromLTRB(14, 10, 8, 4),
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 245, 245, 245),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 6),
                  child: Text(
                    messageList[index].content ?? '',
                    style: TextStyle(color: colorTheme.black),
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
                          color: Color.fromARGB(255, 80, 80, 80)),
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
