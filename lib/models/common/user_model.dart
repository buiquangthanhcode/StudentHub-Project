import 'dart:convert';

class CurrentUserModel {
  String? id;
  String? name;
  String? email;
  String? photoUrl;
  String? role;
  String? token;
  // Add more here according template

  CurrentUserModel({
    this.id,
    this.name,
    this.email,
    this.photoUrl,
    this.role,
    this.token,
  });

  CurrentUserModel copyWith({
    String? id,
    String? name,
    String? email,
    String? photoUrl,
    String? role,
    String? token,
  }) {
    return CurrentUserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      photoUrl: photoUrl ?? this.photoUrl,
      role: role ?? this.role,
      token: token ?? this.token,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (id != null) {
      result.addAll({'id': id});
    }
    if (name != null) {
      result.addAll({'name': name});
    }
    if (email != null) {
      result.addAll({'email': email});
    }
    if (photoUrl != null) {
      result.addAll({'photoUrl': photoUrl});
    }
    if (role != null) {
      result.addAll({'role': role});
    }
    if (token != null) {
      result.addAll({'token': token});
    }

    return result;
  }

  factory CurrentUserModel.fromMap(Map<String, dynamic> map) {
    return CurrentUserModel(
      id: map['id'],
      name: map['name'],
      email: map['email'],
      photoUrl: map['photoUrl'],
      role: map['role'],
      token: map['token'],
    );
  }

  String toJson() => json.encode(toMap());

  factory CurrentUserModel.fromJson(String source) => CurrentUserModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'CurrentUserModel(id: $id, name: $name, email: $email, photoUrl: $photoUrl, role: $role, token: $token)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CurrentUserModel &&
        other.id == id &&
        other.name == name &&
        other.email == email &&
        other.photoUrl == photoUrl &&
        other.role == role &&
        other.token == token;
  }

  @override
  int get hashCode {
    return id.hashCode ^ name.hashCode ^ email.hashCode ^ photoUrl.hashCode ^ role.hashCode ^ token.hashCode;
  }
}
