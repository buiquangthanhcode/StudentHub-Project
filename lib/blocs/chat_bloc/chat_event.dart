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
