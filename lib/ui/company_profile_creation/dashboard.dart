import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:studenthub/constants/app_theme.dart';
import 'package:studenthub/constants/colors.dart';
import 'package:studenthub/data/bottom_navigation.dart';
import 'package:studenthub/widgets/emtyDataWidget.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  dynamic navSelected = bottomNavs.first;
  double paddingDevice = Platform.isIOS ? 20 : 10;
  dynamic data = [1, 2];
  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    var colorTheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        title: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Your Jobs',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
              ),
            ],
          ),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 15, 20, 0),
          child: Column(
            children: [
              if (data.isNotEmpty)
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      onPressed: () {},
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Post a job',
                            style: textTheme.bodyMedium!.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              const SizedBox(
                height: 60,
              ),
              if (data.isEmpty)
                Column(
                  children: [
                    const EmptyDataWidget(
                      mainTitle: 'You have no job!',
                      subTitle: 'Do you want to create a new job?',
                    ),
                    const SizedBox(
                      height: 35,
                    ),
                    ElevatedButton(
                      onPressed: () {},
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Post a job',
                            style: textTheme.bodyMedium!.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
            ],
          ),
        ),
      ),
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
                  navSelected = bottomNavs[index];
                  setState(() {});
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
