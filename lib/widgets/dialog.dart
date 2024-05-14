import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:studenthub/constants/app_theme.dart';
import 'package:studenthub/constants/colors.dart';
import 'package:studenthub/constants/key_translator.dart';

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
            backgroundColor: Theme.of(context).brightness == Brightness.dark
                ? Colors.black
                : Colors.white,
            contentPadding: EdgeInsets.zero,
            content: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 20,
              ),
              decoration: BoxDecoration(
                  // color: Colors.white,
                  color: Theme.of(context).brightness == Brightness.dark
                      ? Colors.black
                      : Colors.white,
                  border: Border.all(
                    color: Theme.of(context).brightness == Brightness.dark
                        ? Colors.white
                        : Colors.transparent,
                  ),
                  borderRadius: const BorderRadius.all(Radius.circular(15))),
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
                        height: 24,
                      ),
                      Text(
                        // title ?? 'Welcome to Student Hub',
                        title ?? welcomeDialogMsg.tr(),
                        style: textTheme.bodyLarge,
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      Text(
                        subtitle ?? 'Some subtitle....',
                        textAlign: TextAlign.center,
                        style: textTheme.bodySmall!
                            .copyWith(color: colorTheme.grey),
                      ),
                      const SizedBox(
                        height: 24,
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
                          // textButtom ?? 'Get Started!',
                          textButtom ?? getStartedBtnKey.tr(),
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
