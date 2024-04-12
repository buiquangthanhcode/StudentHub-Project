import 'package:flutter/material.dart';
import 'package:studenthub/constants/app_theme.dart';
import 'package:studenthub/core/show_modal_bottomSheet.dart';
import 'package:studenthub/ui/home/messages/data/get_chat_data.dart';
import 'package:studenthub/ui/home/messages/widgets/schedule_widget.dart';
import 'package:studenthub/utils/logger.dart';

class MoreActionChatDetail extends StatelessWidget {
  const MoreActionChatDetail({
    super.key,
    this.callBack,
    this.isEdit,
  });

  final Function(dynamic value)? callBack;
  final bool? isEdit;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    var data = getDataMoreAction(theme);
    if (isEdit ?? false) {
      data = getDataMoreActionEdit(theme);
    } else {
      data = getDataMoreAction(theme);
    }
    return ListView.separated(
      separatorBuilder: (context, index) {
        return Container(
          margin: const EdgeInsets.only(top: 6),
          height: 1,
          color: theme.colorScheme.grey!.withOpacity(0.1),
        );
      },
      shrinkWrap: true,
      itemCount: data.length,
      itemBuilder: ((context, index) {
        return InkWell(
          onTap: () {
            if (data[index]['key'] == 'schedule') {
              Navigator.pop(context);
              showModalBottomSheetCustom(context, widgetBuilder: ScheduleWidget(
                onSave: (value) {
                  callBack!(value);
                },
              ));
            }
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Row(
              children: [
                data[index]['icon'],
                const SizedBox(width: 10),
                Text(
                  data[index]['label'],
                  style: theme.textTheme.bodyMedium,
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
