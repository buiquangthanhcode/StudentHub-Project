import 'dart:io';
import 'package:flutter/material.dart';
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
    );
  }
}
