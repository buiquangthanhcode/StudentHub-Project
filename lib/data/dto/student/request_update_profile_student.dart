import 'dart:convert';

import 'package:flutter/foundation.dart';

class RequestUpdateProfileStudent {
  final int techStackId;
  final int userId;
  final List<String> skillSets;
  RequestUpdateProfileStudent({
    required this.techStackId,
    required this.skillSets,
    required this.userId,
  });

  RequestUpdateProfileStudent copyWith({
    int? techStackId,
    List<String>? skillSets,
    int? userId,
  }) {
    return RequestUpdateProfileStudent(
      techStackId: techStackId ?? this.techStackId,
      skillSets: skillSets ?? this.skillSets,
      userId: userId ?? this.userId,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'techStackId': techStackId});
    result.addAll({'skillSets': skillSets});

    return result;
  }

  factory RequestUpdateProfileStudent.fromMap(Map<String, dynamic> map) {
    return RequestUpdateProfileStudent(
      techStackId: map['techStackId']?.toInt() ?? 0,
      skillSets: List<String>.from(map['skillSets']),
      userId: map['userId']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory RequestUpdateProfileStudent.fromJson(String source) =>
      RequestUpdateProfileStudent.fromMap(json.decode(source));

  @override
  String toString() => 'RequestUpdateProfileStudent(techStackId: $techStackId, skillSets: $skillSets)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is RequestUpdateProfileStudent &&
        other.techStackId == techStackId &&
        listEquals(other.skillSets, skillSets);
  }

  @override
  int get hashCode => techStackId.hashCode ^ skillSets.hashCode;
}
