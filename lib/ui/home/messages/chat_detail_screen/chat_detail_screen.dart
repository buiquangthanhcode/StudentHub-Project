// ignore_for_file: unnecessary_null_comparison

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:studenthub/blocs/auth_bloc/auth_bloc.dart';
import 'package:studenthub/blocs/chat_bloc/chat_bloc.dart';
import 'package:studenthub/blocs/chat_bloc/chat_event.dart';
import 'package:studenthub/blocs/chat_bloc/chat_state.dart';
import 'package:studenthub/constants/app_theme.dart';
import 'package:studenthub/constants/colors.dart';
import 'package:studenthub/core/show_modal_bottomSheet.dart';
import 'package:studenthub/models/common/interview_model.dart';
import 'package:studenthub/models/common/message_model.dart';
import 'package:studenthub/models/common/user_model.dart';
import 'package:studenthub/ui/home/messages/chat_detail_screen/widgets/interview_receive_widget.dart';
import 'package:studenthub/ui/home/messages/chat_detail_screen/widgets/interview_send_widget.dart';
import 'package:studenthub/ui/home/messages/chat_detail_screen/widgets/message_receive_widget.dart';
import 'package:studenthub/ui/home/messages/chat_detail_screen/widgets/message_send_widget.dart';
import 'package:studenthub/ui/home/messages/chat_detail_screen/zego/zego.dart';
import 'package:studenthub/ui/home/messages/widgets/get_more_action_widget.dart';
import 'package:studenthub/utils/logger.dart';
import 'package:studenthub/utils/socket.dart';

class ChatDetailScreen extends StatefulWidget {
  const ChatDetailScreen(
      {super.key,
      required this.userId,
      required this.projectId,
      required this.userName});

  final String userName;
  final String userId;
  final String projectId;

  @override
  // ignore: library_private_types_in_public_api
  _ChatDetailScreenState createState() => _ChatDetailScreenState();
}

class _ChatDetailScreenState extends State<ChatDetailScreen> {
  final messageController = TextEditingController();
  final FocusNode _messageFocus = FocusNode();
  final scrollController = ScrollController();
  final socket = SocketService();

  @override
  void initState() {
    _messageFocus.addListener(_onFocusChange);
    socket.initSocket(context, widget.projectId);

    logger.d('userId: ${widget.userId}');
    logger.d('projectId:${widget.projectId}');

    context.read<ChatBloc>().add(
          GetChatWithUserIdEvent(
            userId: widget.userId,
            projectId: widget.projectId,
          ),
        );
    super.initState();
  }

  String getCurrentTime() {
    DateTime now = DateTime.now();
    return DateFormat('HH:mm').format(now);
  }

  @override
  void dispose() {
    super.dispose();
    socket.disconnect();
    _messageFocus.removeListener(_onFocusChange);
    _messageFocus.dispose();
  }

  void _onFocusChange() {
    setState(() {});
  }

  String _getCurrentTime() {
    DateTime now = DateTime.now(); // Lấy thời gian hiện tại
    String formattedTime =
        DateFormat('HH:mm').format(now); // Định dạng thời gian thành giờ:phút
    return formattedTime;
  }

  String getCurrentTimeAsString() {
    DateTime now = DateTime.now();

    String hour = now.hour.toString().padLeft(2, '0');
    String minute = now.minute.toString().padLeft(2, '0');
    String second = now.second.toString().padLeft(2, '0');

    String timeString = '$hour$minute$second';
    return timeString;
  }

