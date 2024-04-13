// ignore_for_file: unnecessary_null_comparison

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:studenthub/constants/app_theme.dart';
import 'package:studenthub/constants/colors.dart';
import 'package:studenthub/core/show_modal_bottomSheet.dart';
import 'package:studenthub/ui/home/messages/widgets/get_more_action_widget.dart';
import 'package:studenthub/utils/logger.dart';
import 'package:studenthub/utils/meeting.dart';

class ChatDetailScreen extends StatefulWidget {
  const ChatDetailScreen({Key? key}) : super(key: key);

  @override
  _ChatDetailScreenState createState() => _ChatDetailScreenState();
}

class _ChatDetailScreenState extends State<ChatDetailScreen> {
  final messagesData = [
    {
      'isMe': true,
      'time': '12:27',
      'content': 'Hello',
    },
    {
      'isMe': false,
      'time': '12:38',
      'content': 'Hi Luis, how are you doing?',
    },
    {
      'isMe': true,
      'time': '12:39',
      'content':
          'I\'ve been having a problem with my computer. I know you\'re an engineer so I thought you might be able to help me.',
    },
    {
      'isMe': false,
      'time': '12:59',
      'content':
          'Yes, I was working on it last night and everything was fine, but this morning.',
    },
    {
      'isMe': true,
      'time': '12:59',
      'content': 'I have a file that I can\'t open for some reason.',
    },
    {
      'isMe': true,
      'time': '12:27',
      'content': 'Hello',
    },
    {
      'isMe': true,
      'time': '12:39',
      'content': 'Sorry to bother you. I have a question for you',
    },
    {
      'isMe': false,
      'time': '12:59',
      'content':
          'Yes, I was working on it last night and everything was fine, but this morning.',
    },
    {
      'isMe': false,
      'time': '12:38',
      'content':
          'I\'ve been having a problem with my computer. I know you\'re an engineer so I thought you might be able to help me.',
    },
    {
      'isMe': true,
      'time': '12:39',
      'content': 'Sorry to bother you. I have a question for you',
    },
    {
      'isMe': false,
      'time': '12:59',
      'content':
          'Yes, I was working on it last night and everything was fine, but this morning.',
    },
    {
      'isMe': true,
      'time': '12:59',
      'content': 'I have a file that I can\'t open for some reason.',
    },
    {
      'isMe': false,
      'time': '12:38',
      'content':
          'I\'ve been having a problem with my computer. I know you\'re an engineer so I thought you might be able to help me.',
    },
    {
      'isMe': true,
      'time': '12:39',
      'content': 'Sorry to bother you. I have a question for you',
    },
    {
      'isMe': false,
      'time': '12:59',
      'content':
          'Yes, I was working on it last night and everything was fine, but this morning.',
    },
    {
      'isMe': true,
      'time': '12:59',
      'content': 'I have a file that I can\'t open for some reason.',
    },
  ];

  final messageController = TextEditingController();
  final FocusNode _messageFocus = FocusNode();
  final scrollController = ScrollController();

  @override
  void initState() {
    _messageFocus.addListener(_onFocusChange);
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   showWelcomeDialog(context);
    // });
    super.initState();
  }

  void _scrollDown() {
    scrollController.animateTo(
      scrollController.position.maxScrollExtent,
      duration: const Duration(milliseconds: 100),
      curve: Curves.fastOutSlowIn,
    );
  }

  @override
  void dispose() {
    super.dispose();
    _messageFocus.removeListener(_onFocusChange);

    _messageFocus.dispose();
  }

  void _onFocusChange() {
    setState(() {});
  }

  String getCurrentTime() {
    DateTime now = DateTime.now(); // Lấy thời gian hiện tại
    String formattedTime =
        DateFormat('HH:mm').format(now); // Định dạng thời gian thành giờ:phút
    return formattedTime;
  }

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    var colorTheme = Theme.of(context).colorScheme;
    var screenSize = MediaQuery.of(context).size;

