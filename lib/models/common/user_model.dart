// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:studenthub/models/company/company_model.dart';
import 'package:studenthub/models/student/student_model.dart';

class UserModel {
  int? id;
  String? name;
  String? email;
  String? photoUrl;
  List<int>? roles;
  String? token;
  Company? company;
  Student? student;

  UserModel({
    this.id,
    this.name,
    this.email,
    this.photoUrl,
    this.roles,
    this.token,
    this.company,
    this.student,
  });

  UserModel copyWith({
    int? id,
    String? name,
    String? email,
    String? photoUrl,
    List<int>? roles,
    String? token,
    Company? company,
    Student? student,
  }) {
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      photoUrl: photoUrl ?? this.photoUrl,
      roles: roles ?? this.roles,
      token: token ?? this.token,
      company: company ?? this.company,
      student: student ?? this.student,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'email': email,
      'photoUrl': photoUrl,
      'roles': roles,
      'token': token,
      'company': company?.toMap(),
      'student': student?.toMap(),
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'] != null ? map['id'] as int : null,
      name: map['name'] != null ? map['name'] as String : null,
      email: map['email'] != null ? map['email'] as String : null,
      photoUrl: map['photoUrl'] != null ? map['photoUrl'] as String : null,
      roles: map['roles'] != null ? List<int>.from((map['roles'] as List<int>)) : null,
      token: map['token'] != null ? map['token'] as String : null,
      company: map['company'] != null ? Company.fromMap(map['company'] as Map<String, dynamic>) : null,
      student: map['student'] != null ? Student.fromMap(map['student'] as Map<String, dynamic>) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) => UserModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'UserModel(id: $id, name: $name, email: $email, photoUrl: $photoUrl, roles: $roles, token: $token, student: $student)';
  }

  @override
  bool operator ==(covariant UserModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        other.email == email &&
        other.photoUrl == photoUrl &&
        listEquals(other.roles, roles) &&
        other.token == token &&
        other.company == company &&
        other.student == student;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        email.hashCode ^
        photoUrl.hashCode ^
        roles.hashCode ^
        token.hashCode ^
        company.hashCode ^
        student.hashCode;
  }
}
