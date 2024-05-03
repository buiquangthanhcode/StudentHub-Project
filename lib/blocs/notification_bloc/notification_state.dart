import 'package:equatable/equatable.dart';

import 'package:studenthub/models/notification/notification_model.dart';

class NotificationState extends Equatable {
  const NotificationState({required this.notificationList});

  final List<NotificationModel> notificationList;

  @override
  List<Object?> get props => [
        notificationList,
      ];

  NotificationState update({
    List<NotificationModel>? notificationList,
  }) {
    return NotificationState(
      notificationList: notificationList ?? this.notificationList,
    );
  }
}
