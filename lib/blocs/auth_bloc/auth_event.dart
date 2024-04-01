import 'package:flutter/material.dart';
import 'package:studenthub/data/dto/authen/request_login.dart';

@immutable
abstract class AuthenEvent {}

class LoginEvent extends AuthenEvent {
  final RequestLogin requestLogin;
  final Function? onSuscess;

  LoginEvent({required this.requestLogin, required this.onSuscess});
}

//