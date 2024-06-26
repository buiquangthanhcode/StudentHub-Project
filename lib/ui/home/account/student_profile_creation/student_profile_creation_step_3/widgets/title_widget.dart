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
        const SizedBox(
          height: 10,
        ),
        Text(
          // 'Tell us about your company and you will be on your way to connect with the real-world project',
          editProfileDescriptionKey.tr(),
          style: textTheme.bodySmall!.copyWith(color: colorTheme.grey),
        ),
      ],
    );
  }
}
