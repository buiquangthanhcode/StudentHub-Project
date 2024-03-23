import 'package:flutter/material.dart';
import 'package:studenthub/constants/app_theme.dart';
import 'package:studenthub/ui/home/dashboard/data/data_count.dart';

class MoreActionWidget extends StatefulWidget {
  const MoreActionWidget({super.key});

  @override
  State<MoreActionWidget> createState() => _MoreActionWidgetState();
}

class _MoreActionWidgetState extends State<MoreActionWidget> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final dataHeader = getMoreActionHeader(theme);

    return ListView.separated(
      separatorBuilder: (context, index) {
        return Container(
          margin: const EdgeInsets.symmetric(vertical: 10),
          height: 1,
          color: theme.colorScheme.grey!.withOpacity(0.1),
        );
      },
      shrinkWrap: true,
      itemCount: dataHeader.length,
      itemBuilder: ((context, index) {
        return Row(
          children: [
            dataHeader[index]['icon'],
            const SizedBox(width: 10),
            Text(
              dataHeader[index]['lable'],
              style: theme.textTheme.bodyMedium,
            ),
          ],
        );
      }),
    );
  }
}
