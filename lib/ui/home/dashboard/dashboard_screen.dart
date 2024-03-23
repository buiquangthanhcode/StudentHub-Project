import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:studenthub/constants/app_theme.dart';
import 'package:studenthub/constants/colors.dart';
import 'package:studenthub/ui/home/dashboard/widget/tab/project_all_tab.dart';
import 'package:studenthub/ui/home/dashboard/widget/tab/project_archived_tab.dart';
import 'package:studenthub/ui/home/dashboard/widget/tab/project_working_tab.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key, required this.welcome});
  final String welcome;

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.welcome == 'true') {
        showWelcomeDialog(context);
      }
    });
  }

  void showWelcomeDialog(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    var colorTheme = Theme.of(context).colorScheme;
    var screenSize = MediaQuery.of(context).size;

    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              backgroundColor: Colors.white,
              contentPadding: EdgeInsets.zero,
              content: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                width: screenSize.width * 0.8,
                height: screenSize.height * 0.5,
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(15))),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Spacer(),
                    Image.asset(
                      'lib/assets/images/welcome_image_dialog.png',
                      width: screenSize.width * 0.5,
                    ),
                    const Spacer(
                      flex: 2,
                    ),
                    Text(
                      'Welcome to Student Hub',
                      style: textTheme.bodyLarge,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Start searching and implementing real-world projects right now!',
                      textAlign: TextAlign.center,
                      style:
                          textTheme.bodySmall!.copyWith(color: colorTheme.grey),
                    ),
                    const Spacer(),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(double.infinity, 56),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        'Get Started!',
                        style: textTheme.bodyMedium!.copyWith(
                            color: Colors.white, fontWeight: FontWeight.w600),
                      ),
                    ),
                  ],
                ),
              ),
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      bottom: false,
      child: Column(
        children: [
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(children: [
              Flexible(
                flex: 2,
                child: Row(
                  children: [
                    // const Icon(Icons.event_note_rounded, size: 30),
                    // const SizedBox(width: 15),
                    Text(
                      'Your projects',
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge!
                          .copyWith(fontWeight: FontWeight.w700),
                    ),
                  ],
                ),
              ),
              ElevatedButton.icon(
                onPressed: () {
                  // context.push('/project_post/step_01');
                  context.push('/home/project_post/step_01');
                },
                icon: const FaIcon(FontAwesomeIcons.plus, size: 18),
                label: const Text(
                  'Post a job',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              )
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
                      unselectedLabelStyle: Theme.of(context)
                          .textTheme
                          .titleSmall!
                          .copyWith(fontWeight: FontWeight.w600),
                      indicator: const BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: primaryColor, // Border color
                            width: 2, // Border width
                          ),
                        ),
                      ),

                      tabs: const [
                        Tab(text: 'All projects'),
                        Tab(text: 'Working'),
                        Tab(text: 'Archived'),
                      ],
                    ),
                    const Expanded(
                      child: TabBarView(
                        children: [
                          ProjectAllTab(),
                          ProjectWorkingTab(),
                          ProjectArchivedTab(),
                        ],
                      ),
                    ),
                  ],
                )),
          ),
        ],
      ),
    ));
  }
}
