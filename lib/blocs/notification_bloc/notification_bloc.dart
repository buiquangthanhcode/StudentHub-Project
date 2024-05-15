import 'dart:async';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:go_router/go_router.dart';
import 'package:studenthub/blocs/auth_bloc/auth_bloc.dart';
import 'package:studenthub/blocs/auth_bloc/auth_state.dart';
import 'package:studenthub/blocs/notification_bloc/notification_event.dart';
import 'package:studenthub/blocs/notification_bloc/notification_state.dart';
import 'package:studenthub/constants/key_translator.dart';
import 'package:studenthub/core/local_notification.dart';
import 'package:studenthub/data/dto/reponse.dart';
import 'package:studenthub/models/common/message_model.dart';
import 'package:studenthub/models/notification/notification_model.dart';
import 'package:studenthub/services/notification/notification.dart';
import 'package:studenthub/utils/helper.dart';
import 'package:studenthub/utils/logger.dart';
import 'package:studenthub/utils/socket.dart';
import 'package:studenthub/widgets/snack_bar_config.dart';

class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  NotificationBloc()
      : super(NotificationState(
          notificationList: const [],
          messageNotification: Message(sender: null, receiver: null),
          isChanged: false,
          socketNotification: SocketService(),
        )) {
    on<GetNotificationListEvents>(_onGetNotification);
    on<PushNotificationMessageEvents>(_onPushNotificationMessage);
    on<StartListenerEvents>(_onStartListener);
    on<MarkAsReadEvents>(_onMarkAsReadNotification);
  }

  final NotificationService _notificationService = NotificationService();
  FutureOr<void> _onGetNotification(GetNotificationListEvents event, Emitter<NotificationState> emit) async {
    try {
      // EasyLoading.show(status: 'Loading...');
      EasyLoading.show(status: loadingBtnKey.tr());
      ResponseAPI result = await _notificationService.getNotificationList(event.userId ?? '');
      if (result.statusCode! < 300) {
        List<NotificationModel> data = result.data;
        emit(state.update(notificationList: data.toList()));
        event.onSuccess!();
      } else {
        SnackBarService.showSnackBar(
            content: handleFormatMessage(result.data!.errorDetails), status: StatusSnackBar.error);
      }
    } on DioException catch (e) {
      logger.e(
        "DioException:${e.response}",
      );
    } catch (e) {
      logger.e("Unexpect error-> $e");
      SnackBarService.showSnackBar(content: handleFormatMessage(e.toString()), status: StatusSnackBar.error);
    } finally {
      EasyLoading.dismiss();
    }
  }

  FutureOr<void> _onPushNotificationMessage(
      PushNotificationMessageEvents event, Emitter<NotificationState> emit) async {
    emit(state.update(messageNotification: event.message, isChanged: !state.isChanged));
  }

  // This is main function handle notification of app
  FutureOr<void> _onStartListener(StartListenerEvents event, Emitter<NotificationState> emit) async {
    AuthenState authState = event.context.read<AuthBloc>().state;
    SocketService.receiveNotification((authState.userModel.id ?? 0).toString(), (value) {
      logger.d(value);
      switch (value['notification']['typeNotifyFlag']) {
        case "0":
          LocalNotification.showSimpleNotification(
            title: "StudentHub",
            body: 'You have received a new offer from the ${value['notification']['sender']['fullname']}',
            payload: DateTime.now().toString(),
          );
          break;
        case "1":
          // Interview
          LocalNotification.showSimpleNotification(
            title: "StudentHub",
            body: 'You have received a new interview from the ${value['notification']['sender']['fullname']}',
            payload: DateTime.now().toString(),
          );
          break;
        case "2":
          // New Proposal
          LocalNotification.showSimpleNotification(
            title: "StudentHub",
            body: 'You have received a new proposal from the ${value['notification']['sender']['fullname']}',
            payload: DateTime.now().toString(),
          );
          break;
        case "3":
          if (!GoRouter.of(event.context).location().contains('chat_detail')) {
            LocalNotification.showSimpleNotification(
              title: "StudentHub",
              body: 'You have a new message from ${value['notification']['sender']['fullname']}',
              payload: DateTime.now().toString(),
            );
          }
        case "4":
          //Hire
          LocalNotification.showSimpleNotification(
            title: "StudentHub",
            body: 'You have received a new hire from the ${value['notification']['sender']['fullname']}',
            payload: DateTime.now().toString(),
          );
          break;

        default:
      }
      event.onListener(value);
    });
  }

  FutureOr<void> _onMarkAsReadNotification(MarkAsReadEvents event, Emitter<NotificationState> emit) async {
    try {
      EasyLoading.show(status: loadingBtnKey.tr());
      ResponseAPI result = await _notificationService.markAsRead((event.notificationId ?? 0).toString());
      if (result.statusCode! < 300) {
        //Update according notificationId
        List<NotificationModel> data = state.notificationList;
        for (var element in data) {
          if (element.id == int.parse(event.notificationId ?? "-1")) {
            element.notifyFlag = "1";
          }
        }
        emit(state.update(notificationList: data.toList(), isChanged: !state.isChanged));
      } else {
        SnackBarService.showSnackBar(
            content: handleFormatMessage(result.data!.errorDetails), status: StatusSnackBar.error);
      }
    } on DioException catch (e) {
      logger.e(
        "DioException:${e.response}",
      );
    } catch (e) {
      logger.e("Unexpect error-> $e");
      SnackBarService.showSnackBar(content: handleFormatMessage(e.toString()), status: StatusSnackBar.error);
    } finally {
      EasyLoading.dismiss();
    }
  }
}