    return Container(
      color: Colors.white,
      child: SafeArea(
        top: false,
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: PreferredSize(
            preferredSize: const Size(double.infinity, 64),
            child: AppBar(
              titleSpacing: 0,
              title: Row(
                children: [
                  const SizedBox(
                    width: 36,
                    height: 36,
                    child: CircleAvatar(
                      backgroundImage:
                          AssetImage('lib/assets/images/circle_avatar.png'),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    'Dinh Nguyen Duy Khang',
                    style: textTheme.bodyLarge!
                        .copyWith(fontWeight: FontWeight.w600),
                  ),
                ],
              ),
              centerTitle: false,
              actions: [
                Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: InkWell(
                    onTap: () {
                      showModalBottomSheetCustom(context,
                          widgetBuilder: MoreActionChatDetail(
                        callBack: (value) {
                          setState(() {
                            messagesData.insert(0, {
                              'isMe': true,
                              'isSchedule': true,
                              'start_date': value['start_date'],
                              'end_date': value['end_date'],
                              'time_start': value['time_start'],
                              'time_end': value['time_end'],
                              'title': value['title'],
                              'duration': "60 minutes",
                              'time': '12:59',
                              'content': value['title'],
                            });
                          });
                        },
                      ));
                    },
                    child: Container(
                      height: 39,
                      width: 39,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: const Color.fromARGB(255, 245, 245, 245),
                      ),
                      alignment: Alignment.center,
                      child: FaIcon(
                        FontAwesomeIcons.bars,
                        color: colorTheme.black,
                        size: 21,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          body: GestureDetector(
            onTap: () {
              FocusScope.of(context).requestFocus(FocusNode());
            },
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 72),
              child: ListView.builder(
                controller: scrollController,
                shrinkWrap: true,
                itemCount: messagesData.length,
                reverse: true,
                itemBuilder: (context, index) => messagesData[index]['isMe']
                        as bool
                    ? Builder(builder: (context) {
                        if (messagesData[index]['isSchedule'] == null) {
                          messagesData[index]['isSchedule'] = false;
                        }
                        if (messagesData[index]['isSchedule'] as bool ==
                            false) {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                constraints: BoxConstraints(
                                    maxWidth: screenSize.width * 0.7),
                                margin: EdgeInsets.only(
                                    top: index + 1 < messagesData.length
                                        ? (messagesData[index + 1]['isMe']
                                                as bool)
                                            ? 3
                                            : 15
                                        : 10),
                                padding:
                                    const EdgeInsets.fromLTRB(14, 10, 8, 4),
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
                                        messagesData[index]['content']
                                            as String,
                                        style: const TextStyle(
                                            color: Colors.white),
                                      ),
                                    ),
                                    Row(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Text(
                                          messagesData[index]['time'] as String,
                                          style: const TextStyle(
                                              fontSize: 11,
                                              fontWeight: FontWeight.w400,
                                              color: Color.fromARGB(
                                                  255, 230, 230, 230)),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          );
                        } else {
                          return Container(
                            margin: const EdgeInsets.only(top: 10, left: 20),
                            padding: const EdgeInsets.all(15),
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 245, 245, 245),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                        messagesData[index]['title'] as String),
                                    const Spacer(),
                                    Text(messagesData[index]['duration']
                                        as String),
                                  ],
                                ),
                                const SizedBox(height: 24),
                                Text(
                                  "Start Time: ${messagesData[index]['start_date'] as String} ${messagesData[index]['time_start'] as String}",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .copyWith(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400,
                                      ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    Text(
                                      "End Time: ",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium!
                                          .copyWith(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400,
                                          ),
                                    ),
                                    const SizedBox(width: 9),
                                    Text(
                                      "${messagesData[index]['end_date'] as String} ${messagesData[index]['time_end'] as String}",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium!
                                          .copyWith(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400,
                                          ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 24,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    const Spacer(),
                                    Container(
                                      padding: const EdgeInsets.all(5),
                                      decoration: const BoxDecoration(
                                        color:
                                            Color.fromARGB(255, 245, 245, 245),
                                        shape: BoxShape.circle,
                                      ),
                                      margin: const EdgeInsets.only(
                                          right: 10, left: 10),
                                      child: InkWell(
                                        onTap: () {
                                          showModalBottomSheetCustom(context,
                                              widgetBuilder:
                                                  const MoreActionChatDetail(
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
                                    Expanded(
                                      child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          elevation: 0,
                                          minimumSize:
                                              const Size(double.infinity, 45),
                                        ),
                                        onPressed: () {
                                          JitsiMeetService.instance.join();
                                        },
                                        child: const Text(
                                          "Join",
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          );
                        }
                      })
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (index + 1 < messagesData.length)
                            !(messagesData[index + 1]['isMe'] as bool)
                                ? const SizedBox(
                                    width: 28,
                                  )
                                : const SizedBox(
                                    width: 28,
                                    height: 28,
                                    child: CircleAvatar(
                                      backgroundImage: AssetImage(
                                          'lib/assets/images/circle_avatar.png'),
                                    ),
                                  ),
                          const SizedBox(
                            width: 10,
                          ),
                          Container(
                            constraints: BoxConstraints(
                                maxWidth: screenSize.width * 0.65),
                            margin: EdgeInsets.only(
                                top: index + 1 < messagesData.length
                                    ? !(messagesData[index + 1]['isMe'] as bool)
                                        ? 3
                                        : 15
                                    : 10),
                            padding: const EdgeInsets.fromLTRB(14, 10, 8, 4),
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 245, 245, 245),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(right: 6),
                                  child: Text(
                                    messagesData[index]['content'] as String,
                                    style: TextStyle(color: colorTheme.black),
                                  ),
                                ),
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      messagesData[index]['time'] as String,
                                      style: const TextStyle(
                                          fontSize: 11,
                                          fontWeight: FontWeight.w400,
                                          color:
                                              Color.fromARGB(255, 80, 80, 80)),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
              ),
            ),
          ),
          bottomSheet: Container(
            color: Colors.white,
            padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    const FaIcon(
                      FontAwesomeIcons.solidCalendarCheck,
                      size: 27,
                      color: primaryColor,
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    Expanded(
                      child: TextField(
                        onChanged: (value) {
                          if (value.isEmpty || value.length == 1) {
                            setState(() {});
                          }
                        },
                        controller: messageController,
                        keyboardType: TextInputType.multiline,
                        maxLines: 3,
                        minLines: 1,
                        focusNode: _messageFocus,
                        cursorHeight: 18,
                        cursorColor: Colors.black,
                        style: textTheme.bodyMedium,
                        decoration: InputDecoration(
                          hintText: 'Your messages...',
                          hintStyle: textTheme.bodyMedium!.copyWith(
                              color: Theme.of(context).colorScheme.hintColor),
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 8),
                          isDense: true,
                          filled: true,
                          fillColor: const Color.fromARGB(255, 245, 245, 245),
                          errorStyle: const TextStyle(height: 0),
                          border: OutlineInputBorder(
                            borderSide: const BorderSide(
                              width: 0,
                              style: BorderStyle.none,
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              width: 0,
                              style: BorderStyle.none,
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          // disabledBorder: const OutlineInputBorder(
                          //   borderSide: BorderSide(width: 0),
                          //   borderRadius: BorderRadius.all(Radius.circular(8)),
                          // ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              width: 0,
                              style: BorderStyle.none,
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          minimumSize: Size.zero,
                          backgroundColor: primaryColor,
                          shape: const CircleBorder(),
                          padding: const EdgeInsets.fromLTRB(8, 8, 10, 10),
                        ),
                        onPressed: () {
                          messagesData.insert(
                            0,
                            {
                              'isMe': true,
                              'time': getCurrentTime,
                              'content': messageController.text,
                            },
                          );
                          messageController.clear();
                          // _scrollDown();
                          // scrollController.jumpTo(
                          //     scrollController.position.maxScrollExtent);
                          setState(() {});
                        },
                        child: const FaIcon(
                          FontAwesomeIcons.solidPaperPlane,
                          size: 20,
                          color: Colors.white,
                        ))
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
