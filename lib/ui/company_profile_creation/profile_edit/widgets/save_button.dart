import 'package:flutter/material.dart';

class SaveButton extends StatefulWidget {
  const SaveButton({Key? key, required this.buttonActive, required this.press})
      : super(key: key);

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
          'Save Changes',
          style: textTheme.bodyMedium!
              .copyWith(color: Colors.white, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}
