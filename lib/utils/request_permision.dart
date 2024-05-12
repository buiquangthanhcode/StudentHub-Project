import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:studenthub/utils/show_confirm_dialog.dart';

Future<void> checkPermission(BuildContext context) async {
  if (Platform.isIOS) {
    var permissionStatus = await Permission.storage.status;
    switch (permissionStatus) {
      case PermissionStatus.denied:
        // ignore: use_build_context_synchronously
        showDialogConfirm(context, title: 'Student Platform wants to access the directory.', confirmOnPress: () async {
          await openAppSettings();
          // ignore: use_build_context_synchronously
          Navigator.pop(context);
        });

      case PermissionStatus.permanentlyDenied:
        await Permission.storage.request();
        break;
      default:
    }
  } else {
    var permissionStatus = await Permission.manageExternalStorage.status;

    switch (permissionStatus) {
      case PermissionStatus.denied:
        await Permission.manageExternalStorage.request();
        break;
      case PermissionStatus.permanentlyDenied:
        await Permission.manageExternalStorage.request();
        break;
      default:
    }
  }
}
