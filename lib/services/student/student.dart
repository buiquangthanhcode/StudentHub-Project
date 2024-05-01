import 'dart:async';
import 'package:dio/dio.dart';
import 'package:studenthub/blocs/student_bloc/student_event.dart';
import 'package:studenthub/data/dto/reponse.dart';
import 'package:studenthub/data/dto/student/request_change_password.dart';
import 'package:studenthub/data/dto/student/request_post_experience.dart';
import 'package:studenthub/data/dto/student/request_post_proposal.dart';
import 'package:studenthub/data/dto/student/request_post_resume.dart';
import 'package:studenthub/data/dto/student/request_update_education.dart';
import 'package:studenthub/data/dto/student/request_update_language.dart';
import 'package:studenthub/data/dto/student/request_update_profile_student.dart';
import 'package:studenthub/models/common/project_proposal_modal.dart';
import 'package:studenthub/models/common/proposal_modal.dart';
import 'package:studenthub/models/student/student_create_profile/education_model.dart';
import 'package:studenthub/models/student/student_create_profile/language_model.dart';
import 'package:studenthub/models/student/student_create_profile/project_model.dart';
import 'package:studenthub/models/student/student_create_profile/skillset_model.dart';
import 'package:studenthub/models/student/student_create_profile/tech_stack.dart';
import 'package:studenthub/models/student/student_model.dart';
import 'package:studenthub/services/api_interceptor.dart';
import 'package:studenthub/services/dio_client.dart';
import 'package:studenthub/services/endpoint.dart';
import 'package:studenthub/utils/logger.dart';

class StudentService {
  late DioClient dioClient;

  StudentService() {
    var dio = Dio();
    AppInterceptors interceptors = AppInterceptors(dio);
    dioClient = DioClient(dio, interceptors: [interceptors]);
  }

  Future<ResponseAPI<List<TechStack>>> getAllTechStack() async {
    try {
      final res = await dioClient.get(
        '$baseURL/api/techstack/getAllTechStack',
      );

      return ResponseAPI<List<TechStack>>(
        statusCode: res.statusCode,
        data: List<TechStack>.from(res.data['result'].map((x) => TechStack.fromMap((x)))).toList(),
      );
    } on DioException catch (e) {
      logger.e(
        "DioException :${e.response}",
      );
      throw ResponseAPI<List<TechStack>>(
        statusCode: e.response?.statusCode,
        data: [],
      );
    } catch (e) {
      logger.e("Unexpected Error: $e");
      rethrow;
    }
  }

  Future<ResponseAPI> postProfileStudent(RequestUpdateProfileStudent profile) async {
    try {
      final res = await dioClient.post(
        '$baseURL/api/profile/student',
        data: profile.toJson(),
      );

      return ResponseAPI(
        statusCode: res.statusCode,
        data: [],
      );
    } on DioException catch (e) {
      logger.e(
        "DioException :${e.response}",
      );
      throw ResponseAPI(
        statusCode: e.response?.statusCode,
        data: [],
      );
    } catch (e) {
      logger.e("Unexpected Error: $e");
      rethrow;
    }
  }

  Future<ResponseAPI<Student>> updateProfileStudent(RequestUpdateProfileStudent profile) async {
    try {
      final res = await dioClient.put(
        '$baseURL/api/profile/student/${profile.userId}',
        data: profile.toJson(),
      );

      return ResponseAPI<Student>(
        statusCode: res.statusCode,
        data: Student.fromMap(res.data['result']),
      );
    } on DioException catch (e) {
      logger.e(
        "DioException :${e.response}",
      );
      throw ResponseAPI<Student>(
        statusCode: e.response?.statusCode,
        data: Student.fromMap(e.response?.data['result']),
      );
    } catch (e) {
      logger.e("Unexpected Error: $e");
      rethrow;
    }
  }

  Future<ResponseAPI<List<SkillSet>>> getAllSkillSet() async {
    try {
      final res = await dioClient.get(
        '$baseURL/api/skillset/getAllSkillSet',
      );

      return ResponseAPI<List<SkillSet>>(
        statusCode: res.statusCode,
        data: List<SkillSet>.from(res.data['result'].map((x) => SkillSet.fromMap((x)))).toList(),
      );
    } on DioException catch (e) {
      logger.e(
        "DioException :${e.response}",
      );
      throw ResponseAPI<List<SkillSet>>(
        statusCode: e.response?.statusCode,
        data: [],
      );
    } catch (e) {
      logger.e("Unexpected Error: $e");
      rethrow;
    }
  }

