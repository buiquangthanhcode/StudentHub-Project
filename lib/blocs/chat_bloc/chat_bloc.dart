import 'dart:async';

import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:studenthub/blocs/chat_bloc/chat_event.dart';
import 'package:studenthub/blocs/chat_bloc/chat_state.dart';
import 'package:studenthub/data/dto/reponse.dart';
import 'package:studenthub/models/common/message_model.dart';
import 'package:studenthub/services/chat/chat.dart';
import 'package:studenthub/utils/helper.dart';
import 'package:studenthub/utils/logger.dart';
import 'package:studenthub/widgets/snack_bar_config.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  ChatBloc()
      : super(
          ChatState(
            chatList: const [],
            messageList: const [],
          ),
        ) {
    on<GetAllDataEvent>(_onGetAllData);
    on<GetChatWithUserIdEvent>(_onGetChatWithUserId);
  }

  final ChatService _chatService = ChatService();

  FutureOr<void> _onGetAllData(
      GetAllDataEvent event, Emitter<ChatState> emit) async {
    try {
      EasyLoading.show(status: 'Loading...');
      ResponseAPI result = await _chatService.getAllData();

      if (result.statusCode! < 300) {
        emit(state.update(chatList: result.data));
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

  String checkDateTime(String dateTimeString) {
    if (dateTimeString.isEmpty) return '';
    DateTime now = DateTime.now();

    DateTime dateTime = DateTime.parse(dateTimeString);

    if (dateTime.year == now.year &&
        dateTime.month == now.month &&
        dateTime.day == now.day) {
      dateTime = dateTime.toLocal();
      return DateFormat('HH:mm').format(dateTime);
    } else {
      return DateFormat('dd-MM-yyyy').format(dateTime);
    }
  }

  FutureOr<void> _onGetChatWithUserId(
      GetChatWithUserIdEvent event, Emitter<ChatState> emit) async {
    try {
      EasyLoading.show(status: 'Loading...');
      ResponseAPI result = await _chatService.getAllChatWithUserId(
          event.userId, event.projectId);
      // logger.d('MESSAGE DATA: ${result.data}');
      List<Message> data = [];
      for (Message i in result.data) {
        i.createdAt = checkDateTime(i.createdAt ?? '');
        data.add(i);
      }

      if (result.statusCode! < 300) {
        emit(state.update(messageList: data));
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
}
