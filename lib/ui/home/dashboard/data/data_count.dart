import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:studenthub/constants/app_theme.dart';

final data = [
  {"label": "Proposals", "total": "2"},
  {"label": "Messages", "total": "5"},
  {"label": "Hired", "total": "4"},
];

List<Map<String, dynamic>> getMoreActionHeader(ThemeData theme) {
  return [
    {
      "label": "View Proposal",
      "icon": FaIcon(
        FontAwesomeIcons.eye,
        size: 18,
        color: theme.colorScheme.grey!,
      )
    },
    {
      "label": "View Message",
      "icon": FaIcon(
        FontAwesomeIcons.message,
        size: 18,
        color: theme.colorScheme.grey!,
      )
    },
    {
      "label": "View Hired",
      "icon": FaIcon(
        FontAwesomeIcons.user,
        size: 18,
        color: theme.colorScheme.grey!,
      )
    },
    {
      "label": "View Job posting",
      "icon": FaIcon(
        FontAwesomeIcons.eye,
        size: 18,
        color: theme.colorScheme.grey!,
      )
    },
    {
      "label": "Edit Posting",
      "icon": FaIcon(
        FontAwesomeIcons.penToSquare,
        size: 18,
        color: theme.colorScheme.grey!,
      )
    },
    {
      "label": "Remove Posting",
      "icon": FaIcon(
        FontAwesomeIcons.trashCan,
        size: 18,
        color: theme.colorScheme.grey!,
      )
    },
  ];
}

List<Map<String, dynamic>> getProposal() {
  return [
    {
      "avatar": "https://cdn5.vectorstock.com/i/1000x1000/38/44/student-graduate-avatar-icon-vector-11983844.jpg",
      "fullname": "Bui Quang Thanh",
      "year": "4th year student",
      "major": "FullStack Engineering",
      "rating": "Excellent",
      "description": "I have gone through your project and it seen like a great project. I will commit for four project"
    },
    {
      "avatar": "https://cdn5.vectorstock.com/i/1000x1000/38/44/student-graduate-avatar-icon-vector-11983844.jpg",
      "fullname": "Dinh Nguyen Duy Khang",
      "year": "4th year student",
      "major": "Mobile Engineering",
      "rating": "Excellent",
      "description": "I have gone through your project and it seen like a great project. I will commit for four project"
    },
    {
      "avatar": "https://cdn5.vectorstock.com/i/1000x1000/38/44/student-graduate-avatar-icon-vector-11983844.jpg",
      "fullname": "Nguyen Thoai Dang Khoa",
      "year": "4th year student",
      "major": "Blockchain Engineering",
      "rating": "Excellent",
      "description": "I have gone through your project and it seen like a great project. I will commit for four project"
    },
  ];
}
