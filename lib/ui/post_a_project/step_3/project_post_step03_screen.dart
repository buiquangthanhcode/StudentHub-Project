import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:studenthub/constants/colors.dart';
import 'package:studenthub/widgets/bulletWidget.dart';

class ProjectPostStep03 extends StatelessWidget {
  const ProjectPostStep03({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        title: Text("Write project description",
            style: Theme.of(context).textTheme.titleSmall!.copyWith(
                  fontSize: 18,
                )),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: CircularPercentIndicator(
              animation: true,
              // animationDuration: 10000,
              radius: 60,
              lineWidth: 6,
              percent: 0.75,
              progressColor: const Color(0xff3961FB),
              backgroundColor: const Color(0xff3961FB).withOpacity(0.2),
              circularStrokeCap: CircularStrokeCap.round,
              center: Text(
                '3 of 4',
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
            const Text(
              "This helps your post stand out to the right students. It's the first thing they'll see, so make it impressive!",
              maxLines: 3,
            ),
            const SizedBox(height: 24),
            TextField(
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium, // Adjust the font size as needed
              decoration: InputDecoration(
                hintText: 'Write a title for your post',
                hintStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: const Color.fromARGB(255, 149, 148, 148),
                    ),
                border: const OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.black,
                    width: 4.0,
                  ),
                ),
                contentPadding: const EdgeInsets.symmetric(
                    vertical: 8,
                    horizontal: 12 // Adjust the vertical padding as needed
                    ),
              ),
              onChanged: (value) {
                // print('Input value: $value');
              },
            ),
            const SizedBox(height: 24),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Example titles',
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                ),
                BulletList(const [
                  'Building responsive WordPress site with booking / payment functionality',
                  'Facebook ad specialist need for product launch',
                ])
              ],
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                context.push('/project_post/step_02');
              },
              style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                      vertical: 16), // Adjust padding as needed
                  minimumSize:
                      const Size(double.infinity, 48) // Set minimum button size
                  ),
              child: Text(
                'Continue',
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