  Future<ResponseAPI> updateLanguage(RequestUpdateLanguage requestUpdateLanguage) async {
    try {
      final res = await dioClient.put(
        '$baseURL/api/language/updateByStudentId/${requestUpdateLanguage.userid}',
        data: requestUpdateLanguage.toJson(),
      );

      return ResponseAPI(
        statusCode: res.statusCode,
        data: [],
      );
    } on DioException catch (e) {
      logger.e(
        "DioException :${e.response}",
      );
      throw ResponseAPI(
        statusCode: e.response?.statusCode,
        data: [],
      );
    } catch (e) {
      logger.e("Unexpected Error: $e");
      rethrow;
    }
  }

  Future<ResponseAPI<List<Language>>> getAllLanguage(int userid) async {
    try {
      final res = await dioClient.get(
        '$baseURL/api/language/getByStudentId/$userid',
      );
      return ResponseAPI<List<Language>>(
        statusCode: res.statusCode,
        data: List<Language>.from(res.data['result'].map((x) => Language.fromMap((x)))).toList(),
      );
    } on DioException catch (e) {
      logger.e(
        "DioException :${e.response}",
      );
      throw ResponseAPI<List<Language>>(
        statusCode: e.response?.statusCode,
        data: [],
      );
    } catch (e) {
      logger.e("Unexpected Error: $e");
      rethrow;
    }
  }

  Future<ResponseAPI<List<Education>>> getAllEducation(int userid) async {
    try {
      final res = await dioClient.get(
        '$baseURL/api/education/getByStudentId/$userid',
      );
      return ResponseAPI<List<Education>>(
        statusCode: res.statusCode,
        data: List<Education>.from(res.data['result'].map((x) => Education.fromMap((x)))).toList(),
      );
    } on DioException catch (e) {
      logger.e(
        "DioException :${e.response}",
      );
      throw ResponseAPI<List<Education>>(
        statusCode: e.response?.statusCode,
        data: [],
      );
    } catch (e) {
      logger.e("Unexpected Error: $e");
      rethrow;
    }
  }

  Future<ResponseAPI> updateEducation(RequestUpdateEducation requestUpdateEducation) async {
    try {
      final res = await dioClient.put(
        '$baseURL/api/education/updateByStudentId/${requestUpdateEducation.userid}',
        data: requestUpdateEducation.toJson(),
      );

      return ResponseAPI(
        statusCode: res.statusCode,
        data: [],
      );
    } on DioException catch (e) {
      logger.e(
        "DioException :${e.response}",
      );
      throw ResponseAPI(
        statusCode: e.response?.statusCode,
        data: [],
      );
    } catch (e) {
      logger.e("Unexpected Error: $e");
      rethrow;
    }
  }

  Future<ResponseAPI<List<ProjectResume>>> updateExperience(RequestPostExperience requestPostExperience) async {
    try {
      final res = await dioClient.put(
        '$baseURL/api/experience/updateByStudentId/${requestPostExperience.userId}',
        data: requestPostExperience.toJson(),
      );

      return ResponseAPI<List<ProjectResume>>(
        statusCode: res.statusCode,
        data: List<ProjectResume>.from(res.data['result'].map((x) => ProjectResume.fromMap((x))).toList()),
      );
    } on DioException catch (e) {
      logger.e(
        "DioException :${e.response}",
      );
      throw ResponseAPI<List<ProjectResume>>(
        statusCode: e.response?.statusCode,
        data: [],
      );
    } catch (e) {
      logger.e("Unexpected Error: $e");
      rethrow;
    }
  }

