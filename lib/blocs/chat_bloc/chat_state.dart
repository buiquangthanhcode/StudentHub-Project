import 'package:equatable/equatable.dart';
import 'package:studenthub/models/common/chat_model.dart';
import 'package:studenthub/models/common/message_model.dart';

class ChatState extends Equatable {
  final List<Chat> chatList;
  final List<Message> messageList;

  const ChatState({
    required this.chatList,
    required this.messageList,
  });

  @override
  List<Object?> get props => [chatList,messageList];

  ChatState update({
    List<Chat>? chatList,
    List<Message>? messageList,
  }) {
    return ChatState(
      chatList: chatList ?? this.chatList,
      messageList: messageList ?? this.messageList,
    );
  }
}
