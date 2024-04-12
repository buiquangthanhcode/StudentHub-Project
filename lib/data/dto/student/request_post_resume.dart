import 'package:dio/dio.dart';

class RequestPostResume {
  String studentId;
  List<MultipartFile>? file;
  RequestPostResume({
    required this.studentId,
    this.file,
  });

  RequestPostResume copyWith({
    String? studentId,
    List<MultipartFile>? file,
  }) {
    return RequestPostResume(
      studentId: studentId ?? this.studentId,
      file: file ?? this.file,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
    result.addAll({
      'studentId': studentId,
      'file': file,
    });
    return result;
  }
}