  Future<ResponseAPI<List<ProjectResume>>> getAllExperience(String userId) async {
    try {
      final res = await dioClient.get(
        '$baseURL/api/experience/getByStudentId/$userId',
      );

      return ResponseAPI<List<ProjectResume>>(
        statusCode: res.statusCode,
        data: List<ProjectResume>.from(res.data['result'].map((x) => ProjectResume.fromMap((x))).toList()),
      );
    } on DioException catch (e) {
      logger.e(
        "DioException :${e.response}",
      );
      throw ResponseAPI<List<ProjectResume>>(
        statusCode: e.response?.statusCode,
        data: [],
      );
    } catch (e) {
      logger.e("Unexpected Error: $e");
      rethrow;
    }
  }

  Future<ResponseAPI> uploadResume(RequestPostResume request) async {
    try {
      final res = await dioClient.put('$baseURL/api/profile/student/${request.studentId}/resume',
          data: FormData.fromMap(request.toMap()));

      logger.d(res);
      return ResponseAPI(
        statusCode: res.statusCode,
        data: res.data,
      );
    } catch (e) {
      logger.e("Unexpected Error: $e");
      rethrow;
    }
  }

  Future<ResponseAPI<String>> getResume(String studentId) async {
    try {
      final res = await dioClient.get('$baseURL/api/profile/student/$studentId/resume');

      return ResponseAPI<String>(
        statusCode: res.statusCode,
        data: res.data['result'],
      );
    } catch (e) {
      logger.e("Unexpected Error: $e");
      rethrow;
    }
  }

  Future<ResponseAPI<String>> getTranscript(String studentId) async {
    try {
      final res = await dioClient.get('$baseURL/api/profile/student/$studentId/transcript');

      return ResponseAPI<String>(
        statusCode: res.statusCode,
        data: res.data['result'],
      );
    } catch (e) {
      logger.e("Unexpected Error: $e");
      rethrow;
    }
  }

  Future<ResponseAPI<String>> changePassWord(RequestChangePassWord request) async {
    try {
      final res = await dioClient.put('$baseURL/api/user/changePassword', data: request.toJson());
      logger.d(res);
      return ResponseAPI<String>(
        statusCode: res.statusCode,
        data: res.data['result'],
      );
    } catch (e) {
      logger.e("Unexpected Error: $e");
      rethrow;
    }
  }

  Future<ResponseAPI<RequestProposal>> postProposal(RequestProposal request) async {
    try {
      final res = await dioClient.post('$baseURL/api/proposal', data: request.toJson());
      logger.d(res);
      return ResponseAPI<RequestProposal>(
        statusCode: res.statusCode,
        data: RequestProposal.fromMap(res.data['result']),
      );
    } catch (e) {
      logger.e("Unexpected Error: $e");
      rethrow;
    }
  }

  Future<ResponseAPI<Proposal>> getAllProprosal(String studentId) async {
    try {
      final res = await dioClient.post('$baseURL/api/proposal/student/$studentId');
      logger.d(res);
      // List of Request
      return ResponseAPI<Proposal>(
        statusCode: res.statusCode,
        data: List<Proposal>.from(res.data['result'].map((x) => Proposal.fromMap((x))).toList()).first,
      );
    } catch (e) {
      logger.e("Unexpected Error: $e");
      rethrow;
    }
  }

  Future<ResponseAPI<List<ProjectProposal>>> getAllProjectProposal(GetAllProjectProposal event,
      {int? statusFlag}) async {
    try {
      String url = '$baseURL/api/proposal/project/${event.userId}';
      if (event.statusFlag != null) {
        url = '$url?statusFlag=${event.statusFlag}';
      }
      final res = await dioClient.get(url);
      logger.d(res);
      // List of Request
      return ResponseAPI<List<ProjectProposal>>(
        statusCode: res.statusCode,
        data: List<ProjectProposal>.from(res.data['result'].map((x) => ProjectProposal.fromMap((x))).toList()),
      );
    } catch (e) {
      logger.e("Unexpected Error: $e");
      rethrow;
    }
  }

  Future<ResponseAPI> uploadTransciption(RequestPostResume request) async {
    try {
      final res = await dioClient.put('$baseURL/api/profile/student/${request.studentId}/transcript',
          data: FormData.fromMap(request.toMap()));

      logger.d(res);
      return ResponseAPI(
        statusCode: res.statusCode,
        data: res.data,
      );
    } catch (e) {
      logger.e("Unexpected Error: $e");
      rethrow;
    }
  }
}
