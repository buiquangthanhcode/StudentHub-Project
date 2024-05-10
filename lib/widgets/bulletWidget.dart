import 'package:flutter/material.dart';
import 'package:studenthub/constants/app_theme.dart';

class BulletList extends StatelessWidget {
  final List<String> strings;

  const BulletList(this.strings, {super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.fromLTRB(4, 8, 0, 4),
      // padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: strings.map((str) {
          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                '\u2022',
                style: TextStyle(
                  fontSize: 16,
                  height: 1.55,
                ),
              ),
              const SizedBox(
                width: 5,
              ),
              Expanded(
                child: Text(
                  str,
                  textAlign: TextAlign.left,
                  softWrap: true,
                  style: TextStyle(
                    fontSize: 14,
                    color: theme.colorScheme.brightness == Brightness.dark
                        ? Colors.white
                        : Colors.black.withOpacity(0.5),
                    height: 1.55,
                  ),
                ),
              ),
            ],
          );
        }).toList(),
      ),
    );
  }
}
