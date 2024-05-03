import 'dart:async';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:studenthub/blocs/auth_bloc/auth_event.dart';
import 'package:studenthub/blocs/auth_bloc/auth_state.dart';
import 'package:studenthub/blocs/student_bloc/student_bloc.dart';
import 'package:studenthub/blocs/student_bloc/student_event.dart';
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
          AuthenState(
            userModel: UserModel(),
            isChanged: false,
            currentRole: UserRole.student,
            isLoading: false,
            isAuthented: false,
          ),
        ) {
    on<LoginEvent>(_onLogin);
    on<RegisterAccount>(_onRegisterAccount);
    on<GetInformationEvent>(_onFetchInformation);
    on<UpdateInformationEvent>(_onUpdateInformation);
    on<UpdateRoleEvents>(_onUpdateRole);
  }

  final AuthService _authenService = AuthService();

  FutureOr<void> _onFetchInformation(GetInformationEvent event, Emitter<AuthenState> emit) async {
    try {
      if (event.action == 'login') {
        EasyLoading.show(status: 'Loading...');
      }
      emit(state.update(isLoading: true));
      ResponseAPI result = await _authenService.fetchInformation(event.accessToken);
      if (result.statusCode! < 300) {
        emit(
            state.update(userModel: UserModel.fromMap({...result.data.resultMap.toMap(), 'token': event.accessToken})));

        if (state.userModel.student != null) {
          event.currentContext?.read<StudentBloc>().add(
                UpdateStudentEvent(student: state.userModel.student!, isChange: true),
              );
        }

        add(UpdateRoleEvents(role: (state.userModel.student != null ? UserRole.student : UserRole.company)));

        if (state.userModel.company == null && state.userModel.student == null && state.userModel.roles?[0] == 0) {
          add(UpdateRoleEvents(role: UserRole.student));
        }

        if (state.userModel.company == null && state.userModel.student == null && state.userModel.roles?[0] == 1) {
          add(UpdateRoleEvents(role: UserRole.company));
        }

        emit(state.update(isChanged: !state.isChanged));
        emit(state.update(isAuthented: true));
        event.onSuccess!(); // Call onSuccessCallBack
        if (event.onSuccessAuthenticated != null) {
          event.onSuccessAuthenticated!(true);
        }
        if (event.action == 'login') {
          EasyLoading.dismiss();
        }
      } else if (result.statusCode! == 401) {
        emit(state.update(isLoading: false, isAuthented: false));
        if (event.onSuccessAuthenticated != null) {
          event.onSuccessAuthenticated!(false);
        }
      } else {
        SnackBarService.showSnackBar(
            content: handleFormatMessage(result.data!.errorDetails), status: StatusSnackBar.error);
      }
      emit(state.update(isLoading: false));
    } on DioException catch (e) {
      emit(state.update(isLoading: false));
      logger.e(
        "DioException:${e.response}",
      );
    } catch (e) {
      emit(state.update(isLoading: false));
      logger.e("Unexpect error-> $e");
      SnackBarService.showSnackBar(content: handleFormatMessage(e.toString()), status: StatusSnackBar.error);
    } finally {}
  }

  FutureOr<void> _onUpdateInformation(UpdateInformationEvent event, Emitter<AuthenState> emit) async {
    try {
      emit(state.update(userModel: event.userModel));
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
        await localService.saveTokens(accessToken: result.data?.resultMap?.token ?? '');
        add(GetInformationEvent(
            accessToken: result.data?.resultMap?.token ?? '',
            onSuccess: () {
              event.onSuccess!();
            },
            currentContext: event.currentContext,
            action: "login"));
      } else {
        SnackBarService.showSnackBar(
            content: handleFormatMessage(result.data!.errorDetails), status: StatusSnackBar.error);
      }
      EasyLoading.dismiss();
    } on DioException catch (e) {
      logger.e(
        "DioException2:${e.response?.data.resultMap.errorDetails}",
      );
      SnackBarService.showSnackBar(
          content: handleFormatMessage(e.response?.data.resultMap!.errorDetails), status: StatusSnackBar.error);
    } catch (e) {
      logger.e("Unexpected error1-> $e");
      final exception = e as ResponseAPI;
      SnackBarService.showSnackBar(
          content: handleFormatMessage(exception.data['errorDetails']), status: StatusSnackBar.error);
    } finally {
      EasyLoading.dismiss();
    }
  }

  Future<FutureOr<void>> _onRegisterAccount(RegisterAccount event, Emitter<AuthenState> emit) async {
    try {
      EasyLoading.show(status: 'Loading...');
      ResponseAPI result = await _authenService.register(
        event.requestRegister,
      );
      if (result.statusCode! < 300) {
        event.onSuccess!(); // Call onSuccessCallBack
      } else {
        SnackBarService.showSnackBar(
            content: handleFormatMessage(result.data!.errorDetails), status: StatusSnackBar.error);
      }
      EasyLoading.dismiss();
    } catch (e) {
      final exception = e as ResponseAPI;
      final data = exception.data as DataResponse;
      SnackBarService.showSnackBar(content: handleFormatMessage(data.errorDetails), status: StatusSnackBar.error);
    } finally {
      EasyLoading.dismiss();
    }
  }

  FutureOr<void> _onUpdateRole(UpdateRoleEvents event, Emitter<AuthenState> emit) async {
    try {
      emit(state.update(currentRole: event.role, isChanged: !state.isChanged));
    } catch (e) {
      logger.e(e);
    }
  }
}
