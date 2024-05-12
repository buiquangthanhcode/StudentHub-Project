import 'dart:async';

import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:studenthub/blocs/chat_bloc/chat_event.dart';
import 'package:studenthub/blocs/chat_bloc/chat_state.dart';
import 'package:studenthub/constants/key_translator.dart';
import 'package:studenthub/data/dto/reponse.dart';
import 'package:studenthub/models/common/chat_model.dart';
import 'package:studenthub/models/common/message_model.dart';
import 'package:studenthub/models/common/project_model.dart';
import 'package:studenthub/services/chat/chat.dart';
import 'package:studenthub/services/interview/interview.dart';
import 'package:studenthub/utils/helper.dart';
import 'package:studenthub/utils/logger.dart';
import 'package:studenthub/widgets/snack_bar_config.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  ChatBloc()
      : super(
          ChatState(
              chatList: const [],
              messageList: const [],
              messageListOfProject: const [],
              chatListOfProject: const [],
              chatItem: Chat(
                sender: {},
                receiver: {},
                project: Project(),
              ),
              activeInterview: const []),
        ) {
    on<GetAllDataEvent>(_onGetAllData);
    on<GetChatWithUserIdEvent>(_onGetChatWithUserId);
    on<GetChatListDataOfProjectEvent>(_onGetChatDataOfProject);
    on<GetChatItemOfProjectEvent>(_onGetChatItemOfProject);
    on<GetActiveInterviewEvent>(_onGetActiveInterview);
  }

  final ChatService _chatService = ChatService();
  final InterviewService _interviewService = InterviewService();

  FutureOr<void> _onGetAllData(
      GetAllDataEvent event, Emitter<ChatState> emit) async {
    try {
      // EasyLoading.show(status: 'Loading...');
      EasyLoading.show(status: loadingBtnKey.tr());
      ResponseAPI result = await _chatService.getAllData();

      List<Chat> data = result.data;
      data.sort((a, b) =>
          DateTime.parse(b.createdAt!).compareTo(DateTime.parse(a.createdAt!)));

      if (result.statusCode! < 300) {
        emit(state.update(chatList: data));
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

  FutureOr<void> _onGetActiveInterview(
      GetActiveInterviewEvent event, Emitter<ChatState> emit) async {
    try {
      // EasyLoading.show(status: 'Loading...');
      EasyLoading.show(status: loadingBtnKey.tr());
      ResponseAPI result =
          await _interviewService.getActiveInterview(event.userId);
      if (result.statusCode! < 300) {
        emit(state.update(activeInterview: result.data));
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
      // logger.d('MESSAGE DATA: ${result.data}');
      // List<Message> data = [];
      // for (Message i in result.data) {
      //   i.createdAt = checkDateTime(i.createdAt ?? '');
      //   data.add(i);
      // }

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

  FutureOr<void> _onGetChatDataOfProject(
      GetChatListDataOfProjectEvent event, Emitter<ChatState> emit) async {
    try {
      // EasyLoading.show(status: 'Loading...');
      EasyLoading.show(status: loadingBtnKey.tr());
      ResponseAPI result =
          await _chatService.getChatDataOfProject(event.projectId);
      if (result.statusCode! < 300) {
        emit(state.update(chatListOfProject: result.data));
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

  FutureOr<void> _onGetChatItemOfProject(
      GetChatItemOfProjectEvent event, Emitter<ChatState> emit) async {
    try {
      // EasyLoading.show(status: 'Loading...');
      EasyLoading.show(status: loadingBtnKey.tr());
      ResponseAPI result =
          await _chatService.getChatDataOfProject(event.projectId);
      logger.d('PRO ID: ${event.projectId}');
      logger.d('MY ID: ${event.myId}');

      if (result.statusCode! < 300) {
        emit(state.update(chatListOfProject: result.data));
        for (Chat i in result.data) {
          if (i.receiver["id"] == event.myId || i.sender["id"] == event.myId) {
            emit(state.update(chatItem: i));
            break;
          }
        }
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
