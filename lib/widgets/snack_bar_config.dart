import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:studenthub/app.dart';
import 'package:studenthub/constants/colors.dart';

enum StatusSnackBar {
  info,
  warning,
  error,
  success,
  none,
}

class SnackBarService {
  static void showSnackBar(
      {required String content, StatusSnackBar status = StatusSnackBar.none}) {
    StudentHub.scaffoldKey.currentState?.showSnackBar(
      SnackBar(
        duration: const Duration(milliseconds: 1000),
        content: Row(
          children: [
            SvgPicture.asset(getIcon(status)),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: Text(
                content,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        backgroundColor: getColorSnackBar(status),
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.only(bottom: 35, left: 20, right: 20),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
      ),
    );
  }
}

Color getColorSnackBar(StatusSnackBar type) {
  switch (type) {
    case StatusSnackBar.info:
      return priorityColor;
    case StatusSnackBar.warning:
      return statusColor;
    case StatusSnackBar.error:
      return cardinalColor;
    case StatusSnackBar.success:
      return fandangoColor;
    default:
      return raisinBlackColor;
  }
}

String getIcon(StatusSnackBar type) {
  switch (type) {
    case StatusSnackBar.info:
      return 'lib/assets/svgs/info_snackbar.svg';
    case StatusSnackBar.warning:
      return 'lib/assets/svgs/warning_snackbar.svg';
    case StatusSnackBar.error:
      return 'lib/assets/svgs/error_snackbar.svg';
    case StatusSnackBar.success:
      return 'lib/assets/svgs/success_snackbar.svg';
    default:
      return 'lib/assets/svgs/info_snackbar.svg';
  }
}
