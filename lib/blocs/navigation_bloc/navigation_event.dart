import 'package:flutter/widgets.dart';
import 'package:studenthub/blocs/navigation_bloc/navigation_type.dart';

@immutable
abstract class NavigatorStatusEvent {}

class UpdateNavigatorStatusEvent extends NavigatorStatusEvent {
  final NavigatorType navigatorType;

  UpdateNavigatorStatusEvent(this.navigatorType);
}
