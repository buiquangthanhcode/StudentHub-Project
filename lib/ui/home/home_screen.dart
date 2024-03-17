import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:studenthub/constants/colors.dart';
import 'package:studenthub/data/bottom_navigation.dart';
import 'package:studenthub/ui/home/account/account.dart';
import 'package:studenthub/ui/home/alerts/alerts.dart';
import 'package:studenthub/ui/home/dashboard/dashboard.dart';
import 'package:studenthub/ui/home/messages/messages.dart';
import 'package:studenthub/ui/home/projects/project_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

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
    body = const Dashboard();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: body,
      bottomNavigationBar: Container(
        padding: EdgeInsets.fromLTRB(5, 0, 5, paddingDevice),
        decoration: BoxDecoration(color: Colors.white, boxShadow: [
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
                        body = const Dashboard();
                        break;
                      case 1:
                        body = const ProjectScreen();
                        break;
                      case 2:
                        body = const Messages();
                        break;
                      case 3:
                        body = const Alerts();
                        break;
                      case 4:
                        body = const Account();
                        break;
                      default:
                        print('Bottom navigation error!');
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
                              colorFilter: const ColorFilter.mode(
                                  primaryColor, BlendMode.srcIn),
                              height: 24,
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              bottomNavs[index]['title'] as String,
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
                              colorFilter: const ColorFilter.mode(
                                  Color(0xffA0A0A0), BlendMode.srcIn),
                              height: 23,
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              bottomNavs[index]['title'] as String,
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
