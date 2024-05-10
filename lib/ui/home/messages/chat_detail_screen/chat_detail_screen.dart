// ignore_for_file: unnecessary_null_comparison
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:logger/logger.dart';
import 'package:studenthub/blocs/auth_bloc/auth_bloc.dart';
import 'package:studenthub/blocs/chat_bloc/chat_bloc.dart';
import 'package:studenthub/blocs/chat_bloc/chat_event.dart';
import 'package:studenthub/blocs/chat_bloc/chat_state.dart';
import 'package:studenthub/blocs/company_bloc/company_bloc.dart';
import 'package:studenthub/blocs/company_bloc/company_event.dart';
import 'package:studenthub/blocs/notification_bloc/notification_bloc.dart';
import 'package:studenthub/blocs/notification_bloc/notification_event.dart';
import 'package:studenthub/constants/app_theme.dart';
import 'package:studenthub/constants/colors.dart';
import 'package:studenthub/constants/key_translator.dart';
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
      {super.key, required this.userId, required this.projectId, required this.userName, this.projectProposalId});

  final String userName;
  final String userId;
  final String projectId;
  final String? projectProposalId;

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
    final token = context.read<AuthBloc>().state.userModel.token ?? "";
    socket.initSocket(token, widget.projectId);
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
          Message message = Message.fromMap(data['notification']['message']);
          if (data['notification']['message']['senderId'].toString() != meId.toString()) {
            state.messageList.insert(
                0,
                message.copyWith(
                    sender: {"id": message.senderId, "fullname": ""},
                    receiver: {"id": message.receiverId, "fullname": ""}));
            setState(() {});
          }
        }
      });

      socket.receiveInterview((data) {
        Message message = Message.fromMap(data['notification']['message']);
        if (mounted) {
          logger.d('SOCKET RECEIVE INTERVIEW: ${data['notification']['message']}');

          if (message.interview!.disableFlag == 1) {
            state.messageList
                .where((element) => element.interview != null && element.interview!.disableFlag != 1)
                .forEach((e) {
              if (e.id == message.id) {
                e.interview = Interview(
                  disableFlag: 1,
                  title: message.interview!.title,
                );
              }
            });
          } else {
            if (message.interview!.createdAt == message.interview!.updatedAt) {
              state.messageList.insert(
                  0,
                  message.copyWith(
                      sender: {"id": message.senderId, "fullname": ""},
                      receiver: {"id": message.receiverId, "fullname": ""}));
            } else {
              state.messageList
                  .where((element) => element.interview != null && element.interview!.disableFlag != 1)
                  .forEach((e) {
                if (e.id == message.id) {
                  e.interview = Interview(
                    id: message.interviewId,
                    title: message.interview!.title,
                    startTime: message.interview!.startTime,
                    endTime: message.interview!.endTime,
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
                        backgroundImage: AssetImage('lib/assets/images/circle_avatar.png'),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      widget.userName,
                      style: textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
                centerTitle: false,
                actions: [
                  Padding(
                    padding: const EdgeInsets.only(right: 20),
                    child: InkWell(
                      onTap: () {
                        showModalBottomSheetCustom(context, widgetBuilder: MoreActionChatDetail(
                          callBack: (value) {
                            logger.d(value['title']);
                            logger.d(value['start_date']);
                            logger.d(value['time_start']);
                            logger.d(value['end_date']);
                            logger.d(value['time_end']);

                            _interviewService.sendInterview({
                              "title": value['title'],
                              "content": "Test interview",
                              "startTime": convertToIso8601(value['start_date'], value['time_start']),
                              "endTime": convertToIso8601(value['end_date'], value['time_end']),
                              "projectId": widget.projectId,
                              "senderId": context.read<AuthBloc>().state.userModel.id,
                              "receiverId": widget.userId,
                              "meeting_room_code": getCurrentTimeAsString(),
                              "meeting_room_id": getCurrentTimeAsString()
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
                  itemCount: state.messageList.length,
                  reverse: true,
                  itemBuilder: (context, index) => state.messageList[index].sender['id'] == meId
                      ? Builder(builder: (context) {
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
                                      conferenceID: data.meetingRoom['meeting_room_code'],
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
                                      conferenceID: data.meetingRoom['meeting_room_code'],
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
                            // hintText: 'Your messages...',
                            hintText: chatInputPlaceHolderKey.tr(),
                            hintStyle: textTheme.bodyMedium!.copyWith(color: Theme.of(context).colorScheme.hintColor),
                            contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
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
                            UserModel userModel = context.read<AuthBloc>().state.userModel;
                            state.messageList.insert(
                                0,
                                Message(
                                  id: 1254,
                                  createdAt: DateTime.now().toIso8601String(),
                                  content: messageController.text.trim(),
                                  sender: {
                                    "id": userModel.id,
                                    "fullname": userModel.fullname,
                                  },
                                  receiver: {"id": widget.userId, "fullname": widget.userName},
                                  interview: null,
                                ));
                            // logger.d(
                            //     'SEND MESSAGE: ${widget.projectId}. ${widget.userId}');

                            logger.d('SENDER ID: ${context.read<AuthBloc>().state.userModel.id}');
                            logger.d('RECEIVE ID: ${widget.userId}');
                            logger.d('PROJECT ID: ${widget.projectId}');

                            _chatService.sendMessages({
                              "content": messageController.text.trim(),
                              "projectId": widget.projectId,
                              "senderId": context.read<AuthBloc>().state.userModel.id,
                              "receiverId": widget.userId,
                              "messageFlag": 0 // default 0 for message, 1 for interview
                            });
                            //  Add by Quang Thanh to update proposal active when company send message
                            if (state.messageList.isEmpty) {
                              context.read<CompanyBloc>().add(SetActiveProposal(
                                  proposalId: int.parse(widget.projectProposalId ?? "-1"),
                                  statusFlag: 1,
                                  onSuccess: () {}));
                            }
                            // End Quang Thanh

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
