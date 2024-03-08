import 'package:flutter/material.dart';

class ContinueButton extends StatefulWidget {
  const ContinueButton(
      {Key? key, required this.buttonActive, required this.press})
      : super(key: key);

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
      opacity: widget.buttonActive ? 1 : 0.3,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          minimumSize: const Size(double.infinity, 56),
        ),
        onPressed: widget.buttonActive ? widget.press : () {},
        child: Text(
          'Continue',
          style: textTheme.bodyMedium!
              .copyWith(color: Colors.white, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}
