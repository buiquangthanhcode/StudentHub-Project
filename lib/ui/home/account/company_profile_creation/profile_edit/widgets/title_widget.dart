import 'package:flutter/material.dart';

class TitleWidget extends StatefulWidget {
  const TitleWidget({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _TitleWidgetState createState() => _TitleWidgetState();
}

class _TitleWidgetState extends State<TitleWidget> {
  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Edit profile',
          style: textTheme.titleLarge,
        ),
      ],
    );
  }
}
