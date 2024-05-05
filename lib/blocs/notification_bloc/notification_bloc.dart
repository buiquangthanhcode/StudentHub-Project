import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:studenthub/blocs/notification_bloc/notification_event.dart';
import 'package:studenthub/blocs/notification_bloc/notification_state.dart';
import 'package:studenthub/data/dto/reponse.dart';
import 'package:studenthub/models/notification/notification_model.dart';
import 'package:studenthub/services/notification/notification.dart';
import 'package:studenthub/utils/helper.dart';
import 'package:studenthub/utils/logger.dart';
import 'package:studenthub/widgets/snack_bar_config.dart';

class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  NotificationBloc()
      : super(const NotificationState(
          notificationList: [],
        )) {
    on<GetNotificationListEvents>(_onGetNotification);
  }
  final NotificationService _notificationService = NotificationService();

  FutureOr<void> _onGetNotification(GetNotificationListEvents event, Emitter<NotificationState> emit) async {
    try {
      EasyLoading.show(status: "Loading...");
      ResponseAPI result = await _notificationService.getNotificationList(event.userId ?? '');
      if (result.statusCode! < 300) {
        List<NotificationModel> data = result.data;
        emit(state.update(notificationList: data.reversed.toList()));
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
}
