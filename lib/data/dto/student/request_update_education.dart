import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:studenthub/models/student/student_create_profile/education_model.dart';

class RequestUpdateEducation {
  int userid;
  List<Education> educations;
  RequestUpdateEducation({
    required this.userid,
    required this.educations,
  });

  RequestUpdateEducation copyWith({
    int? userid,
    List<Education>? educations,
  }) {
    return RequestUpdateEducation(
      userid: userid ?? this.userid,
      educations: educations ?? this.educations,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'userid': userid});
    result.addAll({'educations': educations.map((x) => x.toMap()).toList()});

    return result;
  }

  factory RequestUpdateEducation.fromMap(Map<String, dynamic> map) {
    return RequestUpdateEducation(
      userid: map['userid'] ?? '',
      educations: List<Education>.from(map['educations']?.map((x) => Education.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory RequestUpdateEducation.fromJson(String source) => RequestUpdateEducation.fromMap(json.decode(source));

  @override
  String toString() => 'RequestUpdateEducation(userid: $userid, educations: $educations)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is RequestUpdateEducation && other.userid == userid && listEquals(other.educations, educations);
  }

  @override
  int get hashCode => userid.hashCode ^ educations.hashCode;
}
