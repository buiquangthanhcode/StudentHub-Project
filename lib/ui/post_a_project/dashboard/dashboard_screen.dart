import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:studenthub/constants/colors.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Row(children: [
            const Icon(Icons.event_note_rounded, size: 30),
            const SizedBox(width: 5),
            Text('Your projects', style: Theme.of(context).textTheme.bodyLarge),
          ]),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 24),
              child: ElevatedButton(
                onPressed: () {
                  // Perform action here
                },
                child: const Text('Post a job'),
              ),
            ),
          ],
        ),
        body: Column(
          children: [
            SizedBox(height: 15),
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
