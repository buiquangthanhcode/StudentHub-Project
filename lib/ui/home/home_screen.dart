import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:studenthub/blocs/notification_bloc/notification_bloc.dart';
import 'package:studenthub/blocs/notification_bloc/notification_event.dart';
import 'package:studenthub/constants/bottom_navigation.dart';
import 'package:studenthub/constants/colors.dart';
import 'package:studenthub/ui/home/account/account_screen.dart';
import 'package:studenthub/ui/home/alerts/alerts_screen.dart';
import 'package:studenthub/ui/home/dashboard/dashboard_screen.dart';
import 'package:studenthub/ui/home/messages/messages_screen.dart';
import 'package:studenthub/ui/home/projects/general_project_screen.dart';
import 'package:studenthub/utils/helper.dart';
import 'package:studenthub/utils/logger.dart';
import 'package:studenthub/utils/socket.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.welcome});

  final String welcome;

  @override
  // ignore: library_private_types_in_public_api
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  dynamic navSelected = bottomNavs.first;
  double paddingDevice = Platform.isIOS ? 20 : 10;
  Widget? body;

  @override
  void initState() {
    super.initState();
    requestNotificationPermission(context);
    body = DashboardScreen(welcome: widget.welcome);
    SocketService.initSocketForNotification(context);
    context.read<NotificationBloc>().add(StartListenerEvents(
        context: context,
        onListener: (data) {
          // call back when you want to trigger notification
          logger.d("Đã có thông báo $data");
        }));
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: body,
      bottomNavigationBar: Container(
        padding: EdgeInsets.fromLTRB(5, 0, 5, paddingDevice),
        decoration: BoxDecoration(color: theme.colorScheme.background, boxShadow: [
          BoxShadow(
            color: const Color.fromARGB(255, 216, 216, 216).withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ]),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            ...List.generate(
              bottomNavs.length,
              (index) => InkWell(
                onTap: () {
                  if (navSelected != bottomNavs[index]) {
                    navSelected = bottomNavs[index];
                    switch (index) {
                      case 0:
                        body = const DashboardScreen(
                          welcome: 'false',
                        );
                        break;
                      case 1:
                        body = const GeneralProjectScreen();
                        break;
                      case 2:
                        body = const MessagesScreen();
                        break;
                      case 3:
                        body = const AlertsScreen();
                        break;
                      case 4:
                        body = const AccountScreen();
                        break;
                      default:
                    }
                    setState(() {});
                  }
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  width: (MediaQuery.of(context).size.width - 10) / 5,
                  child: navSelected == bottomNavs[index]
                      ? Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SvgPicture.asset(
                              bottomNavs[index]['solid-icon'] as String,
                              colorFilter: const ColorFilter.mode(primaryColor, BlendMode.srcIn),
                              height: 24,
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              tr(bottomNavs[index]['title'] ?? ''),
                              style: const TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                          ],
                        )
                      : Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SvgPicture.asset(
                              bottomNavs[index]['regular-icon'] as String,
                              colorFilter: const ColorFilter.mode(Color(0xffA0A0A0), BlendMode.srcIn),
                              height: 23,
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              tr(bottomNavs[index]['title'] as String),
                              style: const TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                                color: Color(0xffA0A0A0),
                              ),
                            ),
                          ],
                        ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
