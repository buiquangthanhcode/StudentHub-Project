abstract class GlobalEvent {}

class GetAllTeckStackEventMetadata extends GlobalEvent {
  final Function(dynamic value)? onSuccess;
  GetAllTeckStackEventMetadata({this.onSuccess});
}

class GetAllSkillSetEventMetadata extends GlobalEvent {
  final Function(dynamic value)? onSuccess;
  GetAllSkillSetEventMetadata({this.onSuccess});
}

class ResetPasswordEvent extends GlobalEvent {
  final String email;
  final Function? onSuccess;
  ResetPasswordEvent({required this.email, this.onSuccess});
}

class SetIsFirtTimeAccessApp extends GlobalEvent {
  final bool isFirtTimeAccessApp;
  SetIsFirtTimeAccessApp({required this.isFirtTimeAccessApp});
}