import 'package:equatable/equatable.dart';
import 'package:studenthub/models/common/chat_model.dart';
import 'package:studenthub/models/common/interview_model.dart';
import 'package:studenthub/models/common/message_model.dart';

class ChatState extends Equatable {
  final List<Chat> chatList;
  final List<Message> messageList;
  final List<Message> messageListOfProject;
  final List<Chat> chatListOfProject;
  final Chat chatItem;
  final List<Interview> activeInterview;

  const ChatState({
    required this.chatList,
    required this.messageList,
    required this.messageListOfProject,
    required this.chatListOfProject,
    required this.chatItem,
    required this.activeInterview,
  });

  @override
  List<Object?> get props => [
        chatList,
        messageList,
        messageListOfProject,
        chatListOfProject,
        chatItem,
        activeInterview
      ];

  ChatState update({
    List<Chat>? chatList,
    List<Message>? messageList,
    List<Message>? messageListOfProject,
    List<Chat>? chatListOfProject,
    Chat? chatItem,
    List<Interview>? activeInterview,
  }) {
    return ChatState(
      chatList: chatList ?? this.chatList,
      messageList: messageList ?? this.messageList,
      messageListOfProject: messageListOfProject ?? this.messageListOfProject,
      chatListOfProject: chatListOfProject ?? this.chatListOfProject,
      chatItem: chatItem ?? this.chatItem,
      activeInterview: activeInterview ?? this.activeInterview,
    );
  }
}
