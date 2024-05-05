import 'package:equatable/equatable.dart';
import 'package:studenthub/models/common/user_model.dart';
import 'package:studenthub/utils/logger.dart';

enum UserRole {
  student,
  company,
  admin,
  manager,
}

class AuthenState extends Equatable {
  const AuthenState({
    required this.userModel,
    required this.isChanged,
    required this.currentRole,
    required this.isLoading,
    required this.isAuthented,
  });

  final UserModel userModel;
  final bool isChanged;
  final UserRole currentRole;
  final bool? isLoading;
  final bool isAuthented;

  @override
  List<Object?> get props => [userModel, isChanged, currentRole, isLoading, isAuthented];

  int? getCurrentUserId() {
    try {
      if (currentRole == UserRole.student) {
        return userModel.student!.id;
      } else if (currentRole == UserRole.company) {
        return userModel.company!.id;
      } else if (currentRole == UserRole.admin) {
        // return userModel.admin!.id;
      } else if (currentRole == UserRole.manager) {
        // return userModel.manager!.id;
      }
      return null;
    } catch (e) {
      logger.e(e);
      return null;
    }
  }

  bool isCompanyRole() {
    return currentRole == UserRole.company;
  }

  bool isStudentRole() {
    return currentRole == UserRole.student;
  }

  bool isAnonymus() {
    return userModel.student == null && userModel.company == null;
  }

  AuthenState update({
    UserModel? userModel,
    bool? isChanged,
    UserRole? currentRole,
    bool? isLoading,
    bool? isAuthented,
  }) {
    return AuthenState(
      userModel: userModel ?? this.userModel,
      isChanged: isChanged ?? this.isChanged,
      currentRole: currentRole ?? this.currentRole,
      isLoading: isLoading ?? this.isLoading,
      isAuthented: isAuthented ?? this.isAuthented,
    );
  }
}
