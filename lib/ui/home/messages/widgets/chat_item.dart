import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:studenthub/constants/app_theme.dart';
import 'package:studenthub/constants/colors.dart';

class ChatItem extends StatelessWidget {
  const ChatItem({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    var colorTheme = Theme.of(context).colorScheme;
    return InkWell(
      onTap: () {
        context.goNamed('chat_detail');
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
            border: Border(
                top: BorderSide(width: 1, color: colorTheme.hintColor!))),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              width: 46,
              height: 46,
              child: CircleAvatar(
                backgroundImage:
                    AssetImage('lib/assets/images/circle_avatar.png'),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Luis Pham',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w600),
                      ),
                      Text(
                        '6/6/2024',
                        style: textTheme.bodySmall!.copyWith(
                            fontWeight: FontWeight.w500,
                            color: colorTheme.grey,
                            fontSize: 13),
                      ),
                    ],
                  ),
                  Text(
                    'Senior frontend developer (Fintech)',
                    style: textTheme.bodySmall!.copyWith(color: primaryColor),
                  ),
                  const SizedBox(
                    height: 6,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 20),
                    child: Text(
                      'Clear expectation about your project or delive rables',
                      overflow: TextOverflow.ellipsis,
                      style: textTheme.bodyMedium!
                          .copyWith(color: colorTheme.hintColor, fontSize: 15),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
