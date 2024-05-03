import 'package:equatable/equatable.dart';
import 'package:studenthub/blocs/navigation_bloc/navigation_type.dart';

class NavigatorStatusState extends Equatable {
  final NavigatorType navigatorType;

  const NavigatorStatusState({
    required this.navigatorType,
  });

  NavigatorStatusState update({
    NavigatorType? navigatorType,
    bool? reload,
  }) {
    return NavigatorStatusState(
      navigatorType: navigatorType ?? this.navigatorType,
    );
  }

  @override
  List<Object> get props => [
        navigatorType,
      ];
}
