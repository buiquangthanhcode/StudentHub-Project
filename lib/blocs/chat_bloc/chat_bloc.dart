import 'dart:async';

import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:studenthub/blocs/chat_bloc/chat_event.dart';
import 'package:studenthub/blocs/chat_bloc/chat_state.dart';
import 'package:studenthub/constants/key_translator.dart';
import 'package:studenthub/data/dto/reponse.dart';
import 'package:studenthub/services/chat/chat.dart';
import 'package:studenthub/utils/helper.dart';
import 'package:studenthub/utils/logger.dart';
import 'package:studenthub/widgets/snack_bar_config.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  ChatBloc()
      : super(
          const ChatState(
            chatList: [],
            messageList: [],
          ),
        ) {
    on<GetAllDataEvent>(_onGetAllData);
    on<GetChatWithUserIdEvent>(_onGetChatWithUserId);
  }

  final ChatService _chatService = ChatService();

  FutureOr<void> _onGetAllData(
      GetAllDataEvent event, Emitter<ChatState> emit) async {
    try {
      // EasyLoading.show(status: 'Loading...');
      EasyLoading.show(status: loadingBtnKey.tr());
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

  FutureOr<void> _onGetChatWithUserId(
      GetChatWithUserIdEvent event, Emitter<ChatState> emit) async {
    try {
      // EasyLoading.show(status: 'Loading...');
      EasyLoading.show(status: loadingBtnKey.tr());
      ResponseAPI result = await _chatService.getAllChatWithUserId(
          event.userId, event.projectId);
      logger.d('MESSAGE DATA: ${result.data}');
      if (result.statusCode! < 300) {
        emit(state.update(messageList: result.data));
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
