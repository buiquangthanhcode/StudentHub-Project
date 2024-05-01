import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:studenthub/constants/app_theme.dart';
import 'package:studenthub/constants/key_translator.dart';

class TitleWidget extends StatefulWidget {
  const TitleWidget({super.key});

  @override
  _TitleWidgetState createState() => _TitleWidgetState();
}

class _TitleWidgetState extends State<TitleWidget> {
  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    var colorTheme = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          // 'Welcome to Student Hub!',
          welcomeDialogMsg.tr(),
          style: textTheme.titleLarge,
        ),
        const SizedBox(
          height: 8,
        ),
        Text(
          editProfileDescriptionKey.tr(),
          style: textTheme.bodySmall!.copyWith(color: colorTheme.grey),
        ),
      ],
    );
  }
}
