abstract class GlobalEvent {}

class GetAllTeckStackEventMetadata extends GlobalEvent {
  final Function(dynamic value)? onSuccess;
  GetAllTeckStackEventMetadata({this.onSuccess});
}

class GetAllSkillSetEventMetadata extends GlobalEvent {
  final Function(dynamic value)? onSuccess;
  GetAllSkillSetEventMetadata({this.onSuccess});
}
