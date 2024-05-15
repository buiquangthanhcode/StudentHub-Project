import 'package:flutter/material.dart';
import 'package:studenthub/models/common/message_model.dart';

abstract class NotificationEvent {}

class GetNotificationListEvents extends NotificationEvent {
  final Function? onSuccess;
  final String? userId;

  GetNotificationListEvents({required this.onSuccess, required this.userId});
}

class PushNotificationMessageEvents extends NotificationEvent {
  final Message message;

  PushNotificationMessageEvents({required this.message});
}

class StartListenerEvents extends NotificationEvent {
  final BuildContext context;
  final Function(dynamic data) onListener;

  StartListenerEvents({required this.context, required this.onListener});
}

class MarkAsReadEvents extends NotificationEvent {
  final String? notificationId;

  MarkAsReadEvents({required this.notificationId});
}
