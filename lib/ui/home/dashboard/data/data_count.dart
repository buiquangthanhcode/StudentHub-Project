import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:studenthub/constants/app_theme.dart';
import 'package:studenthub/constants/key_translator.dart';

final data = [
  {"label": "Proposals", "total": "2"},
  {"label": "Messages", "total": "5"},
  {"label": "Hired", "total": "4"},
];

List<Map<String, dynamic>> getMoreActionHeader(ThemeData theme) {
  return [
    {
      "key": "view_proposals",
      "label": "View Proposals",
      "icon": FaIcon(
        FontAwesomeIcons.eye,
        size: 18,
        color: theme.colorScheme.grey!,
      ),
    },
    {
      "key": "view_messages",
      "label": "View Messages",
      "icon": FaIcon(
        FontAwesomeIcons.message,
        size: 18,
        color: theme.colorScheme.grey!,
      )
    },
    {
      "key": "view_hired",
      "label": "View Hired",
      "icon": FaIcon(
        FontAwesomeIcons.user,
        size: 18,
        color: theme.colorScheme.grey!,
      )
    },
    {
      "key": "view_job_posting",
      "label": "View Job Posting",
      "icon": FaIcon(
        FontAwesomeIcons.eye,
        size: 18,
        color: theme.colorScheme.grey!,
      )
    },
    {
      "key": "edit_posting",
      "label": "Edit Posting",
      "icon": FaIcon(
        FontAwesomeIcons.penToSquare,
        size: 18,
        color: theme.colorScheme.grey!,
      )
    },
    {
      "key": "remove_posting",
      "label": "Remove Posting",
      "icon": FaIcon(
        FontAwesomeIcons.trashCan,
        size: 18,
        color: theme.colorScheme.grey!,
      )
    },
    {
      "key": "close_posting",
      "label": "Close Posting",
      "icon": FaIcon(
        FontAwesomeIcons.circleXmark,
        size: 18,
        color: theme.colorScheme.grey!,
      )
    },
    {
      "key": "start_working",
      "label": "Start Working On This Project",
      "icon": FaIcon(
        FontAwesomeIcons.circleCheck,
        size: 18,
        color: theme.colorScheme.grey!,
      )
    },
  ];
}

List<Map<String, dynamic>> getMoreActionHeaderForStudent(ThemeData theme) {
  return [
    {
      "key": "view_messages",
      "label": "View Messages",
      "icon": FaIcon(
        FontAwesomeIcons.message,
        size: 18,
        color: theme.colorScheme.grey!,
      )
    },
    {
      "key": "view_job_posting",
      "label": "View Job Posting",
      "icon": FaIcon(
        FontAwesomeIcons.eye,
        size: 18,
        color: theme.colorScheme.grey!,
      )
    },
  ];
}

List<Map<String, dynamic>> getProposal() {
  return [
    {
      "avatar":
          "https://cdn5.vectorstock.com/i/1000x1000/38/44/student-graduate-avatar-icon-vector-11983844.jpg",
      "fullname": "Bui Quang Thanh",
      // "year": "4th year student",
      "year": fourthYearStudentKey.tr(),
      "major": "Fullstack Engineering",
      "rating": "Excellent",
      "description":
          "I have gone through your project and it seen like a great project. I will commit for four project"
    },
    {
      "avatar":
          "https://cdn5.vectorstock.com/i/1000x1000/38/44/student-graduate-avatar-icon-vector-11983844.jpg",
      "fullname": "Dinh Nguyen Duy Khang",
      // "year": "4th year student",
      "year": fourthYearStudentKey.tr(),
      "major": "Mobile Engineering",
      "rating": "Very Good",
      "description":
          "I have gone through your project and it seen like a great project. I will commit for four project"
    },
    {
      "avatar":
          "https://cdn5.vectorstock.com/i/1000x1000/38/44/student-graduate-avatar-icon-vector-11983844.jpg",
      "fullname": "Nguyen Thoai Dang Khoa",
      // "year": "4th year student",
      "year": fourthYearStudentKey.tr(),
      "major": "Blockchain Engineering",
      "rating": "Good",
      "description":
          "I have gone through your project and it seen like a great project. I will commit for four project"
    },
  ];
}
