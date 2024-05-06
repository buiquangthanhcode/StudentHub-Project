abstract class NotificationEvent {}

class GetNotificationListEvents extends NotificationEvent {
  final Function? onSuccess;
  final String? userId;

  GetNotificationListEvents({required this.onSuccess, required this.userId});
}
