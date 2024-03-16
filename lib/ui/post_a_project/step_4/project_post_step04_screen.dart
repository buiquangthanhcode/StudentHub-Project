import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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
        title: Text("Review your post",
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Students are looking for',
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                ),
                BulletList(const [
                  'Clear expectation about your project or deliverables',
                  'The skill required for your project',
                  'Detail about your project',
                ])
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Describe your project',
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                  // textAlign: TextAlign.left,
                ),
                const SizedBox(height: 12),
                TextField(
                  cursorHeight: 20,
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium, // Adjust the font size as needed
                  maxLines: null, // Allows multiple lines
                  minLines: 6,
                  keyboardType: TextInputType.multiline,
                  textInputAction: TextInputAction
                      .newline, // Use 'newline' action for 'Done' button
                  decoration: InputDecoration(
                    hintStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: const Color.fromARGB(255, 149, 148, 148),
                        ),
                    border: const OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.black,
                        width: 4.0,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                context.push('/project_post/step_04');
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
