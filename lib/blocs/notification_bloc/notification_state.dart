import 'package:equatable/equatable.dart';
import 'package:studenthub/models/common/message_model.dart';

import 'package:studenthub/models/notification/notification_model.dart';

class NotificationState extends Equatable {
  const NotificationState({
    required this.notificationList,
    required this.messageNotification,
    required this.isChanged,
  });

  final List<NotificationModel> notificationList;
  final Message messageNotification;
  final bool isChanged;

  @override
  List<Object?> get props => [
        notificationList,
        messageNotification,
        isChanged,
      ];

  NotificationState update({
    List<NotificationModel>? notificationList,
    Message? messageNotification,
    bool? isChanged,
  }) {
    return NotificationState(
      notificationList: notificationList ?? this.notificationList,
      messageNotification: messageNotification ?? this.messageNotification,
      isChanged: isChanged ?? this.isChanged,
    );
  }
}
