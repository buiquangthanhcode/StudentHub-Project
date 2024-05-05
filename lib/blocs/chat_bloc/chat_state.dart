import 'package:equatable/equatable.dart';
import 'package:studenthub/models/common/chat_model.dart';
import 'package:studenthub/models/common/message_model.dart';

class ChatState extends Equatable {
  final List<Chat> chatList;
  final List<Message> messageList;
  final List<Message> messageListOfProject;
  final List<Chat> chatListOfProject;
  final Chat chatItem;

  const ChatState({
    required this.chatList,
    required this.messageList,
    required this.messageListOfProject,
    required this.chatListOfProject,
    required this.chatItem,
  });

  @override
  List<Object?> get props =>
      [chatList, messageList, messageListOfProject, chatListOfProject,chatItem];

  ChatState update({
    List<Chat>? chatList,
    List<Message>? messageList,
    List<Message>? messageListOfProject,
    List<Chat>? chatListOfProject,
    Chat? chatItem,
  }) {
    return ChatState(
      chatList: chatList ?? this.chatList,
      messageList: messageList ?? this.messageList,
      messageListOfProject: messageListOfProject ?? this.messageListOfProject,
      chatListOfProject: chatListOfProject ?? this.chatListOfProject,
      chatItem: chatItem ?? this.chatItem,
    );
  }
}
