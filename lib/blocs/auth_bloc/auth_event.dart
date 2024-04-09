import 'package:flutter/material.dart';
import 'package:studenthub/data/dto/authen/request_login.dart';
import 'package:studenthub/data/dto/authen/request_register_account.dart';
import 'package:studenthub/models/common/user_model.dart';

@immutable
abstract class AuthenEvent {}

class LoginEvent extends AuthenEvent {
  final RequestLogin requestLogin;
  final Function? onSuscess;

  LoginEvent({required this.requestLogin, required this.onSuscess});
}

class GetInformationEvent extends AuthenEvent {
  final Function? onSuscess;
  final String accessToken;

  GetInformationEvent({required this.onSuscess, required this.accessToken});
}

class RegisterAccount extends AuthenEvent {
  final RequestRegisterAccount requestRegister;
  final Function? onSuscess;

  RegisterAccount({required this.requestRegister, required this.onSuscess});
}

class LogoutEvent extends AuthenEvent {
  final String token;
  final Function? onSuscess;

  LogoutEvent({required this.token, required this.onSuscess});
}

class UpdateInformationEvent extends AuthenEvent {
  final UserModel userModel;

  UpdateInformationEvent({required this.userModel});
}
