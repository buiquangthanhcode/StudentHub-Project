import 'dart:html';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:studenthub/blocs/notification_bloc/notification_state.dart';

class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  NotificationBloc() : super(const NotificationState()) {
    // on<GetNotificationEvent>(_onGetNotification);
  }
}
