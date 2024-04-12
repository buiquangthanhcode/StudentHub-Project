import 'dart:convert';

class RequestChangePassWord {
  final String oldPassword;
  final String newPassword;
  final String confirmPassword;
  final String? userId;

  RequestChangePassWord({
    required this.oldPassword,
    required this.newPassword,
    required this.confirmPassword,
    this.userId,
  });

  RequestChangePassWord copyWith({String? oldPassword, String? newPassword, String? confirmPassword, String? userId}) {
    return RequestChangePassWord(
      oldPassword: oldPassword ?? this.oldPassword,
      newPassword: newPassword ?? this.newPassword,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      userId: userId ?? this.userId,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'oldPassword': oldPassword});
    result.addAll({'newPassword': newPassword});
    result.addAll({'confirmPassword': confirmPassword});

    return result;
  }

  factory RequestChangePassWord.fromMap(Map<String, dynamic> map) {
    return RequestChangePassWord(
      oldPassword: map['oldPassword'] ?? '',
      newPassword: map['newPassword'] ?? '',
      confirmPassword: map['confirmPassword'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory RequestChangePassWord.fromJson(String source) => RequestChangePassWord.fromMap(json.decode(source));

  @override
  String toString() =>
      'RequestChangePassWord(oldPassword: $oldPassword, newPassword: $newPassword, confirmPassword: $confirmPassword)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is RequestChangePassWord &&
        other.oldPassword == oldPassword &&
        other.newPassword == newPassword &&
        other.confirmPassword == confirmPassword;
  }

  @override
  int get hashCode => oldPassword.hashCode ^ newPassword.hashCode ^ confirmPassword.hashCode;
}
