import 'package:equatable/equatable.dart';
import 'package:studenthub/models/common/user_model.dart';

class AuthenState extends Equatable {
  const AuthenState({
    required this.userModel,
  });

  final UserModel userModel;

  @override
  List<Object?> get props => [];
}
