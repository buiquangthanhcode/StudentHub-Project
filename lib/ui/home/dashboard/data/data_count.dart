import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:studenthub/constants/app_theme.dart';

final data = [
  {"lable": "Proposals", "total": "2"},
  {"lable": "Messages", "total": "5"},
  {"lable": "Hired", "total": "4"},
];

List<Map<String, dynamic>> getMoreActionHeader(ThemeData theme) {
  return [
    {
      "lable": "View Proposal",
      "icon": FaIcon(
        FontAwesomeIcons.eye,
        size: 18,
        color: theme.colorScheme.grey!,
      )
    },
    {
      "lable": "View Message",
      "icon": FaIcon(
        FontAwesomeIcons.message,
        size: 18,
        color: theme.colorScheme.grey!,
      )
    },
    {
      "lable": "View Hired",
      "icon": FaIcon(
        FontAwesomeIcons.user,
        size: 18,
        color: theme.colorScheme.grey!,
      )
    },
    {
      "lable": "View Job posting",
      "icon": FaIcon(
        FontAwesomeIcons.eye,
        size: 18,
        color: theme.colorScheme.grey!,
      )
    },
    {
      "lable": "Edit Posting",
      "icon": FaIcon(
        FontAwesomeIcons.penToSquare,
        size: 18,
        color: theme.colorScheme.grey!,
      )
    },
    {
      "lable": "Remove Posting",
      "icon": FaIcon(
        FontAwesomeIcons.trashCan,
        size: 18,
        color: theme.colorScheme.grey!,
      )
    },
  ];
}
