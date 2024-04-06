import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:studenthub/models/student/student_create_profile/language_model.dart';

class RequestUpdateLanguage {
  String userid;
  List<Language> languages;
  RequestUpdateLanguage({
    required this.userid,
    required this.languages,
  });

  RequestUpdateLanguage copyWith({
    String? userid,
    List<Language>? languages,
  }) {
    return RequestUpdateLanguage(
      userid: userid ?? this.userid,
      languages: languages ?? this.languages,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'userid': userid});
    result.addAll({'languages': languages.map((x) => x.toMap()).toList()});

    return result;
  }

  factory RequestUpdateLanguage.fromMap(Map<String, dynamic> map) {
    return RequestUpdateLanguage(
      userid: map['userid'] ?? '',
      languages: List<Language>.from(map['languages']?.map((x) => Language.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory RequestUpdateLanguage.fromJson(String source) => RequestUpdateLanguage.fromMap(json.decode(source));

  @override
  String toString() => 'RequestUpdateLanguage(userid: $userid, languages: $languages)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is RequestUpdateLanguage && other.userid == userid && listEquals(other.languages, languages);
  }

  @override
  int get hashCode => userid.hashCode ^ languages.hashCode;
}
