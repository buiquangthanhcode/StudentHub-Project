import 'package:flutter/material.dart';

class MyElevatedButton extends StatelessWidget {
  final Color? backgroundColor;
  final BorderRadiusGeometry? borderRadius;
  final Border? buttonBorder;
  final double width;
  final double height;
  final Gradient? gradient;
  final VoidCallback? onPressed;
  final Widget child;

  const MyElevatedButton({
    Key? key,
    required this.onPressed,
    required this.child,
    this.borderRadius,
    this.buttonBorder,
    required this.width,
    required this.height,
    this.gradient,
    this.backgroundColor = Colors.transparent,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final borderRadius = this.borderRadius ?? BorderRadius.circular(0);
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
          gradient: gradient, borderRadius: borderRadius, border: buttonBorder),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white,
          backgroundColor: backgroundColor,
          shadowColor: backgroundColor,
          shape: RoundedRectangleBorder(borderRadius: borderRadius),
        ),
        child: child,
      ),
    );
  }
}
