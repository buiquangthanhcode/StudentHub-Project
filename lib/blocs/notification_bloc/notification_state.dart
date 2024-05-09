import 'package:equatable/equatable.dart';
import 'package:studenthub/models/common/message_model.dart';

import 'package:studenthub/models/notification/notification_model.dart';
import 'package:studenthub/utils/socket.dart';

class NotificationState extends Equatable {
  const NotificationState({
    required this.notificationList,
    required this.messageNotification,
    required this.isChanged,
    required this.socketNotification,
  });

  final List<NotificationModel> notificationList;
  final Message messageNotification;
  final bool isChanged;
  final SocketService socketNotification;

  @override
  List<Object?> get props => [notificationList, messageNotification, isChanged, socketNotification];

  NotificationState update({
    List<NotificationModel>? notificationList,
    Message? messageNotification,
    bool? isChanged,
    SocketService? socketNotification,
  }) {
    return NotificationState(
      notificationList: notificationList ?? this.notificationList,
      messageNotification: messageNotification ?? this.messageNotification,
      isChanged: isChanged ?? this.isChanged,
      socketNotification: socketNotification ?? this.socketNotification,
    );
  }
}
