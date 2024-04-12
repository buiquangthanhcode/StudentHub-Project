import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:studenthub/blocs/auth_bloc/auth_event.dart';
import 'package:studenthub/blocs/auth_bloc/auth_state.dart';
import 'package:studenthub/data/dto/reponse.dart';
import 'package:studenthub/models/common/user_model.dart';
import 'package:studenthub/services/authen/authen.dart';
import 'package:studenthub/services/local_services.dart';
import 'package:studenthub/utils/helper.dart';
import 'package:studenthub/utils/logger.dart';
import 'package:studenthub/widgets/snack_bar_config.dart';

class AuthBloc extends Bloc<AuthenEvent, AuthenState> {
  AuthBloc()
      : super(
          AuthenState(userModel: UserModel()),
        ) {
    on<LoginEvent>(_onLogin);
    on<RegisterAccount>(_onRegisterAccount);
    on<GetInformationEvent>(_onFetchInformation);
    on<UpdateInformationEvent>(_onUpdateInformation);
  }

  final AuthService _authenService = AuthService();

  FutureOr<void> _onFetchInformation(
      GetInformationEvent event, Emitter<AuthenState> emit) async {
    try {
      ResponseAPI result =
          await _authenService.fetchInformation(event.accessToken);

      if (result.statusCode! < 300) {
        logger.i(UserModel.fromMap(result.data.resultMap.toMap()));
        emit(AuthenState(
            userModel: UserModel.fromMap(result.data.resultMap.toMap())));

        event.onSuccess!(); // Call onSuccessCallBack
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

  FutureOr<void> _onUpdateInformation(
      UpdateInformationEvent event, Emitter<AuthenState> emit) async {
    try {
      logger.d('data update: ${event.userModel.company}');
      emit(AuthenState(userModel: event.userModel));
    } catch (e) {
      logger.e(e);
    }
  }

  FutureOr<void> _onLogin(LoginEvent event, Emitter<AuthenState> emit) async {
    try {
      EasyLoading.show(status: 'Loading...');
      ResponseAPI result = await _authenService.login(
        event.requestLogin,
      );
      if (result.statusCode! < 300) {
        LocalStorageService localService = LocalStorageService();
        await localService.saveTokens(
            accessToken: result.data?.resultMap?.token ?? '');
        Future.delayed(const Duration(milliseconds: 500), () {
          // for get token and call API me to get more information
          add(GetInformationEvent(
              accessToken: result.data?.resultMap?.token ?? '',
              onSuccess: () {
                event.onSuccess!();
              }));
        });
      } else {
        SnackBarService.showSnackBar(
            content: handleFormatMessage(result.data!.errorDetails),
            status: StatusSnackBar.error);
      }
      EasyLoading.dismiss();
    } on DioException catch (e) {
      logger.e(
        "DioException:${e.response}",
      );
    } catch (e) {
      logger.e("Unexpected error-> $e");
      SnackBarService.showSnackBar(
          content: handleFormatMessage(e.toString()),
          status: StatusSnackBar.error);
    } finally {
      EasyLoading.dismiss();
    }
  }

  Future<FutureOr<void>> _onRegisterAccount(
      RegisterAccount event, Emitter<AuthenState> emit) async {
    try {
      EasyLoading.show(status: 'Loading...');
      ResponseAPI result = await _authenService.register(
        event.requestRegister,
      );
      logger.i(result);
      if (result.statusCode! < 300) {
        event.onSuccess!(); // Call onSuccessCallBack
      } else {
        SnackBarService.showSnackBar(
            content: handleFormatMessage(result.data!.errorDetails),
            status: StatusSnackBar.error);
      }
      EasyLoading.dismiss();
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
