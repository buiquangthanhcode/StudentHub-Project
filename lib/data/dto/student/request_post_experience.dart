import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:studenthub/models/student/student_create_profile/project_model.dart';

class RequestPostExperience {
  final List<ProjectResume> experience;
  final String userId;
  RequestPostExperience({
    required this.experience,
    required this.userId,
  });

  RequestPostExperience copyWith({
    List<ProjectResume>? experience,
    String? userId,
  }) {
    return RequestPostExperience(
      experience: experience ?? this.experience,
      userId: userId ?? this.userId,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'experience': experience.map((x) => x.toMap()).toList()});

    return result;
  }

  factory RequestPostExperience.fromMap(Map<String, dynamic> map) {
    return RequestPostExperience(
      experience: List<ProjectResume>.from(map['experience']?.map((x) => ProjectResume.fromMap(x))),
      userId: map['userId'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory RequestPostExperience.fromJson(String source) => RequestPostExperience.fromMap(json.decode(source));

  @override
  String toString() => 'RequestPostExperience(experience: $experience, userId: $userId)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is RequestPostExperience && listEquals(other.experience, experience) && other.userId == userId;
  }

  @override
  int get hashCode => experience.hashCode ^ userId.hashCode;
}
