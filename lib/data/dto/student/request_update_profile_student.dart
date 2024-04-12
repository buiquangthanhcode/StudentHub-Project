import 'dart:convert';

import 'package:flutter/foundation.dart';

class RequestUpdateProfileStudent {
  final int? techStackId;
  final int? userId;
  final List<String>? skillSets;
  RequestUpdateProfileStudent({
    this.techStackId,
    this.userId,
    this.skillSets,
  });

  RequestUpdateProfileStudent copyWith({
    int? techStackId,
    int? userId,
    List<String>? skillSets,
  }) {
    return RequestUpdateProfileStudent(
      techStackId: techStackId ?? this.techStackId,
      userId: userId ?? this.userId,
      skillSets: skillSets ?? this.skillSets,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (techStackId != null) {
      result.addAll({'techStackId': techStackId});
    }
    // if (userId != null) {
    //   result.addAll({'userId': userId});
    // }
    if (skillSets != null) {
      result.addAll({'skillSets': skillSets});
    }

    return result;
  }

  factory RequestUpdateProfileStudent.fromMap(Map<String, dynamic> map) {
    return RequestUpdateProfileStudent(
      techStackId: map['techStackId']?.toInt(),
      userId: map['userId']?.toInt(),
      skillSets: List<String>.from(map['skillSets']),
    );
  }

  String toJson() => json.encode(toMap());

  factory RequestUpdateProfileStudent.fromJson(String source) =>
      RequestUpdateProfileStudent.fromMap(json.decode(source));

  @override
  String toString() => 'RequestUpdateProfileStudent(techStackId: $techStackId, userId: $userId, skillSets: $skillSets)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is RequestUpdateProfileStudent &&
        other.techStackId == techStackId &&
        other.userId == userId &&
        listEquals(other.skillSets, skillSets);
  }

  @override
  int get hashCode => techStackId.hashCode ^ userId.hashCode ^ skillSets.hashCode;
}
