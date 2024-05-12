import 'dart:math';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:studenthub/models/common/project_proposal_modal.dart';
import 'package:studenthub/models/common/proposal_modal.dart';
import 'package:studenthub/models/student/student_create_profile/skillset_model.dart';
import 'package:studenthub/models/student/student_create_profile/tech_stack.dart';
import 'package:studenthub/utils/logger.dart';
import 'package:studenthub/utils/show_confirm_dialog.dart';

DateTime stringToDateTime(String? dateString) {
  try {
    return DateFormat('dd/MM/yyyy').parse(dateString ?? '1970-01-01');
  } catch (error) {
    return DateTime.parse('1970-01-01');
  }
}

String formatDateTime(DateTime dateTime, {String? format}) {
  try {
    return DateFormat(format ?? 'dd/MM/yyyy').format(dateTime);
  } catch (error) {
    return 'Invalid';
  }
}

DateTime parseYearToDateTime(String yearString) {
  try {
    int year = int.parse(yearString);
    return DateTime(year, 1, 1); // Default month and day are set to January 1st
  } catch (error) {
    return DateTime.parse('1970-01-01');
  }
}

int calculateMonthDifference(DateTime start, DateTime end) {
  int monthsApart = (end.year - start.year) * 12 + end.month - start.month;

  if (end.day < start.day) {
    monthsApart--;
  }

  return monthsApart;
}

String formatTimeFromDateTime(DateTime dateTime) {
  DateFormat timeFormat = DateFormat.Hm();
  String formattedTime = timeFormat.format(dateTime);

  return formattedTime;
}

String handleFormatMessage(dynamic message) {
  if (message is String) {
    return message;
  } else if (message is List) {
    return message.join('\n');
  } else {
    return 'Invalid message type';
  }
}

String formatIsoDateString(String isoDateString) {
  try {
    DateTime dateTime = DateTime.parse(isoDateString);
    DateFormat formatter = DateFormat('dd-MM-yyyy');
    return formatter.format(dateTime);
  } catch (e) {
    DateFormat formatter = DateFormat('dd-MM-yyyy');
    return formatter.format(DateTime.parse('1970-01-01'));
  }
}

SkillSet getSkillSetByName(String value, List<SkillSet> data) {
  SkillSet? skill = data.firstWhere((element) => element.name == value, orElse: () => SkillSet(id: -1, name: ''));
  return skill;
}

DateTime parseMonthYear(String? monthYearString) {
  try {
    DateFormat formatter = DateFormat('MM-yyyy');
    return formatter.parseStrict(monthYearString ?? '1970-01-01');
  } catch (e) {
    logger.e('Error parsing date: $e');
    return DateTime.parse('1970-01-01');
  }
}

void sortProjectsByCreatedAt(List<ProjectProposal> projects) {
  projects.sort((a, b) {
    if (a.createdAt != null && b.createdAt != null) return b.createdAt!.compareTo(a.createdAt!);
    return 1;
  });
}

bool checkIsSubmitProposal(List<Proposal> data, int studentId) {
  return data.any((element) => element.studentId == studentId);
}

List<TechStack> removeDuplicates(List<TechStack> list) {
  List<TechStack> uniqueList = [];

  Set<String> namesSet = <String>{};

  for (var teckstack in list) {
    if (!namesSet.contains(teckstack.name ?? '')) {
      namesSet.add(teckstack.name ?? '');
      uniqueList.add(teckstack);
    }
  }

  return uniqueList;
}

String checkDateTime(String dateTimeString) {
  if (dateTimeString.isEmpty) return '';
  DateTime now = DateTime.now();
  logger.d(dateTimeString);

  DateTime dateTime = DateTime.parse(dateTimeString);

  if (dateTime.year == now.year && dateTime.month == now.month && dateTime.day == now.day) {
    dateTime = dateTime.toLocal();
    return DateFormat('HH:mm').format(dateTime);
  } else {
    return DateFormat('dd-MM-yyyy').format(dateTime);
  }
}

String getCurrentTime() {
  DateTime now = DateTime.now();
  return DateFormat('HH:mm').format(now);
}

String getCurrentTimeAsString() {
  DateTime now = DateTime.now();

  String hour = now.hour.toString().padLeft(2, '0');
  String minute = now.minute.toString().padLeft(2, '0');
  String second = now.second.toString().padLeft(2, '0');

  String timeString = '$hour$minute$second';
  return timeString;
}

String convertDateTimeFormat(String isoDateTime) {
  if (isoDateTime.isEmpty) return '';
  DateTime dateTime = DateTime.parse(isoDateTime);

  String formattedDateTime =
      ' ${_twoDigits(dateTime.hour)}:${_twoDigits(dateTime.minute)} ${dateTime.year}-${_twoDigits(dateTime.month)}-${_twoDigits(dateTime.day)}';

  return formattedDateTime;
}

String _twoDigits(int n) {
  if (n >= 10) {
    return "$n";
  }
  return "0$n";
}

String convertToIso8601(String date, String time) {
  List<String> dateParts = date.split('/');
  List<String> timeParts = time.split(':');

  DateTime dateTime = DateTime(
    int.parse(dateParts[2]), // Năm
    int.parse(dateParts[1]), // Tháng
    int.parse(dateParts[0]), // Ngày
    int.parse(timeParts[0]), // Giờ
    int.parse(timeParts[1]), // Phút
  );

  String iso8601String = dateTime.toUtc().toIso8601String();
  return iso8601String;
}

int generateRandomInt32() {
  Random random = Random();
  int min = -2147483648; // Giá trị nhỏ nhất của số nguyên 32-bit
  int max = 2147483647; // Giá trị lớn nhất của số nguyên 32-bit

  int randomNumber = min + random.nextInt(max - min + 1);
  return randomNumber;
}

extension GoRouterExtension on GoRouter {
  String location() {
    final RouteMatch lastMatch = routerDelegate.currentConfiguration.last;
    final RouteMatchList matchList =
        lastMatch is ImperativeRouteMatch ? lastMatch.matches : routerDelegate.currentConfiguration;
    final String location = matchList.uri.toString();
    return location;
  }
}

String getLastSubstringAfterDot(String filename) {
  List<String> parts = filename.split('.');
  if (parts.length > 1) {
    return parts.last;
  }
  return '';
}

Future<void> requestNotificationPermission(BuildContext context) async {
  var permissionStatus = await Permission.notification.status;

  switch (permissionStatus) {
    case PermissionStatus.denied:
      await Permission.notification.request();
      break;
    case PermissionStatus.permanentlyDenied:
      // ignore: use_build_context_synchronously
      showDialogConfirm(context, title: 'Student Platform wants to grant notification permission',
          confirmOnPress: () async {
        await openAppSettings();
        // ignore: use_build_context_synchronously
        Navigator.pop(context);
      });
      break;
    default:
  }
}
