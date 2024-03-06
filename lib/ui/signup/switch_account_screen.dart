import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:studenthub/constants/app_theme.dart';
import 'package:studenthub/constants/colors.dart';
import 'package:studenthub/constants/strings.dart';

import '../../core/text_field_custom.dart';

class SwitchAccount extends StatelessWidget {
  const SwitchAccount({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    List<Map<String, dynamic>> dataSetting = [
      {
        'icon': 'icon01',
        'name': 'Profiles',
      },
      {
        'icon': 'icon02',
        'name': 'Setting',
      },
      {
        'icon': 'icon03',
        'name': 'Log out',
      },
    ];

    final maxHeight = MediaQuery.of(context).size.height;
    final maxWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: AppBar(
          backgroundColor: backgroundHeaderAppBar,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                NAME_APP,
                style: theme.textTheme.titleMedium,
              ),
              const Icon(Icons.person),
            ],
          ),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Theme(
            data: theme.copyWith(dividerColor: Colors.transparent),
            child: ExpansionTile(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: FaIcon(
                      FontAwesomeIcons.user,
                      size: 20,
                      color: theme.colorScheme.smallBoxColor1,
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Bui Quang Thanh',
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Company',
                        style: theme.textTheme.titleSmall?.copyWith(
                          color: Colors.grey,
                        ),
                      ),
                      Container(
                        color: Colors.black,
                        height: 2,
                        width: 100,
                      ),
                    ],
                  ),
                ],
              ),
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Spacer(),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: FaIcon(
                        FontAwesomeIcons.user,
                        size: 20,
                        color: theme.colorScheme.smallBoxColor1,
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Bui Quang Thanh',
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'Student',
                          style: theme.textTheme.titleSmall?.copyWith(
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                    const Spacer(
                      flex: 4,
                    ),
                  ],
                ),
              ],
            ),
          ),
          Divider(
            color: theme.colorScheme.smallBoxColor1,
            thickness: 1,
          ),
          ListView.separated(
            shrinkWrap: true,
            itemBuilder: (context, intdex) {
              return Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Row(
                  children: [
                    FaIcon(
                      FontAwesomeIcons.arrowUp,
                      size: 20,
                      color: theme.colorScheme.smallBoxColor1,
                    ),
                    Text(
                      dataSetting[intdex]['name'],
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              );
            },
            separatorBuilder: ((context, index) {
              return const SizedBox(
                height: 10,
              );
            }),
            itemCount: dataSetting.length,
          ),
        ],
      ),
    );
  }
}
