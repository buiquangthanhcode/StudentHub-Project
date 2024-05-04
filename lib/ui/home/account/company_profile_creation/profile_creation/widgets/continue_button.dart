import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:studenthub/constants/key_translator.dart';

class ContinueButton extends StatefulWidget {
  const ContinueButton(
      {super.key, required this.buttonActive, required this.press});

  final bool buttonActive;
  final VoidCallback press;

  @override
  _ContinueButtonState createState() => _ContinueButtonState();
}

class _ContinueButtonState extends State<ContinueButton> {
  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    return Opacity(
      // opacity: widget.buttonActive ? 1 : 0.3,
      opacity: 1,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          minimumSize: const Size(double.infinity, 56),
        ),
        onPressed: widget.buttonActive ? widget.press : () {},
        child: Text(
          // 'Save',
          saveBtnKey.tr(),
          style: textTheme.bodyMedium!
              .copyWith(color: Colors.white, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}
