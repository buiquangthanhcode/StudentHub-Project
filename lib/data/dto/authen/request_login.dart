import 'dart:convert';

class RequestLogin {
  String email;
  String password;
  RequestLogin({
    required this.email,
    required this.password,
  });

  RequestLogin copyWith({
    String? email,
    String? password,
  }) {
    return RequestLogin(
      email: email ?? this.email,
      password: password ?? this.password,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'email': email});
    result.addAll({'password': password});

    return result;
  }

  factory RequestLogin.fromMap(Map<String, dynamic> map) {
    return RequestLogin(
      email: map['email'] ?? '',
      password: map['password'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory RequestLogin.fromJson(String source) => RequestLogin.fromMap(json.decode(source));

  @override
  String toString() => 'RequestLogin(email: $email, password: $password)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is RequestLogin && other.email == email && other.password == password;
  }

  @override
  int get hashCode => email.hashCode ^ password.hashCode;
}
