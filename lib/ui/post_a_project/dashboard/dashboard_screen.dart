import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:studenthub/constants/colors.dart';
import 'package:studenthub/constants/strings.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(50),
          child: AppBar(
            backgroundColor: backgroundHeaderAppBar,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  NAME_APP,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const Icon(Icons.person),
              ],
            ),
          ),
        ),
        body: Column(
          children: [
            const SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(children: [
                Flexible(
                  flex: 2,
                  child: Row(
                    children: [
                      const Icon(Icons.event_note_rounded, size: 30),
                      const SizedBox(width: 15),
                      Text('Your projects',
                          style: Theme.of(context).textTheme.titleMedium),
                    ],
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    context.push('/project_post/step_01');
                  },
                  child: Text('Post a job',
                      style: Theme.of(context)
                          .textTheme
                          .titleSmall!
                          .copyWith(color: Colors.white, fontSize: 18)),
                ),
              ]),
            ),
            const SizedBox(height: 15),
            Expanded(
              child: DefaultTabController(
                  length: 3,
                  child: Column(
                    children: [
                      TabBar(
                        labelColor:
                            primaryColor, // Set the color of the selected tab label
                        labelStyle: Theme.of(context)
                            .textTheme
                            .titleSmall!
                            .copyWith(fontWeight: FontWeight.w600), //
                        unselectedLabelStyle:
                            const TextStyle(fontWeight: FontWeight.w500),
                        indicator: const BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: primaryColor, // Border color
                              width: 2, // Border width
                            ),
                          ),
                        ),
                        tabs: const [
                          Tab(
                              text:
                                  'All projects'), // Define your tab labels here
                          Tab(text: 'Working'),
                          Tab(text: 'Archived'),
                        ],
                      ),
                      const Expanded(
                        child: TabBarView(
                          children: [
                            Center(
                                child:
                                    Text('Welcome, Khoa!\nYou have no jobs')),
                            Center(
                                child:
                                    Text('Welcome, Khoa!\nYou have no jobs')),
                            Center(
                                child:
                                    Text('Welcome, Khoa!\nYou have no jobs')),
                          ],
                        ),
                      ),
                    ],
                  )),
            ),
          ],
        ));
  }
}
