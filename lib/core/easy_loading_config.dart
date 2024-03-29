import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:lottie/lottie.dart';
import 'package:studenthub/constants/colors.dart';

void configEasyLoading() {
  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 2000)
    ..loadingStyle = EasyLoadingStyle.custom
    ..maskType = EasyLoadingMaskType.custom
    ..indicatorSize = 65.0
    ..radius = 15.0
    ..backgroundColor = primaryColor.withOpacity(0.9)
    ..indicatorColor = Colors.transparent
    ..textColor = Colors.white
    ..animationDuration = const Duration(microseconds: 2000)
    ..maskColor = primaryColor.withOpacity(0.0)
    ..userInteractions = true
    ..indicatorWidget = Lottie.asset('lib/assets/json/loading.json', height: 65)
    ..boxShadow = [];
}
