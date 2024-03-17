import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:studenthub/constants/colors.dart';
import 'package:studenthub/widgets/bulletWidget.dart';

class ProjectPostStep04 extends StatelessWidget {
  const ProjectPostStep04({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        title: Text(
          "Review your post",
          style: Theme.of(context).textTheme.titleSmall!.copyWith(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: CircularPercentIndicator(
              animation: true,
              // animationDuration: 10000,
              radius: 60,
              lineWidth: 6,
              percent: 1.0,
              progressColor: const Color(0xff3961FB),
              backgroundColor: const Color(0xff3961FB).withOpacity(0.2),
              circularStrokeCap: CircularStrokeCap.round,
              center: Text(
                '4 of 4',
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      fontSize: 13,
                    ),
              ),
            ),
          )
        ],
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
        child: Column(
          children: [
            Column(
              children: [
                Text(
                  'Facebook ad specialist need for product launch',
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(height: 12),
                const Divider(
                  color: Colors.grey, // Set the color of the divider
                  thickness: 2, // Set the thickness of the divider
                  height: 20, // Set the height of the divider
                  // indent:
                  //     10, // Set the amount of empty space before the divider
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Students are looking for',
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                    BulletList(const [
                      'Clear expectation about your project or deliverables',
                      'The skill required for your project',
                      'Detail about your project',
                    ]),
                  ],
                ),
                const Divider(
                  color: Colors.grey, // Set the color of the divider
                  thickness: 2, // Set the thickness of the divider
                  height: 20, // Set the height of the divider
                  // indent:
                  //     10, // Set the amount of empty space before the divider
                ),
              ],
            ),
            const SizedBox(height: 24),
            Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(Icons.access_alarm, size: 42),
                    Container(
                      margin: const EdgeInsets.only(left: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Project scope'),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Padding(
                                padding: EdgeInsets.all(8),
                                child: FaIcon(
                                  FontAwesomeIcons.solidCircle,
                                  size: 6,
                                ),
                              ),
                              Text(
                                '3-6 months',
                                style: Theme.of(context).textTheme.bodySmall!,
                              ),
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(Icons.people, size: 42),
                    Container(
                      margin: const EdgeInsets.only(left: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Student required'),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Padding(
                                padding: EdgeInsets.all(8),
                                child: FaIcon(
                                  FontAwesomeIcons.solidCircle,
                                  size: 6,
                                ),
                              ),
                              Text(
                                '6 students',
                                style: Theme.of(context).textTheme.bodySmall!,
                              ),
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ],
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                context.push('/my_dashboard');
              },
              style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                      vertical: 16), // Adjust padding as needed
                  minimumSize:
                      const Size(double.infinity, 48) // Set minimum button size
                  ),
              child: Text(
                'Post a job',
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: Colors.white,
                    ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