  String convertDateTimeFormat(String isoDateTime) {
    DateTime dateTime = DateTime.parse(isoDateTime);

    String formattedDateTime =
        '${dateTime.year}-${_twoDigits(dateTime.month)}-${_twoDigits(dateTime.day)} ${_twoDigits(dateTime.hour)}:${_twoDigits(dateTime.minute)}';

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
    var colorTheme = Theme.of(context).colorScheme;
    var screenSize = MediaQuery.of(context).size;
    int meId = context.read<AuthBloc>().state.userModel.id!;

    return BlocConsumer<ChatBloc, ChatState>(listener: (context, state) {
      socket.receiveMessage((data) {
        if (mounted) {
          // logger.d('SOCKET RECEIVE DATA: ${data['notification']['message']}');
          if (data['notification']['message']['senderId'].toString() !=
              meId.toString()) {
            state.messageList.insert(
              0,
              Message(
                id: data['notification']['message']['id'],
                createdAt: _getCurrentTime(),
                content: data['notification']['message']['content'],
                sender: {
                  "id": data['notification']['message']['senderId'],
                  "fullname": ""
                },
                receiver: {
                  "id": data['notification']['message']['receiverId'],
                  "fullname": ""
                },
                interview: null,
              ),
            );
            setState(() {});
          }
        }
      });

      socket.receiveInterview((data) {
        if (mounted) {
          logger.d('SOCKET RECEIVE INTERVIEW: ${data['notification']}');
          if (data['notification']['sender']['id'].toString() !=
              meId.toString()) {
            state.messageList.insert(
              0,
              Message(
                id: data['notification']['interview']['id'],
                createdAt: _getCurrentTime(),
                content: "",
                sender: {
                  "id": data['notification']['sender']['id'],
                  "fullname": ""
                },
                receiver: {
                  "id": data['notification']['receiver']['id'],
                  "fullname": ""
                },
                interview: Interview(
                  id: data['notification']['interview']['id'],
                  title: data['notification']['interview']['title'],
                  startTime: convertDateTimeFormat(
                      data['notification']['interview']['startTime']),
                  endTime: convertDateTimeFormat(
                      data['notification']['interview']['endTime']),
                ),
              ),
            );
            setState(() {});
          }
        }
      });
    }, builder: (BuildContext context, ChatState state) {
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
                      widget.userName,
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
                        socket.sendInterview({
                          {
                            "title": "Test interview",
                            "content": "Test interview",
                            "startTime": "2024-05-10T01:36:15.102Z",
                            "endTime": "2024-05-10T02:36:15.102Z",
                            "projectId": widget.projectId,
                            "senderId":
                                context.read<AuthBloc>().state.userModel.id,
                            "receiverId": widget.userId,
                            "meeting_room_code": getCurrentTimeAsString(),
                            "meeting_room_id": getCurrentTimeAsString()
                          }
                        });
                        UserModel userModel =
                            context.read<AuthBloc>().state.userModel;
                        state.messageList.insert(
                            0,
                            Message(
                              id: int.parse(getCurrentTimeAsString()),
                              sender: {
                                "id": userModel.id,
                                "fullname": userModel.fullname,
                              },
                              receiver: {
                                "id": widget.userId,
                                "fullname": widget.userName
                              },
                              interview: Interview(
                                id: int.parse(getCurrentTimeAsString()),
                                title: 'Test interview',
                                startTime: convertDateTimeFormat(
                                    "2024-05-10T01:36:15.102Z"),
                                endTime: convertDateTimeFormat(
                                    "2024-05-10T02:36:15.102Z"),
                              ),
                            ));
                        setState(() {});
                        // showModalBottomSheetCustom(context,
                        //     widgetBuilder: MoreActionChatDetail(
                        //   callBack: (value) {
                        //     setState(() {
                        //       // messagesData.insert(0, {
                        //       //   'isMe': true,
                        //       //   'isSchedule': true,
                        //       //   'start_date': value['start_date'],
                        //       //   'end_date': value['end_date'],
                        //       //   'time_start': value['time_start'],
                        //       //   'time_end': value['time_end'],
                        //       //   'title': value['title'],
                        //       //   'duration': "60 minutes",
                        //       //   'time': '12:59',
                        //       //   'content': value['title'],
                        //       // });
                        //       logger.d(value['start_date']);
                        //       logger.d(value['time_start']);
                        //     });
                        //   },
                        // ));
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
                  itemCount: state.messageList.length,
                  reverse: true,
                  itemBuilder: (context, index) =>
                      state.messageList[index].sender['id'] == meId
                          ? Builder(builder: (context) {
                              // if (state.messageList[index].interview == null) {
                              //   state.messageList[index].interview = false;
                              // }
                              if (state.messageList[index].interview == null) {
                                return MessageSendWidget(
                                  screenSize: screenSize,
                                  meId: meId,
                                  messageList: state.messageList,
                                  index: index,
                                );
                              } else {
                                return InterviewSendWidget(
                                  meId: meId,
                                  screenSize: screenSize,
                                  colorTheme: colorTheme,
                                  messageList: state.messageList,
                                  index: index,
                                );
                              }
                            })
                          : Builder(builder: (context) {
                              if (state.messageList[index].interview == null) {
                                return MessageReceiveWidget(
                                  meId: meId,
                                  screenSize: screenSize,
                                  colorTheme: colorTheme,
                                  messageList: state.messageList,
                                  index: index,
                                );
                              } else {
                                return InterviewReceiveWidget(
                                  meId: meId,
                                  screenSize: screenSize,
                                  colorTheme: colorTheme,
                                  messageList: state.messageList,
                                  index: index,
                                );
                              }
                            }),
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
                          if (messageController.text.isNotEmpty) {
                            UserModel userModel =
                                context.read<AuthBloc>().state.userModel;
                            state.messageList.insert(
                                0,
                                Message(
                                  id: 1254,
                                  createdAt: _getCurrentTime(),
                                  content: messageController.text.trim(),
                                  sender: {
                                    "id": userModel.id,
                                    "fullname": userModel.fullname,
                                  },
                                  receiver: {
                                    "id": widget.userId,
                                    "fullname": widget.userName
                                  },
                                  interview: null,
                                ));
                            // logger.d(
                            //     'SEND MESSAGE: ${widget.projectId}. ${widget.userId}');

                            logger.d(
                                'SENDER ID: ${context.read<AuthBloc>().state.userModel.id}');
                            logger.d('RECEIVE ID: ${widget.userId}');
                            logger.d('PROJECT ID: ${widget.projectId}');
                            socket.sendMessage({
                              "content": messageController.text.trim(),
                              "projectId": widget.projectId,
                              "senderId":
                                  context.read<AuthBloc>().state.userModel.id,
                              "receiverId": widget.userId,
                              "messageFlag":
                                  0 // default 0 for message, 1 for interview
                            });
                            messageController.clear();
                            setState(() {});
                          }
                        },
                        child: const FaIcon(
                          FontAwesomeIcons.solidPaperPlane,
                          size: 20,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
