import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:studenthub/models/company/company_model.dart';
import 'package:studenthub/models/student/student_model.dart';

class ResponseAPI {
  DataResponse? data;
  int? statusCode;
  ResponseAPI({
    this.data,
    this.statusCode,
  });

  ResponseAPI copyWith({
    DataResponse? data,
    int? statusCode,
  }) {
    return ResponseAPI(
      data: data ?? this.data,
      statusCode: statusCode ?? this.statusCode,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (data != null) {
      result.addAll({'data': data!.toMap()});
    }
    if (statusCode != null) {
      result.addAll({'statusCode': statusCode});
    }

    return result;
  }

  factory ResponseAPI.fromMap(Map<String, dynamic> map) {
    return ResponseAPI(
      data: map['data'] != null ? DataResponse.fromMap(map['data']) : null,
      statusCode: map['statusCode'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ResponseAPI.fromJson(String source) =>
      ResponseAPI.fromMap(json.decode(source));

  @override
  String toString() => 'ResponseAPI(data: $data, statusCode: $statusCode)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ResponseAPI &&
        other.data == data &&
        other.statusCode == statusCode;
  }

  @override
  int get hashCode => data.hashCode ^ statusCode.hashCode;
}

class DataResponse {
  String? success;
  String? requestId;
  dynamic
      errorDetails; // Because API return errorDetails return String or Array
  String? stack;
  Result? result;
  // add more attribute here when
  DataResponse({
    this.success,
    this.requestId,
    this.errorDetails,
    this.stack,
    this.result,
  });

  DataResponse copyWith({
    String? success,
    String? requestId,
    dynamic errorDetails,
    String? stack,
    Result? result,
  }) {
    return DataResponse(
      success: success ?? this.success,
      requestId: requestId ?? this.requestId,
      errorDetails: errorDetails ?? this.errorDetails,
      stack: stack ?? this.stack,
      result: result ?? this.result,
    );
  }

  Map<String, dynamic> toMap() {
    final resultData = <String, dynamic>{};

    if (success != null) {
      resultData.addAll({'success': success});
    }
    if (requestId != null) {
      resultData.addAll({'requestId': requestId});
    }
    if (errorDetails != null) {
      resultData.addAll({'errorDetails': errorDetails});
    }
    if (stack != null) {
      resultData.addAll({'stack': stack});
    }
    if (result != null) {
      resultData.addAll({'result': result});
    }

    return resultData;
  }

  factory DataResponse.fromMap(Map<String, dynamic> map) {
    return DataResponse(
      success: map['success'],
      requestId: map['requestId'],
      errorDetails: map['errorDetails'],
      stack: map['stack'],
      result: map['result'] != null ? Result.fromMap(map['result']) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory DataResponse.fromJson(String source) {
    return DataResponse.fromMap(json.decode(source));
  }

  @override
  String toString() {
    return 'DataResponse( errorDetails: $errorDetails, success: $success, requestId: $requestId, stack: $stack, result: $result,)';
  }
}

class Result {
  int? id;
  List<String>? roles;
  Student? student;
  Company? company;
  String? token;
  Result({this.id, this.roles, this.student, this.company, this.token});

  Result copyWith({
    int? id,
    List<String>? roles,
    Student? student,
    Company? company,
    String? token,
  }) {
    return Result(
        id: id ?? this.id,
        roles: roles ?? this.roles,
        student: student ?? this.student,
        company: company ?? this.company,
        token: token ?? this.token);
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (id != null) {
      result.addAll({'id': id});
    }
    if (roles != null) {
      result.addAll({'roles': roles});
    }
    if (student != null) {
      result.addAll({'student': student!.toMap()});
    }
    if (company != null) {
      result.addAll({'company': company!.toMap()});
    }
    if (token != null) {
      result.addAll({'token': token});
    }

    return result;
  }

  factory Result.fromMap(Map<String, dynamic> map) {
    return Result(
        id: map['id'] != null ? map['id'].toInt() : null,
        roles: map['roles'] != null ? List<String>.from(map['roles']) : null,
        student:
            map['student'] != null ? Student.fromMap(map['student']) : null,
        company:
            map['company'] != null ? Company.fromMap(map['company']) : null,
        token: map['token'] != null ? map['token'] : null);
  }

  String toJson() => json.encode(toMap());

  factory Result.fromJson(String source) => Result.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Result(id: $id, roles: $roles, student: $student, company: $company)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Result &&
        other.id == id &&
        listEquals(other.roles, roles) &&
        other.student == student &&
        other.company == company;
  }

  @override
  int get hashCode {
    return id.hashCode ^ roles.hashCode ^ student.hashCode ^ company.hashCode;
  }
}
