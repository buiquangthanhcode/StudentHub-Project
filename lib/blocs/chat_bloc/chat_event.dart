import 'package:flutter/material.dart';

@immutable
abstract class ChatEvent {}

class GetAllDataEvent extends ChatEvent {
  GetAllDataEvent();
}

// ignore: must_be_immutable
class GetChatWithUserIdEvent extends ChatEvent {
  String userId;
  String projectId;
  GetChatWithUserIdEvent({required this.userId, required this.projectId});
}

// ignore: must_be_immutable
class GetChatListDataOfProjectEvent extends ChatEvent {
  String projectId;
  GetChatListDataOfProjectEvent({required this.projectId});
}
