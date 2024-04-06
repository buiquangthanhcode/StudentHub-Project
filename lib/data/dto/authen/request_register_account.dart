import 'dart:convert';

class RequestRegisterAccount {
  String email;
  String password;
  String fullname;
  String role;
  RequestRegisterAccount({
    required this.email,
    required this.password,
    required this.fullname,
    required this.role,
  });

  RequestRegisterAccount copyWith({
    String? email,
    String? password,
    String? fullname,
    String? role,
  }) {
    return RequestRegisterAccount(
      email: email ?? this.email,
      password: password ?? this.password,
      fullname: fullname ?? this.fullname,
      role: role ?? this.role,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'email': email});
    result.addAll({'password': password});
    result.addAll({'fullname': fullname});
    result.addAll({'role': role});

    return result;
  }

  factory RequestRegisterAccount.fromMap(Map<String, dynamic> map) {
    return RequestRegisterAccount(
      email: map['email'] ?? '',
      password: map['password'] ?? '',
      fullname: map['fullname'] ?? '',
      role: map['role'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory RequestRegisterAccount.fromJson(String source) => RequestRegisterAccount.fromMap(json.decode(source));

  @override
  String toString() {
    return 'RequestRegisterAccount(email: $email, password: $password, fullname: $fullname, role: $role)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is RequestRegisterAccount &&
        other.email == email &&
        other.password == password &&
        other.fullname == fullname &&
        other.role == role;
  }

  @override
  int get hashCode {
    return email.hashCode ^ password.hashCode ^ fullname.hashCode ^ role.hashCode;
  }
}
