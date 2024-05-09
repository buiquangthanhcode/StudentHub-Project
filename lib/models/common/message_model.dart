// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:studenthub/models/common/interview_model.dart';

class Message {
  int? id;
  String? createdAt;
  String? updateAt;
  String? deleteAt;
  String? content;
  dynamic sender;
  dynamic receiver;
  int? senderId;
  int? receiverId;
  int? projectId;
  int? interviewId;
  int? messageFlag;
  Interview? interview;

  Message({
    this.id,
    this.createdAt,
    this.updateAt,
    this.deleteAt,
    this.content,
    required this.sender,
    required this.receiver,
    this.senderId,
    this.receiverId,
    this.projectId,
    this.interviewId,
    this.messageFlag,
    this.interview,
  });



  Message copyWith({
    int? id,
    String? createdAt,
    String? updateAt,
    String? deleteAt,
    String? content,
    dynamic sender,
    dynamic receiver,
    int? senderId,
    int? receiverId,
    int? projectId,
    int? interviewId,
    int? messageFlag,
    Interview? interview,
  }) {
    return Message(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      updateAt: updateAt ?? this.updateAt,
      deleteAt: deleteAt ?? this.deleteAt,
      content: content ?? this.content,
      sender: sender ?? this.sender,
      receiver: receiver ?? this.receiver,
      senderId: senderId ?? this.senderId,
      receiverId: receiverId ?? this.receiverId,
      projectId: projectId ?? this.projectId,
      interviewId: interviewId ?? this.interviewId,
      messageFlag: messageFlag ?? this.messageFlag,
      interview: interview ?? this.interview,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'createdAt': createdAt,
      'updateAt': updateAt,
      'deleteAt': deleteAt,
      'content': content,
      'sender': sender,
      'receiver': receiver,
      'senderId': senderId,
      'receiverId': receiverId,
      'projectId': projectId,
      'interviewId': interviewId,
      'messageFlag': messageFlag,
      'interview': interview?.toMap(),
    };
  }

  factory Message.fromMap(Map<String, dynamic> map) {
    return Message(
      id: map['id'] != null ? map['id'] as int : null,
      createdAt: map['createdAt'] != null ? map['createdAt'] as String : null,
      updateAt: map['updateAt'] != null ? map['updateAt'] as String : null,
      deleteAt: map['deleteAt'] != null ? map['deleteAt'] as String : null,
      content: map['content'] != null ? map['content'] as String : null,
      sender: map['sender'] as dynamic,
      receiver: map['receiver'] as dynamic,
      senderId: map['senderId'] != null ? map['senderId'] as int : null,
      receiverId: map['receiverId'] != null ? map['receiverId'] as int : null,
      projectId: map['projectId'] != null ? map['projectId'] as int : null,
      interviewId: map['interviewId'] != null ? map['interviewId'] as int : null,
      messageFlag: map['messageFlag'] != null ? map['messageFlag'] as int : null,
      interview: map['interview'] != null ? Interview.fromMap(map['interview'] as Map<String,dynamic>) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Message.fromJson(String source) => Message.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Message(id: $id, createdAt: $createdAt, updateAt: $updateAt, deleteAt: $deleteAt, content: $content, sender: $sender, receiver: $receiver, senderId: $senderId, receiverId: $receiverId, projectId: $projectId, interviewId: $interviewId, messageFlag: $messageFlag, interview: $interview)';
  }

  @override
  bool operator ==(covariant Message other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.createdAt == createdAt &&
      other.updateAt == updateAt &&
      other.deleteAt == deleteAt &&
      other.content == content &&
      other.sender == sender &&
      other.receiver == receiver &&
      other.senderId == senderId &&
      other.receiverId == receiverId &&
      other.projectId == projectId &&
      other.interviewId == interviewId &&
      other.messageFlag == messageFlag &&
      other.interview == interview;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      createdAt.hashCode ^
      updateAt.hashCode ^
      deleteAt.hashCode ^
      content.hashCode ^
      sender.hashCode ^
      receiver.hashCode ^
      senderId.hashCode ^
      receiverId.hashCode ^
      projectId.hashCode ^
      interviewId.hashCode ^
      messageFlag.hashCode ^
      interview.hashCode;
  }
}
