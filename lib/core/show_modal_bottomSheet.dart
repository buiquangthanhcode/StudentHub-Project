// ignore: file_names
import 'package:flutter/material.dart';
import 'package:studenthub/constants/app_theme.dart';

Future<void> showModalBottomSheetCustom(BuildContext context, {Widget? widgetBuilder, Widget? headerBuilder}) async =>
    showModalBottomSheet(
        backgroundColor: Colors.white,
        context: context,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
        ),
        builder: (ctx) => Container(
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
                  Expanded(
                    child: widgetBuilder ?? const SizedBox(),
                  ),
                ],
              ),
            ));
