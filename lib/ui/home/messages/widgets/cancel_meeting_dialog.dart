import 'package:flutter/material.dart';

import 'package:easy_localization/easy_localization.dart';
import 'package:studenthub/constants/app_theme.dart';
import 'package:studenthub/constants/colors.dart';
import 'package:studenthub/constants/key_translator.dart';

Future<void> showCancelDialog(
    BuildContext context, Function(bool) callback) async {
  TextTheme textTheme = Theme.of(context).textTheme;
  var colorTheme = Theme.of(context).colorScheme;
  showDialog(
      context: context,
      builder: (context) => AlertDialog(
            titlePadding: EdgeInsets.zero,
            backgroundColor: Colors.white,
            contentPadding: EdgeInsets.zero,
            content: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 20,
              ),
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(15))),
              child: Stack(
                clipBehavior: Clip.antiAlias,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const SizedBox(
                        height: 28,
                      ),
                      Text(
                        // title ?? 'Welcome to Student Hub',
                        "Do you want to cancel the meeting?",
                        style: textTheme.bodyLarge,
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      Text(
                        'After cancellation, participants won\'t be able to join as scheduled.',
                        textAlign: TextAlign.center,
                        style: textTheme.bodySmall!
                            .copyWith(color: colorTheme.grey),
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: OutlinedButton(
                              style: OutlinedButton.styleFrom(
                                  side: const BorderSide(
                                      color: primaryColor, width: 2),
                                  minimumSize: const Size(double.infinity, 42),
                                  backgroundColor: Colors.transparent),
                              onPressed: () {
                                Navigator.pop(context);
                                callback(false);
                              },
                              child: Text(
                                'No',
                                style: textTheme.bodyMedium!.copyWith(
                                    color: primaryColor,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                minimumSize: const Size(double.infinity, 42),
                              ),
                              onPressed: () {
                                Navigator.pop(context);
                                callback(true);
                              },
                              child: Text(
                                'Yes',
                                style: textTheme.bodyMedium!.copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Positioned(
                    right: -5,
                    top: -5,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: Container(
                        margin: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color: Theme.of(context)
                              .colorScheme
                              .grey
                              ?.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: InkWell(
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                          child: const Icon(
                            Icons.close,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ));
}
