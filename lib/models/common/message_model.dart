// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:studenthub/models/common/interview_model.dart';

class Message {
  int? id;
  String? createdAt;
  String? content;
  dynamic sender;
  dynamic receiver;
  Interview? interview;
  Message({
    this.id,
    this.createdAt,
    this.content,
    required this.sender,
    required this.receiver,
    this.interview,
  });

  Message copyWith({
    int? id,
    String? createdAt,
    String? content,
    dynamic sender,
    dynamic receiver,
    Interview? interview,
  }) {
    return Message(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      content: content ?? this.content,
      sender: sender ?? this.sender,
      receiver: receiver ?? this.receiver,
      interview: interview ?? this.interview,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'createAt': createdAt,
      'content': content,
      'sender': sender,
      'receiver': receiver,
      'interview': interview?.toMap(),
    };
  }

  factory Message.fromMap(Map<String, dynamic> map) {
    return Message(
      id: map['id'] != null ? map['id'] as int : null,
      createdAt: map['createdAt'] != null ? map['createdAt'] as String : null,
      content: map['content'] != null ? map['content'] as String : null,
      sender: map['sender'] as dynamic,
      receiver: map['receiver'] as dynamic,
      interview: map['interview'] != null ? Interview.fromMap(map['interview'] as Map<String,dynamic>) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Message.fromJson(String source) => Message.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Message(id: $id, createAt: $createdAt, content: $content, sender: $sender, receiver: $receiver, interview: $interview)';
  }

  @override
  bool operator ==(covariant Message other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.createdAt == createdAt &&
      other.content == content &&
      other.sender == sender &&
      other.receiver == receiver &&
      other.interview == interview;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      createdAt.hashCode ^
      content.hashCode ^
      sender.hashCode ^
      receiver.hashCode ^
      interview.hashCode;
  }
}
