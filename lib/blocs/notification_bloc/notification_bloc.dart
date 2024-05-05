import 'dart:async';

import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:studenthub/app.dart';
import 'package:studenthub/blocs/notification_bloc/notification_event.dart';
import 'package:studenthub/blocs/notification_bloc/notification_state.dart';
import 'package:studenthub/constants/key_translator.dart';
import 'package:studenthub/data/dto/reponse.dart';
import 'package:studenthub/models/common/message_model.dart';
import 'package:studenthub/models/notification/notification_model.dart';
import 'package:studenthub/services/notification/notification.dart';
import 'package:studenthub/utils/helper.dart';
import 'package:studenthub/utils/logger.dart';
import 'package:studenthub/utils/socket.dart';
import 'package:studenthub/utils/socket_list.dart';
import 'package:studenthub/widgets/snack_bar_config.dart';

class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  NotificationBloc()
      : super(NotificationState(
          notificationList: const [],
          messageNotification: Message(sender: null, receiver: null),
          isChanged: false,
        )) {
    socket.receiveMessage((data) {
      Message message = Message(
        id: data['notification']['message']['id'],
        createdAt: getCurrentTime(),
        content: data['notification']['message']['content'],
        sender: {"id": data['notification']['message']['senderId'], "fullname": ""},
        receiver: {"id": data['notification']['message']['receiverId'], "fullname": ""},
        interview: null,
      );
      add(PushNotificationMessageEvents(message: message));
    });
    on<GetNotificationListEvents>(_onGetNotification);
    on<PushNotificationMessageEvents>(_onPushNotificationMessage);
  }
  final NotificationService _notificationService = NotificationService();

  FutureOr<void> _onGetNotification(
      GetNotificationListEvents event, Emitter<NotificationState> emit) async {
    try {
      // EasyLoading.show(status: 'Loading...');
      EasyLoading.show(status: loadingBtnKey.tr());
      ResponseAPI result =
          await _notificationService.getNotificationList(event.userId ?? '');
      if (result.statusCode! < 300) {
        List<NotificationModel> data = result.data;
        emit(state.update(notificationList: data.reversed.toList()));
        event.onSuccess!();
      } else {
        SnackBarService.showSnackBar(
            content: handleFormatMessage(result.data!.errorDetails),
            status: StatusSnackBar.error);
      }
    } on DioException catch (e) {
      logger.e(
        "DioException:${e.response}",
      );
    } catch (e) {
      logger.e("Unexpect error-> $e");
      SnackBarService.showSnackBar(
          content: handleFormatMessage(e.toString()),
          status: StatusSnackBar.error);
    } finally {
      EasyLoading.dismiss();
    }
  }

  FutureOr<void> _onPushNotificationMessage(
      PushNotificationMessageEvents event, Emitter<NotificationState> emit) async {
    emit(state.update(messageNotification: event.message, isChanged: !state.isChanged));
  }
}
