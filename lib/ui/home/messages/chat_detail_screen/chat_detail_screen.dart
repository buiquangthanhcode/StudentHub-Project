// ignore_for_file: unnecessary_null_comparison

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:logger/logger.dart';
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
import 'package:studenthub/services/chat/chat.dart';
import 'package:studenthub/services/interview/interview.dart';
import 'package:studenthub/ui/home/messages/chat_detail_screen/widgets/interview_receive_widget.dart';
import 'package:studenthub/ui/home/messages/chat_detail_screen/widgets/interview_send_widget.dart';
import 'package:studenthub/ui/home/messages/chat_detail_screen/widgets/message_receive_widget.dart';
import 'package:studenthub/ui/home/messages/chat_detail_screen/widgets/message_send_widget.dart';
import 'package:studenthub/ui/home/messages/chat_detail_screen/zego/zego.dart';
import 'package:studenthub/ui/home/messages/widgets/get_more_action_widget.dart';
import 'package:studenthub/utils/helper.dart';
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
  final ChatService _chatService = ChatService();
  final InterviewService _interviewService = InterviewService();

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

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    var colorTheme = Theme.of(context).colorScheme;
    var screenSize = MediaQuery.of(context).size;
    int meId = context.read<AuthBloc>().state.userModel.id!;

    return BlocConsumer<ChatBloc, ChatState>(listener: (context, state) {
      socket.receiveMessage((data) {
        if (mounted) {
          logger.d('SOCKET RECEIVE DATA: ${data['notification']['message']}');
          if (data['notification']['message']['senderId'].toString() !=
              meId.toString()) {
            state.messageList.insert(
              0,
              Message(
                id: data['notification']['message']['id'],
                createdAt: getCurrentTime(),
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
          logger.d(
              'SOCKET RECEIVE INTERVIEW: ${data['notification']['message']}');
          dynamic socketInterview =
              data['notification']['message']['interview'];
          if (socketInterview['disableFlag'] == 1) {
            logger.d("TEST 1");

            state.messageList
                .where((element) =>
                    element.interview != null &&
                    element.interview!.disableFlag != 1)
                .forEach((e) {
              if (e.id.toString() ==
                  data['notification']['message']['id'].toString()) {
                logger.d('co vao day ne');
                e.interview = Interview(
                  disableFlag: 1,
                  title: data['notification']['message']['interview']['title'],
                );
              }
            });
          } else {
            logger.d(
                '${socketInterview['createdAt']} == ${socketInterview['updatedAt']}');
            if (socketInterview['createdAt'] == socketInterview['updatedAt']) {
              logger.d("TEST 2");
              state.messageList.insert(
                0,
                Message(
                  id: data['notification']['message']['id'],
                  createdAt: getCurrentTime(),
                  content: "",
                  sender: {
                    "id": data['notification']['sender']['id'],
                    "fullname": data['notification']['sender']['fullname']
                  },
                  receiver: {
                    "id": data['notification']['receiver']['id'],
                    "fullname": data['notification']['receiver']['fullname']
                  },
                  interview: Interview(
                    id: data['notification']['message']['interview']['id'],
                    title: data['notification']['message']['interview']
                        ['title'],
                    startTime: data['notification']['message']['interview']
                        ['startTime'],
                    endTime: data['notification']['message']['interview']
                        ['endTime'],
                  ),
                ),
              );
            } else {
              logger
                  .d("ID: ${data['notification']['message']['id'].toString()}");
              state.messageList
                  .where((element) => element.interview != null&&
                    element.interview!.disableFlag != 1)
                  .forEach((e) {
                if (e.id.toString() ==
                    data['notification']['message']['id'].toString()) {
                  logger.d('co vao day');
                  e.interview = Interview(
                    id: data['notification']['message']['interview']['id'],
                    title: data['notification']['message']['interview']
                        ['title'],
                    startTime: data['notification']['message']['interview']
                        ['startTime'],
                    endTime: data['notification']['message']['interview']
                        ['endTime'],
                  );
                }
              });
            }
          }
          setState(() {});
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
                        showModalBottomSheetCustom(context,
                            widgetBuilder: MoreActionChatDetail(
                          callBack: (value) {
                            logger.d(value['title']);
                            logger.d(value['start_date']);
                            logger.d(value['time_start']);
                            logger.d(value['end_date']);
                            logger.d(value['time_end']);
                            // socket.sendInterview({
                            //   {
                            //     "title": value['title'],
                            //     "content": "Test interview",
                            //     "startTime": convertToIso8601(
                            //         value['start_date'], value['time_start']),
                            //     "endTime": convertToIso8601(
                            //         value['end_date'], value['time_end']),
                            //     "projectId": widget.projectId,
                            //     "senderId":
                            //         context.read<AuthBloc>().state.userModel.id,
                            //     "receiverId": widget.userId,
                            //     "meeting_room_code": getCurrentTimeAsString(),
                            //     "meeting_room_id": getCurrentTimeAsString()
                            //   }
                            // });
                            _interviewService.sendInterview({
                              "title": value['title'],
                              "content": "Test interview",
                              "startTime": convertToIso8601(
                                  value['start_date'], value['time_start']),
                              "endTime": convertToIso8601(
                                  value['end_date'], value['time_end']),
                              "projectId": widget.projectId,
                              "senderId":
                                  context.read<AuthBloc>().state.userModel.id,
                              "receiverId": widget.userId,
                              "meeting_room_code": getCurrentTimeAsString(),
                              "meeting_room_id": getCurrentTimeAsString()
                            });
                            // setState(() {
                            //   UserModel userModel =
                            //       context.read<AuthBloc>().state.userModel;
                            //   state.messageList.insert(
                            //       0,
                            //       Message(
                            //         id: int.parse(getCurrentTimeAsString()),
                            //         sender: {
                            //           "id": userModel.id,
                            //           "fullname": userModel.fullname,
                            //         },
                            //         receiver: {
                            //           "id": widget.userId,
                            //           "fullname": widget.userName
                            //         },
                            //         createdAt: getCurrentTime(),
                            //         interview: Interview(
                            //           id: int.parse(getCurrentTimeAsString()),
                            //           title: value['title'],
                            //           startTime: convertToIso8601(
                            //               value['start_date'],
                            //               value['time_start']),
                            //           endTime: convertToIso8601(
                            //               value['end_date'], value['time_end']),
                            //         ),
                            //       ));
                            // });
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
                  itemCount: state.messageList.length,
                  reverse: true,
                  itemBuilder: (context, index) => state
                              .messageList[index].sender['id'] ==
                          meId
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
                              join: (data) {
                                logger.d('MEETING DATA: ${data.meetingRoom}');
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => VideoCallPage(
                                      conferenceID:
                                          data.meetingRoom['meeting_room_code'],
                                    ),
                                  ),
                                );
                              },
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
                              join: (data) {
                                logger.d('MEETING DATA: ${data.meetingRoom}');
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => VideoCallPage(
                                      conferenceID:
                                          data.meetingRoom['meeting_room_code'],
                                    ),
                                  ),
                                );
                              },
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
                                  createdAt: getCurrentTime(),
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

                            _chatService.sendMessages({
                              "content": messageController.text.trim(),
                              "projectId": widget.projectId,
                              "senderId":
                                  context.read<AuthBloc>().state.userModel.id,
                              "receiverId": widget.userId,
                              "messageFlag":
                                  0 // default 0 for message, 1 for interview
                            });
                            // socket.sendMessage({
                            //   "content": messageController.text.trim(),
                            //   "projectId": widget.projectId,
                            //   "senderId":
                            //       context.read<AuthBloc>().state.userModel.id,
                            //   "receiverId": widget.userId,
                            //   "messageFlag":
                            //       0 // default 0 for message, 1 for interview
                            // });
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
