import 'package:equatable/equatable.dart';
import 'package:studenthub/models/common/user_model.dart';

class AuthenState extends Equatable {
  const AuthenState({
    required this.userModel,
    required this.isChanged,
  });

  final UserModel userModel;
  final bool isChanged;

  @override
  List<Object?> get props => [userModel, isChanged];

  AuthenState update({
    UserModel? userModel,
    bool? isChanged,
  }) {
    return AuthenState(
      userModel: userModel ?? this.userModel,
      isChanged: isChanged ?? this.isChanged,
    );
  }
}
