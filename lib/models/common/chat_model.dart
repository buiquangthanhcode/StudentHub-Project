// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'package:studenthub/models/common/interview_model.dart';
import 'package:studenthub/models/common/project_model.dart';

class Chat {
  int? id;
  String? createdAt;
  String? content;
  dynamic sender;
  dynamic receiver;
  Interview? interview;
  Project project;

  Chat({
    this.id,
    this.createdAt,
    this.content,
    required this.sender,
    required this.receiver,
    this.interview,
    required this.project,
  });

  Chat copyWith({
    int? id,
    String? createdAt,
    String? content,
    dynamic sender,
    dynamic receiver,
    Interview? interview,
    Project? project,
  }) {
    return Chat(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      content: content ?? this.content,
      sender: sender ?? this.sender,
      receiver: receiver ?? this.receiver,
      interview: interview ?? this.interview,
      project: project ?? this.project,
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
      'project': project.toMap(),
    };
  }

  factory Chat.fromMap(Map<String, dynamic> map) {
    return Chat(
      id: map['id'] != null ? map['id'] as int : null,
      createdAt: map['createdAt'] != null ? map['createdAt'] as String : null,
      content: map['content'] != null ? map['content'] as String : null,
      sender: map['sender'] as dynamic,
      receiver: map['receiver'] as dynamic,
      interview: map['interview'] != null
          ? Interview.fromMap(map['interview'] as Map<String, dynamic>)
          : null,
      project: map['project'] != null
          ? Project.fromMap(map['project'] as Map<String, dynamic>)
          : Project(),
    );
  }

  String toJson() => json.encode(toMap());

  factory Chat.fromJson(String source) =>
      Chat.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Chat(id: $id, createAt: $createdAt, content: $content, sender: $sender, receiver: $receiver, interview: $interview, project: $project)';
  }

  @override
  bool operator ==(covariant Chat other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.createdAt == createdAt &&
        other.content == content &&
        other.sender == sender &&
        other.receiver == receiver &&
        other.interview == interview &&
        other.project == project;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        createdAt.hashCode ^
        content.hashCode ^
        sender.hashCode ^
        receiver.hashCode ^
        interview.hashCode ^
        project.hashCode;
  }
}
