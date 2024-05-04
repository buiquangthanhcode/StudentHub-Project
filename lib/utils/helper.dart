import 'package:easy_localization/easy_localization.dart';
import 'package:studenthub/models/common/project_proposal_modal.dart';
import 'package:studenthub/models/common/proposal_modal.dart';
import 'package:studenthub/models/notification/notification_model.dart';
import 'package:studenthub/models/student/student_create_profile/skillset_model.dart';
import 'package:studenthub/models/student/student_create_profile/tech_stack.dart';
import 'package:studenthub/utils/logger.dart';

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

  DateTime dateTime = DateTime.parse(dateTimeString);

  if (dateTime.year == now.year && dateTime.month == now.month && dateTime.day == now.day) {
    dateTime = dateTime.toLocal();
    return DateFormat('HH:mm').format(dateTime);
  } else {
    return DateFormat('dd-MM-yyyy').format(dateTime);
  }
}
