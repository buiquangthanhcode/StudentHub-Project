import 'package:flutter/material.dart';
import 'package:studenthub/constants/app_theme.dart';
import 'package:studenthub/constants/colors.dart';

Future<void> showDialogCustom(BuildContext context,
    {String? image,
    String? title,
    String? subtitle,
    Function? onSave,
    String? textButtom,
    double? sizeImage}) async {
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
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.asset(
                        image ?? 'lib/assets/images/welcome_image_dialog.png',
                        fit: BoxFit.cover,
                        width: sizeImage,
                        height: sizeImage,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        title ?? 'Welcome to Student Hub',
                        style: textTheme.bodyLarge,
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        subtitle ??
                            'Start searching and implementing real-world projects right now!',
                        textAlign: TextAlign.center,
                        style: textTheme.bodySmall!
                            .copyWith(color: colorTheme.grey),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          minimumSize: const Size(double.infinity, 56),
                          backgroundColor: primaryColor,
                        ),
                        onPressed: () {
                          onSave!();
                        },
                        child: Text(
                          textButtom ?? 'Get Started!',
                          style: textTheme.bodyMedium!.copyWith(
                              color: Colors.white, fontWeight: FontWeight.w600),
                        ),
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
                          borderRadius: BorderRadius.circular(10),
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
