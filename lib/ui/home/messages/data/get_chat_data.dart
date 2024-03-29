import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:studenthub/constants/app_theme.dart';

List<Map<String, String>> getChatList() {
  return [
    {
      'fullname': 'Bui Quang Thanh',
      'createdtime': '6/6/2024',
      'major': 'Senior frontend developer (Fintech)',
      'message': 'Clear expectation about your project or delive rables',
    },
    {
      'fullname': 'Nguyen Thoai Dang Khoa',
      'createdtime': '6/6/2024',
      'major': 'Senior frontend developer (Fintech)',
      'message': 'Clear expectation about your project or delive rables',
    },
    {
      'fullname': 'Dinh Nguyen Duy Khang',
      'createdtime': '6/6/2024',
      'major': 'Senior frontend developer (Fintech)',
      'message': 'Clear expectation about your project or delive rables',
    },
    {
      'fullname': 'Nguyen Duc Minh',
      'createdtime': '6/6/2024',
      'major': 'Senior frontend developer (Fintech)',
      'message': 'Clear expectation about your project or delive rables',
    },
    {
      'fullname': 'Tran Dam Gia Huy',
      'createdtime': '6/6/2024',
      'major': 'Senior frontend developer (Fintech)',
      'message': 'Clear expectation about your project or delive rables',
    },
    {
      'fullname': 'Bui Quang Thanh',
      'createdtime': '6/6/2024',
      'major': 'Senior frontend developer (Fintech)',
      'message': 'Clear expectation about your project or delive rables',
    },
    {
      'fullname': 'Nguyen Thoai Dang Khoa',
      'createdtime': '6/6/2024',
      'major': 'Senior frontend developer (Fintech)',
      'message': 'Clear expectation about your project or delive rables',
    },
    {
      'fullname': 'Dinh Nguyen Duy Khang',
      'createdtime': '6/6/2024',
      'major': 'Senior frontend developer (Fintech)',
      'message': 'Clear expectation about your project or delive rables',
    },
    {
      'fullname': 'Nguyen Duc Minh',
      'createdtime': '6/6/2024',
      'major': 'Senior frontend developer (Fintech)',
      'message': 'Clear expectation about your project or delive rables',
    },
    {
      'fullname': 'Tran Dam Gia Huy',
      'createdtime': '6/6/2024',
      'major': 'Senior frontend developer (Fintech)',
      'message': 'Clear expectation about your project or delive rables',
    },
  ];
}

List<Map<String, dynamic>> getDataMoreAction(ThemeData theme) {
  return [
    {
      "label": "Schedule a Interview",
      "icon": FaIcon(
        FontAwesomeIcons.calendar,
        size: 18,
        color: theme.colorScheme.grey!,
      ),
      'key': 'schedule',
    },
    {
      "label": "Cancel",
      "icon": FaIcon(
        FontAwesomeIcons.ban,
        size: 18,
        color: theme.colorScheme.grey!,
      ),
      'key': 'cancel',
    }
  ];
}

List<Map<String, dynamic>> getDataMoreActionEdit(ThemeData theme) {
  return [
    {
      "label": "Re-Schedule a Interview",
      "icon": FaIcon(
        FontAwesomeIcons.calendar,
        size: 18,
        color: theme.colorScheme.grey!,
      ),
      'key': 're-schedule',
    },
    {
      "label": "Cancel the meeting",
      "icon": FaIcon(
        FontAwesomeIcons.ban,
        size: 18,
        color: theme.colorScheme.grey!,
      ),
      'key': 'cancel-meeting',
    }
  ];
}
