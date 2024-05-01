import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:studenthub/constants/key_translator.dart';

class SaveButton extends StatefulWidget {
  const SaveButton({super.key, required this.buttonActive, required this.press});

  final bool buttonActive;
  final VoidCallback press;

  @override
  _ContinueButtonState createState() => _ContinueButtonState();
}

class _ContinueButtonState extends State<SaveButton> {
  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    return Opacity(
      opacity: widget.buttonActive ? 1 : 0.3,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          minimumSize: const Size(double.infinity, 56),
        ),
        onPressed: widget.buttonActive ? widget.press : () {},
        child: Text(
          // 'Save Changes',
          saveChangesBtnKey.tr(),
          style: textTheme.bodyMedium!
              .copyWith(color: Colors.white, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}
