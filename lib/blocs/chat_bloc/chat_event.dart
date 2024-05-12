// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/material.dart';

@immutable
abstract class ChatEvent {}

class GetAllDataEvent extends ChatEvent {
  GetAllDataEvent();
}

// ignore: must_be_immutable
class GetActiveInterviewEvent extends ChatEvent {
  String userId;
  GetActiveInterviewEvent({
    required this.userId,
  });
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

class GetChatItemOfProjectEvent extends ChatEvent {
  String projectId;
  int myId;
  GetChatItemOfProjectEvent({required this.projectId, required this.myId});
}

// ignore: must_be_immutable
class SearchChatEvent extends ChatEvent {
  String search;
  SearchChatEvent({required this.search});
}
