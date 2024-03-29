// ignore: file_names
import 'package:flutter/material.dart';
import 'package:studenthub/constants/app_theme.dart';

Future<void> showModalBottomSheetCustom(BuildContext context, {Widget? widgetBuilder, Widget? headerBuilder}) async =>
    showModalBottomSheet(
        isScrollControlled: true,
        isDismissible: true,
        context: context,
        backgroundColor: Colors.white.withOpacity(0.2),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
        ),
        builder: (context) => Padding(
              padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                padding: const EdgeInsets.all(20),
                width: double.infinity,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Center(
                      child: Container(
                        width: 80,
                        height: 5,
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.grey!.withOpacity(0.6),
                          borderRadius: BorderRadius.circular(50),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    headerBuilder ?? const SizedBox(),
                    widgetBuilder ?? const SizedBox(),
                  ],
                ),
              ),
            ));
