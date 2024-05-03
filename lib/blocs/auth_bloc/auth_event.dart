import 'package:flutter/material.dart';
import 'package:studenthub/blocs/auth_bloc/auth_state.dart';
import 'package:studenthub/data/dto/authen/request_login.dart';
import 'package:studenthub/data/dto/authen/request_register_account.dart';
import 'package:studenthub/models/common/user_model.dart';

@immutable
abstract class AuthenEvent {}

class LoginEvent extends AuthenEvent {
  final RequestLogin requestLogin;
  final Function? onSuccess;
  final BuildContext? currentContext;

  LoginEvent({required this.requestLogin, required this.onSuccess, this.currentContext});
}

class GetInformationEvent extends AuthenEvent {
  final Function()? onSuccess;
  final String accessToken;
  final BuildContext? currentContext;
  final String? action;
  final Function(bool value)? onSuccessAuthenticated;

  GetInformationEvent(
      {required this.onSuccess,
      required this.accessToken,
      this.currentContext,
      this.action,
      this.onSuccessAuthenticated});
}

class RegisterAccount extends AuthenEvent {
  final RequestRegisterAccount requestRegister;
  final Function? onSuccess;

  RegisterAccount({required this.requestRegister, required this.onSuccess});
}

class LogoutEvent extends AuthenEvent {
  final String token;
  final Function? onSuccess;

  LogoutEvent({required this.token, required this.onSuccess});
}

class UpdateInformationEvent extends AuthenEvent {
  final UserModel userModel;

  UpdateInformationEvent({required this.userModel});
}

class UpdateRoleEvents extends AuthenEvent {
  final UserRole role;

  UpdateRoleEvents({required this.role});
}
